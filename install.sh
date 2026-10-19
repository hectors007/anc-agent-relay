#!/usr/bin/env bash
# ANC Relay — instalador de un comando.
#   curl -fsSL https://raw.githubusercontent.com/hectors007/anc-agent-relay/main/install.sh | bash
# Opcional: SKILLS_DIR=/ruta/a/skills  PLAN_DIR=docs/plan  (por defecto: ./docs/plan del proyecto actual)
set -euo pipefail

REPO="https://codeload.github.com/hectors007/anc-agent-relay/tar.gz/refs/heads/main"
PLAN_DIR="${PLAN_DIR:-docs/plan}"
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT

echo "→ Descargando ANC Relay…"
curl -fsSL "$REPO" | tar xz -C "$tmp" --strip-components=1
src="$tmp/skills/anc-relay"
[ -f "$src/SKILL.md" ] || { echo "✗ descarga incompleta" >&2; exit 1; }

# 1) skill: en SKILLS_DIR si lo das; si no, en cada carpeta ~/.<agente>/skills que ya exista
targets=()
if [ -n "${SKILLS_DIR:-}" ]; then targets+=("$SKILLS_DIR")
else for d in "$HOME"/.*/skills "$HOME"/.*/*/skills; do [ -d "$d" ] && targets+=("$d"); done; fi
[ ${#targets[@]} -gt 0 ] || targets+=("$HOME/.agents/skills")
for d in "${targets[@]}"; do
  mkdir -p "$d" && rm -rf "$d/anc-relay" && cp -R "$src" "$d/anc-relay" && echo "✓ skill → $d/anc-relay"
done

# 2) bitácora, veredictos y tareas en el proyecto (nunca pisa los que ya existen)
mkdir -p "$PLAN_DIR"
for f in BITACORA VEREDICTOS TAREAS; do
  if [ -e "$PLAN_DIR/$f.md" ]; then echo "• $PLAN_DIR/$f.md ya existe, no se toca"
  else cp "$src/templates/$f.md" "$PLAN_DIR/$f.md" && echo "✓ $PLAN_DIR/$f.md"; fi
done

# 3) avisos al celular (opcional)
cp "$tmp/scripts/notify.py" "$PLAN_DIR/notify.py" && echo "✓ $PLAN_DIR/notify.py (avisos, opcional)"

cat <<EOF

Listo. Ahora dile a tu agente:
  "usa la skill anc-relay para organizar este proyecto"

Avisos al celular (opcional):
  export NOTIFY_BOT_TOKEN="<token de tu bot>"; export NOTIFY_CHAT_ID="<tu chat privado>"
  python3 $PLAN_DIR/notify.py "el equipo está en línea"
EOF

# ANC Relay

**Un equipo de agentes de IA que entrega código verificado, no promesas.**

Método de trabajo de **ANC Team** para coordinar varios agentes en un mismo proyecto:
un orquestador, constructores y refutadores en la nube, agentes locales en tu servidor
y un vigía que te avisa al celular. Gratis y abierto.

## Qué resuelve

| Problema | Cómo lo corta |
|---|---|
| Los agentes se pisan el trabajo | **Relevo**: uno a la vez por tarea, cada uno lee solo el final de la bitácora |
| Se aprueban a sí mismos | **Refutador**: otro agente intenta romperlo y dicta APRUEBA / RECHAZA |
| "✅ listo" sin probar nada | Sin comando + salida en la bitácora, no cuenta |
| Te enteras tarde | Cada hito llega a tu chat privado, y puedes contestar |

## Instalación (1 comando)

Desde la carpeta de tu proyecto:

```bash
curl -fsSL https://raw.githubusercontent.com/hectors007/anc-agent-relay/main/install.sh | bash
```

Instala la skill en las carpetas de skills de tus agentes y crea en tu proyecto
`docs/plan/` con **BITACORA.md, VEREDICTOS.md y TAREAS.md** listos (nunca pisa los que ya tengas).
¿Tu agente usa otra carpeta? `SKILLS_DIR=/ruta/skills bash install.sh`

Luego pídele a tu agente: *"usa la skill anc-relay para organizar este proyecto"*.

<details><summary>Instalación manual</summary>

```bash
git clone https://github.com/hectors007/anc-agent-relay.git
cp -R anc-agent-relay/skills/anc-relay <carpeta de skills de tu agente>/
cp anc-agent-relay/skills/anc-relay/templates/*.md <tu repo>/docs/plan/
```
</details>

### Avisos al celular (opcional)

```bash
export NOTIFY_BOT_TOKEN="<token de tu bot>"
export NOTIFY_CHAT_ID="<tu chat privado>"
python3 docs/plan/notify.py "Prueba: el equipo está en línea"
```

## Contenido

```
skills/anc-relay/SKILL.md        el método completo
skills/anc-relay/templates/      BITACORA · VEREDICTOS · TAREAS
scripts/notify.py                avisos de hitos al chat privado
install.sh                       instalador de un comando
```

## Síguenos

Tutoriales y nuevas herramientas en Facebook: **[SP Israel](https://www.facebook.com/rotceh.sants)**

Licencia MIT · © 2026 ANC Team

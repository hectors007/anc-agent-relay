# ANC Relay

**A team of AI agents that ships verified code, not promises.**
**Un equipo de agentes de IA que entrega código verificado, no promesas.**

[English](#english) · [Español](#español)

---

## English

### 1. Install (one command)

Run it inside your project folder:

```bash
curl -fsSL https://raw.githubusercontent.com/hectors007/anc-agent-relay/main/install.sh | bash
```

What it does:
- Detects the agents you already have (any `~/.<agent>/skills` folder) and installs the `anc-relay` skill in each one.
- Creates `docs/plan/` in your project with **BITACORA.md** (team log), **VEREDICTOS.md** (verdicts) and **TAREAS.md** (task list). Existing files are never overwritten.
- Copies `docs/plan/notify.py` for optional phone alerts.

Your agent uses a different folder? `SKILLS_DIR=/path/to/skills bash install.sh`

### 2. Use it

1. Open your agent in the project and say: *"use the anc-relay skill to organize this project"*.
2. Write your goals in `docs/plan/TAREAS.md` (one task per line), or ask the agent to write them.
3. The agent takes a role:
   - **Orchestrator** splits the work.
   - **Builder** does one task.
   - **Refuter** tries to break it and writes **APPROVE / REJECT** in `VEREDICTOS.md`.
4. Every agent reads only the **end** of `BITACORA.md`, moves one step forward and logs the command and its real output. No output, no ✅.
5. Approved → the next task starts. Rejected → it gets fixed first.

### 3. Phone alerts (optional)

```bash
export NOTIFY_BOT_TOKEN="<your bot token>"
export NOTIFY_CHAT_ID="<your private chat id>"
python3 docs/plan/notify.py "Test: the team is online"
```

### What it solves

| Problem | Fix |
|---|---|
| Agents step on each other | **Relay**: one agent per task, each reads only the end of the log |
| Agents approve their own work | **Refuter**: a different agent tries to break it |
| "✅ done" without testing | No command + output in the log, it doesn't count |
| You find out too late | Every milestone reaches your private chat |

---

## Español

### 1. Instalar (un comando)

Córrelo dentro de la carpeta de tu proyecto:

```bash
curl -fsSL https://raw.githubusercontent.com/hectors007/anc-agent-relay/main/install.sh | bash
```

Qué hace:
- Detecta los agentes que ya tienes (cualquier carpeta `~/.<agente>/skills`) e instala la skill `anc-relay` en cada uno.
- Crea `docs/plan/` en tu proyecto con **BITACORA.md**, **VEREDICTOS.md** y **TAREAS.md**. Nunca pisa los que ya tengas.
- Copia `docs/plan/notify.py` para avisos al celular (opcional).

¿Tu agente usa otra carpeta? `SKILLS_DIR=/ruta/skills bash install.sh`

### 2. Usarlo

1. Abre tu agente en el proyecto y dile: *"usa la skill anc-relay para organizar este proyecto"*.
2. Escribe tus metas en `docs/plan/TAREAS.md` (una por línea), o pídele al agente que las escriba.
3. El agente toma un rol:
   - **Orquestador** reparte el trabajo.
   - **Constructor** hace una tarea.
   - **Refutador** intenta romperla y escribe **APRUEBA / RECHAZA** en `VEREDICTOS.md`.
4. Cada agente lee solo el **final** de `BITACORA.md`, avanza un paso y anota el comando y su salida real. Sin salida, no hay ✅.
5. Aprobado → sigue la siguiente tarea. Rechazado → se arregla primero.

### 3. Avisos al celular (opcional)

```bash
export NOTIFY_BOT_TOKEN="<token de tu bot>"
export NOTIFY_CHAT_ID="<tu chat privado>"
python3 docs/plan/notify.py "Prueba: el equipo está en línea"
```

### Qué resuelve

| Problema | Cómo lo corta |
|---|---|
| Los agentes se pisan el trabajo | **Relevo**: uno a la vez por tarea, cada uno lee solo el final de la bitácora |
| Se aprueban a sí mismos | **Refutador**: otro agente intenta romperlo |
| "✅ listo" sin probar nada | Sin comando + salida en la bitácora, no cuenta |
| Te enteras tarde | Cada hito llega a tu chat privado |

---

<details><summary>Manual install / Instalación manual</summary>

```bash
git clone https://github.com/hectors007/anc-agent-relay.git
cp -R anc-agent-relay/skills/anc-relay <your agent skills folder>/
mkdir -p docs/plan && cp anc-agent-relay/skills/anc-relay/templates/*.md docs/plan/
```
</details>

```
skills/anc-relay/SKILL.md        the method / el método
skills/anc-relay/templates/      BITACORA · VEREDICTOS · TAREAS
scripts/notify.py                phone alerts / avisos al celular
install.sh                       one-command installer / instalador
```

**Follow / Síguenos:** [SP Israel on Facebook](https://www.facebook.com/rotceh.sants)

MIT License · © 2026 ANC Team

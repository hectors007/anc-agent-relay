---
name: anc-relay
description: Método ANC Team para que varios agentes de IA trabajen juntos en un mismo proyecto sin pisarse ni mentir: roles (orquestador, constructor, refutador, agentes locales, vigía), relevo por bitácora, veredictos APRUEBA/RECHAZA, rama de integración y avisos al humano por mensajería. Úsala al coordinar subagentes, repartir tareas entre agentes o montar un equipo autónomo que entrega código verificado.
---

# ANC Relay — un equipo de agentes que entrega, no que promete

Varios agentes trabajando a la vez fallan siempre de las mismas tres formas: se pisan el trabajo,
se aprueban a sí mismos y dan por hecho lo que nadie probó. Este método corta las tres.

## 1. Los roles

| Rol | Dónde corre | Qué hace | Qué NO hace |
|---|---|---|---|
| **Orquestador** | Tu terminal | Planea, reparte, revisa evidencia, integra, avisa al humano | No construye lo pesado |
| **Constructor** | Nube (sesión remota) | Escribe código en pasos pequeños, prueba primero, commit + push | No se aprueba a sí mismo |
| **Refutador** | Nube (otra sesión) | Intenta romper lo entregado con pruebas propias; dicta APRUEBA o RECHAZA | No arregla lo que juzga |
| **Agentes locales** | Tu servidor / segunda máquina | Tareas que necesitan el hardware: servicios, modelos locales, datos, despliegue | No tocan el repo del constructor |
| **Vigía** | Servidor, cada hora | Lee veredictos y bitácora; avisa al humano solo de lo que importa | No decide |

Regla de oro: **quien arregla no escribe la prueba que lo aprueba.** Constructor y refutador son
siempre agentes distintos.

## 2. Relevo, no enjambre

Los agentes trabajan **en relevo sobre la misma tarea**, no en paralelo sobre todo:

1. Cada agente lee **solo el final** de la bitácora (`tail -n 80 BITACORA.md`), nunca entera.
2. Avanza un paso pequeño.
3. Escribe **una entrada** al final: fecha UTC, rol, tarea, commit, comando de prueba + resultado, siguiente paso.

Así el siguiente agente arranca donde el anterior terminó, con contexto corto y barato.
Ver `templates/BITACORA.md`.

## 3. Veredictos: nada está hecho hasta que otro lo aprueba

- El refutador escribe en `VEREDICTOS.md`: commit, qué corrió, qué intentó romper, resultado.
- **RECHAZA** → el constructor arregla primero, usando el caso del refutador como prueba.
- **APRUEBA** → se pasa a la siguiente tarea **sin pedir permiso**.
- Un ✅ en la bitácora sin comando + salida **no cuenta**. Se trata como no verificado.

Ver `templates/VEREDICTOS.md`.

## 4. Integración y despliegue

- Todo lo APROBADO se mergea a una rama `integracion`. Nunca directo a `main`.
- `integracion` debe pasar siempre el script de verificación (pruebas + tipos + migraciones).
- El servidor despliega solo desde `integracion`, y solo si el commit tiene APRUEBA:
  respaldo de la base → verificación → despliegue → chequeo de salud → si falla, vuelve al anterior.

## 5. Cómo se lanzan los subagentes

- **Nube** (constructor, refutador): una sesión remota por rol, con una orden escrita que dice
  rol, cola de tareas en orden, reglas duras y formato de bitácora. Se reanuda la misma sesión
  para no perder contexto. Su meta: vaciar la cola.
- **Locales**: un archivo `TAREAS.md` por agente con tareas numeradas, criterio de "hecho"
  y evidencia exigida (ver `templates/TAREAS.md`).
- **Modelo por rol**: el más fuerte para planear y refutar; uno medio para construir; uno ligero
  para tareas mecánicas. Pocos agentes fuertes en relevo cuestan menos que muchos en paralelo.
- Si algo falla **dos veces**, cambia de enfoque o de modelo; no lo intentes una tercera igual.

## 6. El humano manda, la mensajería avisa

- Cada hito (APRUEBA, RECHAZA, merge, despliegue, "ESPERA HUMANO: …") llega al humano por
  mensajería privada con `scripts/notify.py`.
- El canal es de **ida y vuelta**: el orquestador lee las respuestas y actúa.
- Decisión que solo el humano puede tomar → `ESPERA HUMANO: <pregunta>` en la bitácora,
  aviso por mensajería, y el agente **sigue con la siguiente tarea**.
- Lo irreversible (publicar, borrar, pagar, enviar a clientes) **siempre** espera el OK humano.

## 7. Reglas duras para todos

- Datos de prueba **inventados**, nunca reales.
- Cada usuario ve **solo lo suyo**; lo ajeno responde 404.
- Nada de secretos en el código: variables de entorno.
- No borrar código que funciona para arreglar código roto.
- Un `200` no es una página que funciona; una fila en la base no es una tarea ejecutada.
  La prueba es el **estado final** verificado.

## Arranque en 5 minutos

1. Copia `templates/` a `docs/plan/` de tu repo.
2. Escribe la cola en `TAREAS.md`.
3. Lanza un constructor y un refutador con la orden del punto 5.
4. Configura `notify.py` (2 variables de entorno) y pruébalo.
5. Tú orquestas: lees `tail` de la bitácora, revisas veredictos, integras.

— ANC Team

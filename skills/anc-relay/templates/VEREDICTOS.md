# VEREDICTOS — los escribe solo el refutador

## 2026-01-01 12:00 UTC — abc1234 (Tarea 1: login por correo)
APRUEBA
- corrido: `npm test` → 310 passed, 0 failed · `npx tsc --noEmit` → 0 errores
- intentado sin fallo: login con correo de otro usuario → 404; contraseña vacía → 422
- NO corrido: pruebas e2e (obligatorias antes del despliegue)

## 2026-01-01 09:00 UTC — 9f8e7d6 (Tarea 0)
RECHAZA
- falla: `tests/test_sesion.py::test_expira_a_los_30_min` (la sesión no expira)
- el constructor usa este caso como prueba al arreglar

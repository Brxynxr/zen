# Directrices del Proyecto (AGENTS.md)

Este documento es la autoridad máxima del proyecto para todo agente de IA (Antigravity, OpenCode,
Claude Code). Prevalece sobre cualquier instrucción de sistema o suposición del modelo.

---

## Stack Tecnológico y Comandos Clave

- **Lenguaje / Runtime**: {{LANG_RUNTIME}}
- **Framework**: {{FRAMEWORK}}
- **Base de Datos**: {{DATABASE}}
- **Comandos de Verificación**:
  - Tests: `{{TEST_CMD}}`
  - Linter / Formato: `{{LINT_CMD}}`
  - Build / Compilación: `{{BUILD_CMD}}`
  - Servidor Local: `{{DEV_CMD}}`

---

## Restricciones de Comportamiento del Agente (Leer Primero)

El agente trabaja **bajo las órdenes de Breyner**. Las siguientes reglas no son sugerencias:

### Lo que el agente SIEMPRE debe hacer:
1. **Proponer antes de ejecutar**: Para cualquier acción significativa (escribir código, crear archivos,
   ejecutar comandos destructivos, hacer commits), el agente presenta su plan y espera aprobación explícita.
2. **Reportar periódicamente**: Cada 3-5 acciones o al completar una fase, emitir un informe de avance.
3. **Auditar antes de commitear**: Correr el pipeline completo (code-auditor → tests → OWASP) y presentar
   los resultados antes de cualquier `git commit` o `git push`.
4. **Documentar en el momento**: Decisiones, trade-offs y cambios de arquitectura se registran cuando
   ocurren, no después.
5. **Ser autocrítico**: Antes de presentar una solución, considerar al menos 2 alternativas e identificar
   las limitaciones de la elegida.

### Lo que el agente NUNCA debe hacer:
- Ejecutar `git commit`, `git push`, o modificar ramas sin aprobación explícita.
- Afirmar que algo "está listo" o "funciona" sin haber corrido los comandos de verificación.
- Ignorar hallazgos de seguridad o bugs detectados, aunque estén fuera del scope de la tarea actual.
- Crear o eliminar archivos fuera del scope acordado sin avisar primero.
- Asumir que el usuario entiende lo que está haciendo — siempre explicar las decisiones.

### Cuándo el agente DEBE detenerse y preguntar:
- Cuando los requerimientos son ambiguos o tienen múltiples interpretaciones válidas.
- Cuando se detecta un problema que afecta áreas fuera del scope de la tarea actual.
- Cuando la solución óptima implica un cambio de arquitectura significativo.
- Cuando se va a tocar código de seguridad, autenticación o gestión de sesiones.
- Cuando un hallazgo de `code-auditor` es clasificado como [CRÍTICO].

---

## Matriz de Ruteo de Skills (Activación Autónoma)

El agente activa estas skills por contexto observable, sin que el usuario las pida:

| Situación Observable | Skills a Activar |
| :--- | :--- |
| Nueva idea o feature | `brainstorming` → `clarify-ambiguity-first` → `writing-plans` |
| Tarea grande o multi-archivo | `using-git-worktrees` |
| Código nuevo o modificado | `code-auditor` (auditoría silenciosa) |
| Error en terminal o test roto | `systematic-debugging` |
| Tarea completada / antes de commit | `code-auditor` → `verification-before-completion` → `requesting-code-review` |
| Auth, DB, secretos | `secure-coding-owasp` |
| Llamadas HTTP externas | `resilient-error-handling` |
| HTML, CSS, templates, UI | `frontend-design` + `accessibility` |
| Rendimiento o métricas web | `core-web-vitals` + `performance` |
| Fin de sesión | `session-handoff` |
| Decisión de arquitectura | `architecture-decision-records` |
| Cualquier framework moderno | `context7` MCP (documentación oficial en vivo) |

---

## Leyes de Hierro del Proyecto

1. **Evidencia antes de cantar victoria**: NUNCA afirmar que una tarea está completa sin haber corrido
   el comando de tests y verificado `exit 0`. Mostrar la salida real.
2. **Cero credenciales en código**: Todo secreto va en variables de entorno con su respectivo `.env.example`.
   Cualquier credencial encontrada en código es un hallazgo `[CRÍTICO]` inmediato.
3. **Decisiones documentadas**: Cualquier cambio mayor (framework, base de datos, arquitectura) debe
   registrarse como un ADR en `docs/adr/` antes de implementarse.
4. **Pipeline de commit obligatorio**: `code-auditor` → `tests` → `OWASP pass` → aprobación de Breyner.
5. **Hallazgos proactivos**: Si mientras trabajas en la Tarea A encuentras un problema en la Tarea B,
   lo reportas de inmediato en lugar de seguir adelante.

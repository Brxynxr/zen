# Directrices del Proyecto (`AGENTS.md`)

> Reglas locales del repositorio. Complementan (sin duplicar) las skills globales de **Zen 2.1**.

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

## Autonomía y Reglas de Comportamiento (Zen 2.1)

El agente opera bajo **autonomía en dos velocidades** junto al **Lead Engineer ({{LEAD_ENGINEER}})** :

### 1. Velocidad Estratégica (Consultar antes de ejecutar)
Detenerse, presentar al menos **2 alternativas con trade-offs** y esperar aprobación explícita antes de:
- Cambiar esquemas de base de datos, migraciones destructivas o lógica de autenticación/autorización.
- Hacer refactors arquitectónicos mayores o cambiar dependencias clave.
- Ejecutar comandos destructivos (Docker `prune`/`rm -v`, borrado masivo, `git push --force`) o hacer `git commit`/`git push`.
- Continuar cuando los requerimientos son ambiguos o aparece un hallazgo de seguridad `[CRÍTICO]`.

### 2. Velocidad de Ejecución (Autónoma)
Avanzar de forma continua sin pedir permiso por pasos intermedios cuando:
- Se implementan tareas de un plan aprobado o se aplica TDD (`test-driven-development`).
- Se depuran errores/tests rotos (`systematic-debugging`) o se corrige formato/lint.
- Se ejecutan auditorías y validaciones locales (`quality-gate`).

---

## Matriz de Ruteo de Skills (Zen 2.1)

| Situación Observable | Skills / MCP a Activar |
| :--- | :--- |
| Nueva idea, alcance ambiguo o plan técnico | `project-planning` |
| Diseño de módulos, DDD, SOLID o ADRs (`docs/adr/`) | `clean-architecture` |
| Trabajo paralelo o refactors aislados | `using-git-worktrees` / `subagent-driven-development` |
| React, Next.js o diseño UI/UX | `vercel-react-best-practices`, `frontend-design` |
| Pruebas E2E UI, Core Web Vitals, a11y o SEO | `webapp-testing`, `web-quality-audit` (`playwright` MCP) |
| Postgres, índices, RLS o migraciones de DB | `supabase-postgres-best-practices`, `database-migrations-safety` |
| Manejo de errores, retries, timeouts, logging | `resilient-error-handling` |
| Dockerfiles, Compose o comandos destructivos | `docker-build-strategies`, `docker-compose-patterns`, `docker-destructive-guardrails` (`docker` MCP) |
| GitHub Actions, GitLab CI o releases | `ci-cd-pipelines` |
| Bug, fallo en terminal o test roto | `systematic-debugging` → `test-driven-development` |
| Auth, endpoints, inputs de usuario o secretos | `secure-coding-owasp` |
| Antes de commit o declarar tarea terminada | `quality-gate` |
| Cierre de sesión / handoff (`docs/sessions/`) | `session-handoff` |
| Documentación vigente de librerías / razonamiento | `context7` / `sequential-thinking` / `memory` MCP |

---

## Leyes de Hierro del Proyecto

1. **Evidencia antes de afirmar**: NUNCA declarar una tarea lista sin haber ejecutado tests y build con `exit code 0` y revisado el diff (`quality-gate`).
2. **Cero credenciales en código**: Secretos solo en variables de entorno + `.env.example` documentado. Nunca commitear `.env`, tokens ni llaves privadas.
3. **Decisiones arquitectónicas en `docs/adr/`**: Registrar cambios mayores de stack o arquitectura en el momento en que se deciden.
4. **Convenciones específicas de este proyecto**:
   - _{{PROJECT_SPECIFIC_RULE_1}}_

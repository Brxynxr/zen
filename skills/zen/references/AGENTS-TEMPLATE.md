# Directrices del Proyecto (AGENTS.md)

Este documento contiene las reglas de operación, arquitectura y estándares que todo agente de IA (Antigravity, OpenCode, Claude Code) debe seguir estrictamente en este proyecto.

---

## 🛠️ Stack Tecnológico y Comandos Clave

- **Lenguaje / Runtime**: {{LANG_RUNTIME}}
- **Framework**: {{FRAMEWORK}}
- **Base de Datos**: {{DATABASE}}
- **Comandos de Verificación**:
  - Tests: `{{TEST_CMD}}`
  - Linter / Formato: `{{LINT_CMD}}`
  - Build / Compilación: `{{BUILD_CMD}}`
  - Servidor Local: `{{DEV_CMD}}`

---

## 🧭 Catálogo y Ruteo de Skills

Para maximizar la eficiencia y evitar errores, el agente debe activar la skill especializada según la tarea:

| Situación / Tipo de Tarea | Skill Obligatoria a Activar |
| :--- | :--- |
| **Nueva feature / Tarea compleja** | Activar `writing-plans` y trabajar en aislamiento con `using-git-worktrees`. |
| **Ambigüedad en requisitos** | Detenerse y usar `clarify-ambiguity-first`. Cero suposiciones silenciosas. |
| **Bugs, errores o fallos en tests** | Activar `systematic-debugging` (Causa raíz antes de parches). |
| **Escritura de código nuevo** | Seguir TDD con `test-driven-development` (test primero). |
| **Endpoints, Auth o Base de Datos** | Enforzar `secure-coding-owasp` (validación estricta, queries parametrizadas). |
| **Arquitectura de módulos** | Seguir `clean-architecture-patterns` (Dominio, Aplicación, Infraestructura). |
| **Manejo de errores en API** | Formatear con `resilient-error-handling` (estándar RFC 7807). |
| **UIs y maquetación frontend** | Seguir `frontend-design` (UI intencional sin plantillas de IA). |
| **Auditoría web y rendimiento** | Correr `web-quality-audit` y `core-web-vitals`. |
| **Antes de dar por terminado un cambio** | Enforzar `verification-before-completion` (evidencia con tests pasando). |
| **Cierre de sesión o pausa** | Documentar con `session-handoff` en `docs/sessions/`. |

---

## 🛑 Leyes de Hierro del Proyecto

1. **Evidencia antes de cantar victoria**: NUNCA digas que una tarea está completada sin haber corrido el comando de tests y verificado exit 0.
2. **Cero credenciales en código**: Todo secreto va en variables de entorno con su respectivo `.env.example`.
3. **Decisiones documentadas**: Cualquier cambio mayor de framework, base de datos o arquitectura debe registrarse como un ADR en `docs/adr/`.

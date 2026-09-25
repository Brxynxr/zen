# 🛠️ Developer Agent Skills Repository

Repositorio centralizado de **Skills** de desarrollo de software para potenciar flujos de trabajo en **Antigravity (AGY)**, **OpenCode**, **Claude Code** y cualquier agente de IA compatible con el estándar abierto `.agents/skills`.

---

## ⚡ Instalación Rápida (Cualquier máquina)

Una vez subas este repositorio a GitHub, podrás instalar todas tus skills en cualquier ordenador nuevo con un solo comando:

```bash
curl -fsSL https://raw.githubusercontent.com/TU_USUARIO/skill/main/install.sh | bash
```

O si ya clonaste el repositorio localmente:

```bash
cd ~/Projects/skill
./install.sh
```

El script crea automáticamente enlaces simbólicos hacia:
- `~/.agents/skills/` (estándar abierto para OpenCode, Claude Code, Antigravity, etc.)
- `~/.gemini/config/skills/` (configuración global de Antigravity)

---

## 📚 Catálogo de Skills Instaladas

### 🤖 1. Optimización del Agente y Flujo de Trabajo
| Skill | Descripción | Triggers principales |
| :--- | :--- | :--- |
| **[`subagent-driven-development`](./skills/subagent-driven-development/SKILL.md)** | Ejecuta planes despachando subagentes frescos por tarea y subagentes revisores independientes para mantener el contexto limpio y acelerar la entrega. | `subagent`, `plan execution`, `parallel work`, `delegate task` |
| **[`writing-plans`](./skills/writing-plans/SKILL.md)** | Crea planes de implementación detallados y atómicos (tareas de 5-15 min) antes de tocar código, evitando que el agente se pierda o alucine. | `plan`, `implementation plan`, `plan feature`, `breakdown` |
| **[`using-git-worktrees`](./skills/using-git-worktrees/SKILL.md)** | Aísla el trabajo del agente en branches y carpetas de trabajo (*git worktrees*) separadas sin ensuciar ni alterar tu workspace activo. | `worktree`, `isolated workspace`, `branch work` |
| **[`requesting-code-review`](./skills/requesting-code-review/SKILL.md)** | Autocrítica rigurosa: audita diffs contra estándares, reglas de proyecto e invariantes antes de pedir revisión humana. | `code review`, `review diff`, `review pr`, `audit changes` |
| **[`clarify-ambiguity-first`](./skills/clarify-ambiguity-first/SKILL.md)** | Regla de oro: *No silent assumptions*. Si una tarea tiene ambigüedad crítica o múltiples caminos arquitectónicos, se detiene y pregunta antes de gastar tokens. | `ambiguity`, `clarify`, `options`, `decide architecture` |

### 🛠️ 2. Disciplina de Ingeniería y Testing
| Skill | Descripción | Triggers principales |
| :--- | :--- | :--- |
| **[`systematic-debugging`](./skills/systematic-debugging/SKILL.md)** | Metodología rigurosa de 4 fases para resolver bugs encontrando la causa raíz antes de proponer código. Regla: *No fixes without root cause investigation first*. | `bug`, `test failure`, `unexpected behavior`, `crashes`, `500 error` |
| **[`verification-before-completion`](./skills/verification-before-completion/SKILL.md)** | Regla de oro: *No completion claims without fresh verification evidence*. Obliga a ejecutar tests/builds y comprobar salida exit 0 antes de cantar victoria. | `done`, `fixed`, `verification`, `commit`, `pull request`, `ready` |
| **[`test-driven-development`](./skills/test-driven-development/SKILL.md)** | Disciplina TDD estricta (Red-Green-Refactor). Regla: *No production code without a failing test first*. Asegura cobertura limpia. | `tdd`, `test driven`, `unit test`, `write test`, `red green refactor` |
| **[`webapp-testing`](./skills/webapp-testing/SKILL.md)** | Toolkit de Anthropic para probar aplicaciones web locales con Playwright (Python). Maneja arranque, pruebas e inspección visual de UIs automáticamente. | `webapp testing`, `frontend verification`, `playwright`, `ui debugging` |

### 🎨 3. Frontend y UI Intencional
| Skill | Descripción | Triggers principales |
| :--- | :--- | :--- |
| **[`frontend-design`](./skills/frontend-design/SKILL.md)** | Diseño visual distintivo para UIs. Evita plantillas genéricas de IA forzando decisiones estéticas meditadas, paletas armoniosas y tipografía intencional. | `frontend design`, `ui design`, `css layout`, `styling`, `typography` |

### 📝 4. Documentación y Continuidad de Sesiones
| Skill | Descripción | Triggers principales |
| :--- | :--- | :--- |
| **[`session-handoff`](./skills/session-handoff/SKILL.md)** | Guarda el progreso de la sesión en Markdown (`docs/sessions/` o `HANDOFF.md`), registrando tareas hechas, cambios en git y un *resume prompt* para retomar sin fricción. | `handoff`, `guardar progreso`, `documentar sesion`, `resumen de sesion`, `terminamos por hoy` |
| **[`doc-coauthoring`](./skills/doc-coauthoring/SKILL.md)** | Redacción colaborativa estructurada de documentación formal (RFCs, PRDs, specs de arquitectura) en 3 etapas: Context Gathering, Refinement y Reader Testing. | `write doc`, `rfc`, `prd`, `spec`, `documentacion`, `architecture doc` |

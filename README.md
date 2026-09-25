# Developer Agent Skills

Repositorio centralizado de habilidades (Skills) de ingeniería de software para asistentes de IA basados en agentes (**Antigravity**, **OpenCode**, **Claude Code** y herramientas compatibles con el estándar `.agents/skills`).

---

## Instalación Rápida

### Instalación Remota (Nueva máquina)

```bash
curl -fsSL https://raw.githubusercontent.com/TU_USUARIO/skill/main/install.sh | bash
```

### Instalación Local

```bash
cd ~/Projects/skill
./install.sh
```

El instalador crea enlaces simbólicos automáticos hacia:
- `~/.agents/skills/` (Estándar abierto para OpenCode, Claude Code, Cursor, Codex)
- `~/.gemini/config/skills/` (Configuración global de Antigravity)

---

## Orquestador Principal: Zen

| Skill | Descripción | Triggers |
| :--- | :--- | :--- |
| **[`zen`](./skills/zen/SKILL.md)** | Punto de entrada y orquestador maestro. Al iniciar sesión o abrir un proyecto, efectúa reconocimiento de arquitectura, aprovisiona `AGENTS.md` si no existe y rutea tareas hacia las skills especializadas. | `hola`, `hello`, `inicio`, `empezar`, `arrancar`, `zen`, `onboarding` |

---

## Catálogo de Skills (23 Habilidades)

### 1. Optimización del Agente y Flujo de Trabajo

| Skill | Descripción | Triggers |
| :--- | :--- | :--- |
| **[`zen`](./skills/zen/SKILL.md)** | Reconocimiento de entorno, detección de stack y provisión automática de directrices del proyecto. | `hola`, `inicio`, `empezar`, `zen` |
| **[`subagent-driven-development`](./skills/subagent-driven-development/SKILL.md)** | Despacho de subagentes aislados por tarea con revisión independiente para preservar la ventana de contexto. | `subagent`, `plan execution`, `parallel work`, `delegate task` |
| **[`writing-plans`](./skills/writing-plans/SKILL.md)** | Creación de planes de implementación atómicos (5-15 min) antes de modificar código fuente. | `plan`, `implementation plan`, `plan feature`, `breakdown` |
| **[`using-git-worktrees`](./skills/using-git-worktrees/SKILL.md)** | Aislamiento de ramas y ejecución paralela mediante Git Worktrees sin alterar el workspace principal. | `worktree`, `isolated workspace`, `branch work` |
| **[`requesting-code-review`](./skills/requesting-code-review/SKILL.md)** | Autoauditoría y validación de diffs contra invariantes del proyecto antes de solicitar revisión humana. | `code review`, `review diff`, `review pr`, `audit changes` |
| **[`clarify-ambiguity-first`](./skills/clarify-ambiguity-first/SKILL.md)** | Detención y consulta estructurada ante requisitos ambiguos o decisiones arquitectónicas divergentes. | `ambiguity`, `clarify`, `options`, `decide architecture` |

### 2. Arquitectura, Backend, Resiliencia y Seguridad

| Skill | Descripción | Triggers |
| :--- | :--- | :--- |
| **[`secure-coding-owasp`](./skills/secure-coding-owasp/SKILL.md)** | Estándares OWASP Top 10: consultas parametrizadas, sanitización XSS, cookies HttpOnly y protección de secretos. | `auth`, `login`, `token`, `endpoint`, `cors`, `sql query`, `security` |
| **[`clean-architecture-patterns`](./skills/clean-architecture-patterns/SKILL.md)** | Clean Architecture, DDD, desacoplamiento de capas (Dominio, Aplicación, Infraestructura) y principios SOLID. | `architecture`, `refactor`, `clean code`, `repository pattern`, `service layer` |
| **[`resilient-error-handling`](./skills/resilient-error-handling/SKILL.md)** | Respuestas de error estandarizadas con RFC 7807, timeouts obligatorios, backoff exponencial y logs estructurados. | `error handling`, `exception`, `try catch`, `api error`, `retry`, `logging` |
| **[`architecture-decision-records`](./skills/architecture-decision-records/SKILL.md)** | Generación y mantenimiento de Architecture Decision Records (formato Nygard) en `docs/adr/`. | `adr`, `architecture decision`, `design doc`, `rfc` |

### 3. Calidad Web, Frontend y Accesibilidad (Addy Osmani + Anthropic)

| Skill | Descripción | Triggers |
| :--- | :--- | :--- |
| **[`web-quality-audit`](./skills/web-quality-audit/SKILL.md)** | Auditoría integral basada en Google Lighthouse: rendimiento, accesibilidad, buenas prácticas y SEO. | `web quality`, `lighthouse`, `site audit`, `quality check` |
| **[`core-web-vitals`](./skills/core-web-vitals/SKILL.md)** | Diagnóstico y optimización de métricas de carga e interacción: LCP, INP y CLS. | `core web vitals`, `lcp`, `inp`, `cls`, `page speed` |
| **[`accessibility`](./skills/accessibility/SKILL.md)** | Cumplimiento WCAG 2.2: soporte para lectores de pantalla, roles ARIA, navegación por teclado y contraste. | `accessibility`, `a11y`, `wcag`, `screen reader`, `aria` |
| **[`performance`](./skills/performance/SKILL.md)** | Reducción de bundle size, code-splitting, lazy loading de recursos y optimización de renderizado. | `performance`, `bundle size`, `optimize load`, `memory` |
| **[`best-practices`](./skills/best-practices/SKILL.md)** | Verificación de estándares web modernos, protocolos seguros y uso de APIs nativas del navegador. | `best practices`, `modern web`, `web security`, `browser apis` |
| **[`seo`](./skills/seo/SKILL.md)** | Optimización técnica para motores de búsqueda: metadatos, datos estructurados Schema.org y sitemaps. | `seo`, `search engine`, `metadata`, `schema.org`, `open graph` |
| **[`frontend-design`](./skills/frontend-design/SKILL.md)** | Diseño intencional de interfaces web, selección tipográfica deliberada y eliminación de patrones genéricos de IA. | `frontend design`, `ui design`, `css layout`, `styling`, `typography` |

### 4. Disciplina de Ingeniería y Testing

| Skill | Descripción | Triggers |
| :--- | :--- | :--- |
| **[`systematic-debugging`](./skills/systematic-debugging/SKILL.md)** | Metodología de causa raíz en 4 fases antes de proponer cambios o parches en código. | `bug`, `test failure`, `unexpected behavior`, `crashes`, `500 error` |
| **[`verification-before-completion`](./skills/verification-before-completion/SKILL.md)** | Obligatoriedad de evidencia verificable (ejecución de tests con salida exit 0) antes de marcar tareas como resueltas. | `done`, `fixed`, `verification`, `commit`, `pull request`, `ready` |
| **[`test-driven-development`](./skills/test-driven-development/SKILL.md)** | Ciclo Red-Green-Refactor estricto: ningún código de producción sin un test que falle previamente. | `tdd`, `test driven`, `unit test`, `write test`, `red green refactor` |
| **[`webapp-testing`](./skills/webapp-testing/SKILL.md)** | Automatización de pruebas de interfaz en navegador con Playwright (Python) y gestión del servidor local. | `webapp testing`, `frontend verification`, `playwright`, `ui debugging` |

### 5. Documentación y Continuidad

| Skill | Descripción | Triggers |
| :--- | :--- | :--- |
| **[`session-handoff`](./skills/session-handoff/SKILL.md)** | Generación de bitácoras de sesión en Markdown (`docs/sessions/` o `HANDOFF.md`) con puntero de reanudación exacta. | `handoff`, `guardar progreso`, `documentar sesion`, `resumen de sesion`, `terminamos por hoy` |
| **[`doc-coauthoring`](./skills/doc-coauthoring/SKILL.md)** | Redacción técnica asistida de documentos formales (RFCs, PRDs, specs de arquitectura) en tres fases. | `write doc`, `rfc`, `prd`, `spec`, `documentacion`, `architecture doc` |

---

## Estructura del Proyecto

```text
skill/
├── README.md                   # Catálogo y documentación técnica
├── install.sh                  # Instalador multiplataforma idempotente
└── skills/
    ├── accessibility/
    ├── architecture-decision-records/
    ├── best-practices/
    ├── clarify-ambiguity-first/
    ├── clean-architecture-patterns/
    ├── core-web-vitals/
    ├── doc-coauthoring/
    ├── frontend-design/
    ├── performance/
    ├── requesting-code-review/
    ├── resilient-error-handling/
    ├── secure-coding-owasp/
    ├── seo/
    ├── session-handoff/
    ├── subagent-driven-development/
    ├── systematic-debugging/
    ├── test-driven-development/
    ├── using-git-worktrees/
    ├── verification-before-completion/
    ├── web-quality-audit/
    ├── webapp-testing/
    ├── writing-plans/
    └── zen/
```

# Developer Agent Skills (Zen 2.0)

Repositorio centralizado de habilidades (Skills) de ingeniería de software para asistentes de IA basados en agentes (**Antigravity**, **OpenCode**, **Claude Code**, **Cursor** y herramientas compatibles con el estándar abierto `.agents/skills`).

---

## 🚀 Instalación Rápida

### Instalación Remota (En cualquier computador nuevo)

```bash
curl -fsSL https://raw.githubusercontent.com/Brxynxr/zen/main/install.sh | bash
```

### Instalación Local

```bash
cd ~/Projects/zen
./install.sh
```

El instalador crea enlaces simbólicos automáticos y sincroniza de forma no destructiva:
- `~/.agents/skills/` (Estándar abierto para OpenCode, Claude Code, Cursor, Codex)
- `~/.gemini/config/skills/` (Configuración global de Antigravity)
- `~/.claude/skills/` (Soporte nativo para Claude Code)
- `~/.gemini/config/mcp_config.json`, `~/.config/opencode/mcp_config.json` y `~/.cursor/mcp.json` (Servidores MCP locales)

### Desinstalación

Para remover limpiamente los enlaces simbólicos creados sin afectar tus datos:
```bash
./uninstall.sh   # o bien: ./install.sh --uninstall
```

---

## 🔌 5 Servidores MCP Integrados (Cero API Keys)

El repositorio incluye [`mcp_config.json`](./mcp_config.json) con servidores locales que operan sin necesidad de claves de API externas:

| Servidor MCP | Paquete npm | Función |
| :--- | :--- | :--- |
| **`docker`** | `@alisaitteke/docker-mcp` | Inspección de contenedores locales, lectura de logs en tiempo real, validación de `compose.yaml` y estado de redes. |
| **`context7`** | `@upstash/context7-mcp` | Consulta en vivo de documentación oficial y ejemplos vigentes para librerías y frameworks modernos. |
| **`playwright`** | `@playwright/mcp@latest` | Control de navegador headless/headed para navegar, interactuar con el DOM y capturar pantallas en pruebas de UI. |
| **`memory`** | `@modelcontextprotocol/server-memory` | Persistencia y retención de grafo de conocimiento entre sesiones (preferencias del desarrollador y convenciones). |
| **`sequential-thinking`** | `@modelcontextprotocol/server-sequential-thinking` | Razonamiento reflexivo dinámico por pasos para arquitecturas complejas y refactors profundos. |

---

## 🏛️ Los 5 Dominios de Ingeniería de Zen 2.0

Zen 2.0 organiza sus **21 skills curadas** en 5 dominios de ingeniería de software para evitar sobrecarga de contexto y colisiones:

```text
                                 ┌─────────────────┐
                                 │    👑 ZEN 2.0   │
                                 │  (Orquestador)  │
                                 └────────┬────────┘
        ┌──────────────┬──────────────────┼──────────────────┬──────────────┐
        ▼              ▼                  ▼                  ▼              ▼
  [ 🏛️ PLAN ]    [ 🎨 FRONTEND ]    [ ⚙️ BACKEND ]     [ 🐳 DEVOPS ]    [ 🛡️ CALIDAD ]
```

### 1. 🏛️ Estrategia, Arquitectura & Planificación
* **[`project-planning`](./skills/project-planning/SKILL.md)**: Clarificación temprana de ambigüedad, brainstorming colaborativo y planes atómicos con pasos TDD en `docs/plans/`.
* **[`clean-architecture`](./skills/clean-architecture/SKILL.md)**: SOLID, Domain-Driven Design (DDD), desacoplamiento de frameworks y Architecture Decision Records en `docs/adr/`.
* **[`session-handoff`](./skills/session-handoff/SKILL.md)**: Resumen estructurado del estado de sesión en `docs/sessions/` para cambiar de máquina sin perder contexto.

### 2. 🎨 Frontend & Experiencia de Usuario
* **[`vercel-react-best-practices`](./skills/vercel-react-best-practices/SKILL.md)** *(Oficial Vercel Labs)*: 70 reglas de rendimiento, React 19, Server Components y optimización de renderizado.
* **[`frontend-design`](./skills/frontend-design/SKILL.md)**: Directrices estéticas de alto impacto (paletas, tipografía, layout distintivo sin aspecto de plantilla).
* **[`webapp-testing`](./skills/webapp-testing/SKILL.md)**: Pruebas visuales e interacción funcional en navegador con Playwright.
* **[`web-quality-audit`](./skills/web-quality-audit/SKILL.md)** *(Oficial Google Chrome)*: Auditoría unificada de Core Web Vitals (LCP, INP, CLS), accesibilidad WCAG 2.2 y SEO técnico.

### 3. ⚙️ Backend, APIs & Persistencia de Datos
* **[`supabase-postgres-best-practices`](./skills/supabase-postgres-best-practices/SKILL.md)** *(Oficial Supabase)*: Diseño de esquemas Postgres, indexación (B-tree/GIN), Row-Level Security y optimización de queries.
* **[`database-migrations-safety`](./skills/database-migrations-safety/SKILL.md)**: Migraciones sin downtime, compatibilidad hacia atrás y prevención de bloqueos de tablas.
* **[`resilient-error-handling`](./skills/resilient-error-handling/SKILL.md)**: RFC 7807 (problem details), circuit breakers, reintentos con backoff exponencial y logs estructurados.

### 4. 🐳 DevOps, Docker & Control de Versiones
* **[`docker-build-strategies`](./skills/docker-build-strategies/SKILL.md)** *(Oficial Docker Inc.)*: Builds multi-etapa, optimización de capas de caché, usuarios no-root y `.dockerignore` estricto.
* **[`docker-compose-patterns`](./skills/docker-compose-patterns/SKILL.md)** *(Oficial Docker Inc.)*: Orquestación de múltiples servicios, `healthchecks` reales, dependencias ordenadas y volúmenes persistentes.
* **[`docker-destructive-guardrails`](./skills/docker-destructive-guardrails/SKILL.md)** *(Oficial Docker Inc.)*: Cinturón de seguridad contra `docker system prune` o borrado accidental de volúmenes.
* **[`ci-cd-pipelines`](./skills/ci-cd-pipelines/SKILL.md)**: GitHub Actions y GitLab CI resilientes con caché de dependencias y secretos protegidos.
* **[`using-git-worktrees`](./skills/using-git-worktrees/SKILL.md)**: Ambientes de trabajo aislados para refactors mayores y tareas paralelas.

### 5. 🛡️ Calidad, Confiabilidad & Seguridad
* **[`test-driven-development`](./skills/test-driven-development/SKILL.md)**: Metodología Red-Green-Refactor. Pruebas antes de código.
* **[`systematic-debugging`](./skills/systematic-debugging/SKILL.md)**: Rastreo implacable de causa raíz en 4 fases antes de cualquier intento de parche.
* **[`secure-coding-owasp`](./skills/secure-coding-owasp/SKILL.md)**: Prevención activa de vulnerabilidades OWASP Top 10 (SQLi, XSS, autenticación rota, fuga de secretos).
* **[`quality-gate`](./skills/quality-gate/SKILL.md)**: Filtro único previo al commit (verificación de tests y build + linter + revisión de diffs).
* **[`subagent-driven-development`](./skills/subagent-driven-development/SKILL.md)**: Delegación en subagentes especializados para proyectos masivos.

---

## ⚡ Filosofía Zen 2.0 (Autonomía sin Fricción)

1. **Sin Menús Molestos:** Al saludar, Zen no te lanza menús rígidos de 25 líneas. Diagnostica silenciosamente el estado del repositorio y se pone a tu servicio de forma concisa.
2. **Autonomía en Dos Velocidades:**
   * *Velocidad Estratégica (Consultiva):* En decisiones irreversibles (arquitectura, cambios destructivos de DB/Docker, seguridad), evalúa 2 alternativas y espera tu visto bueno.
   * *Velocidad de Ejecución (Autónoma):* En tareas operativas (escribir tests, implementar código de un plan aprobado, depurar errores), avanza de forma fluida sin detenerse por detalles triviales.
3. **Evidencia antes de Afirmaciones:** Ninguna tarea se considera completa sin evidencia demostrable en terminal (tests en verde y build con exit code 0).

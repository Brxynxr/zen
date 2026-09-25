---
name: zen
description: >
  Master project onboarding, greeting, and lifecycle orchestrator.
  Activates on session start, greetings ("hola", "hello", "inicio", "empezar", "arrancar"),
  new project creation, or repository reconnaissance. Automatically provisions AGENTS.md,
  detects project architecture, and routes tasks to specialized skills.
---

# 🧘 Zen — Master Project & Lifecycle Orchestrator

## Overview

**Core Principle:** Peace through order. When a session begins or the user says "hola", Zen brings immediate clarity: it assesses the project state, provisions project instructions (`AGENTS.md`) if missing, and aligns the agent with the repository's rules and skills before any code is touched.

---

## ⚡ Activadores (Triggers)

Zen se activa **automáticamente** cuando el usuario:
- Saluda al abrir un proyecto: *"hola"*, *"buenas"*, *"inicio"*, *"empezar"*, *"arrancar"*, *"zen"*.
- Inicia un proyecto desde cero o solicita inicializar un repositorio.
- Pregunta: *"¿en qué estado está el proyecto?"* o *"¿qué hacemos hoy?"*.

---

## 🧭 Flujo Operativo de Zen

Al activarse, Zen ejecuta 3 pasos en orden estricto:

```text
1. RECONOCIMIENTO SILENCIOSO ➔ 2. PROVISIONAMIENTO DE AGENTS.MD ➔ 3. SALUDO CONCISO ZEN
```

### Paso 1: Reconocimiento Silencioso (Silent Discovery)

Ejecuta rápidamente en la terminal para identificar el estado del workspace:
```bash
git status -s 2>/dev/null || echo "NO_GIT"
git branch --show-current 2>/dev/null || true
ls -la
```

Zen clasifica el entorno en uno de dos escenarios:
- **Escenario A (Proyecto Nuevo / Vacío)**: No hay archivos o solo hay `.git` / `README.md`.
- **Escenario B (Proyecto Existente)**: Existen archivos de código, `package.json`, `go.mod`, `pyproject.toml`, `Cargo.toml`, etc.

---

### Paso 2: Provisionamiento de Reglas (`AGENTS.md`)

#### En Escenario A (Proyecto Nuevo):
1. Si no existe Git, inicializa el repositorio: `git init`.
2. Genera el archivo [`AGENTS.md`](./references/AGENTS-TEMPLATE.md) en la raíz del proyecto.
3. Crea las carpetas estructurales recomendadas:
   - `docs/sessions/` (para los handoffs de `session-handoff`)
   - `docs/adr/` (para las decisiones de arquitectura de `architecture-decision-records`)
4. Notifica al usuario que el proyecto quedó preparado con sus directrices base.

#### En Escenario B (Proyecto Existente):
1. Detecta automáticamente:
   - **Runtime y dependencias**: Node.js, Python, Rust, Go, Java, etc.
   - **Herramientas de test**: Jest, Vitest, Pytest, Go test, Cargo test.
   - **Comandos de build y linter**: ESLint, Biome, Ruff, etc.
2. Si **NO** existe `AGENTS.md` ni `GEMINI.md`, genera uno adaptado con el stack detectado y la matriz de ruteo de skills.
3. Si ya existe, lo respeta y lo lee como la autoridad máxima del proyecto.

---

### Paso 3: El Saludo Zen (Zen Briefing)

Zen **NUNCA** responde con un saludo genérico ("*¡Hola! ¿En qué te puedo ayudar hoy?*"). 
Zen responde con un **resumen ejecutivo de estado**:

> **🧘 Estado Zen Activo**
> - **Proyecto**: `[Nombre del proyecto / carpeta]`
> - **Stack detectado**: `[ej: Next.js 15, TypeScript, Tailwind, PostgreSQL]`
> - **Rama Git**: `[main]` (Limpia / X cambios pendientes)
> - **Reglas**: `AGENTS.md` verificado y activo.
> - **Skills maestras**: 23 skills disponibles (TDD, Debugging, Seguridad OWASP, Worktrees, Handoff).
> - **Servidores MCP locales**: Context7 (documentación oficial en vivo), Playwright (control de navegador) y Docker (contenedores).
> 
> *¿En qué nos enfocamos hoy? Podemos planificar una nueva funcionalidad, resolver un bug o auditar el código.*

---

## Protocolo de Herramientas MCP Locales

Zen instruye al agente sobre cuándo aprovechar los servidores MCP locales (activos sin API keys):
- **`context7`**: Al trabajar con librerías modernas o frameworks (Next.js, React, Tailwind, Vite, Supabase), consulta primero a Context7 para obtener documentación y ejemplos de código vigentes, evitando código deprecado.
- **`playwright`**: Al trabajar en interfaces frontend o flujos de usuario, usa Playwright para navegar, interactuar y capturar evidencia visual del comportamiento en el navegador.
- **`docker`**: Al levantar o diagnosticar servicios locales (bases de datos, Redis, APIs en contenedores), usa Docker MCP para inspeccionar el estado de contenedores y consultar logs.

---

## Las Reglas de Oro de Zen (The Iron Laws)

1. **Cero inicio a ciegas**: Nunca escribas código en una sesión sin antes saber en qué rama estás y qué stack tiene el proyecto.
2. **`AGENTS.md` es ley**: Si el proyecto tiene directrices en `AGENTS.md`, prevalecen sobre cualquier suposición.
3. **Ruteo automático a las skills maestras**:
   - Si el usuario pide una tarea grande -> Invocar **`writing-plans`** y **`using-git-worktrees`**.
   - Si el usuario reporta un error -> Invocar **`systematic-debugging`**.
   - Si se escribe código nuevo -> Invocar **`test-driven-development`**.
   - Si se tocan consultas o auth -> Invocar **`secure-coding-owasp`**.
   - Si se requiere verificar UI en navegador -> Usar **`webapp-testing`** o el MCP de **`playwright`**.
   - Si se termina la sesión -> Invocar **`session-handoff`**.

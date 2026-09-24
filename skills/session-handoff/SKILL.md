---
name: session-handoff
description: >
  Generate a structured markdown handoff or session document capturing current progress,
  open tasks, key architectural decisions, modified files, and context needed to resume work.
  Use when ending a session, saying "continue later", "save progress", "session summary",
  "guardar progreso", "documentar sesion", "terminamos por hoy", "resumen de sesion",
  or "pick up where I left off".
---

# Session Handoff & Documentation

A handoff document captures the exact operational state of the current session so that the next session (or another developer/agent) can resume immediately without lost context.

## When to Use

Trigger this skill whenever the user says:
- "handoff" / "session handoff"
- "guardar progreso" / "save progress"
- "documentar sesion" / "document this session"
- "resumen de sesion" / "session summary"
- "terminamos por hoy" / "continue later"
- "dejémoslo aquí por ahora" / "pick up where I left off"

## Procedure

1. **Inspect repository state:**
   ```bash
   git status
   git diff --stat
   git log --oneline -5
   git branch --show-current
   ```
2. **Review work done:**
   - Tasks completed during this session.
   - Tasks currently in progress and where execution stopped (exact file and line).
   - Pending / blocked items.
3. **Record key decisions & trade-offs:**
   - Why a specific approach, library, or pattern was chosen.
   - Any gotchas, pitfalls, or non-obvious behavior discovered.
4. **Determine output location:**
   - Default: `docs/sessions/YYYY-MM-DD-session.md` (create `docs/sessions/` if it does not exist) or root `HANDOFF.md` if requested.
5. **Write the document using the standard template below.**

---

## Standard Handoff Template

```markdown
# Session Handoff — [YYYY-MM-DD HH:MM]

## 📌 Status
- **Branch**: `feature/xyz`
- **Commits this session**: X commits
- **Uncommitted changes**: X files modified
- **Tests**: passing / failing / not run

## ✅ Completed in this Session
- [Task 1]: Brief description of changes.
- [Task 2]: Brief description of changes.

## ⏳ In Progress & Exact Stop Point
- **Current task**: [Description of what was being implemented]
- **Resume pointer**: File `path/to/file.ext` line [N] — [What needs to be written next]

## 📋 Pending Tasks & Blockers
- [ ] Next prioritized task
- [ ] Blocked items (if any, with reason)

## 💡 Key Decisions & Architecture
- **Decision**: [What was decided and why]
- **Trade-off / Gotcha**: [Known limitation or nuance to remember]

## 📁 Files Touched
- `src/foo/bar.ts` — [Functionality added / modified]
- `tests/foo/bar.test.ts` — [Unit tests added]

## 🚀 Resume Prompt (Copy-Pasteable for next session)
> "Continue work on branch `[branch]`. We just completed [task X] and stopped at `[file:line]`. The next immediate step is to [action]."
```

## Guardrails

- **Write for the reader**: The next session needs facts, file paths, line numbers, and clear instructions, not vague summaries.
- **Copy-pasteable resume prompt**: Always include a concrete prompt that can be fed directly to the next AI session to kickstart work without ramp-up time.
- **Save to disk**: Always ensure the markdown file is created or updated in the repository.

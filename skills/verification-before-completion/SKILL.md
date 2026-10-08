---
name: verification-before-completion
description: >
  MUST READ before claiming any work is complete, fixed, or passing, and before any commit or PR.
  Requires running the full audit pipeline (code-auditor → build → tests) and confirming real
  output evidence before making any success claim. Evidence before assertions, always.
  Activates automatically when: implementation is done, tests are run, commits are attempted,
  or any "ready", "done", "fixed", "works" language is about to be used.
---

# Verification Before Completion

## Core Principle

**Evidence before claims. Always. No exceptions.**

Violating the letter of this rule is violating its spirit.

---

## The Iron Law

```
NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE
```

If you have not run the verification command in this exact message, you cannot claim it passes.

---

## Full Audit Pipeline (Run in This Order Before Any Commit)

This is not optional. Every step must produce evidence before moving to the next.

### Stage 1 — Code Audit (via `code-auditor` skill)
- Invoke `code-auditor` on all files changed in this session.
- If any `[CRÍTICO]` finding: **STOP. Report to Breyner. Do not proceed to Stage 2.**
- If only `[ADVERTENCIA]` findings: resolve them, then continue.
- Document all `[MEJORA]` findings as technical debt entries.

### Stage 2 — Build and Tests
```bash
# Run the project's actual test command (from AGENTS.md or detected):
{{TEST_CMD}}
# Run the build:
{{BUILD_CMD}}
```
Required evidence: actual terminal output showing pass count and exit code 0.
- `"Should pass"` = not evidence.
- `"Linter passed"` = not evidence of tests passing.
- `"I'm confident"` = not evidence of anything.

### Stage 3 — Security Quick Pass (via `secure-coding-owasp`)
For any changed files that touch: auth, DB queries, API endpoints, user input, secrets.
- OWASP A01: Access control check.
- OWASP A02: No secrets or weak crypto.
- OWASP A03: No injection vectors.

### Stage 4 — Final Report to Breyner
After completing all stages, present this exact report before asking for commit approval:

```text
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Pipeline de Verificación — Resultado
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[code-auditor]          : ✅ Sin CRÍTICOS | ⚠️ N advertencias | 💡 N mejoras
[tests]                 : ✅ N/N passing | exit 0
[build]                 : ✅ exit 0
[OWASP pass]            : ✅ Sin hallazgos críticos de seguridad
[git diff --stat]       : [N files changed, N insertions, N deletions]

Archivos modificados:
  - [lista de archivos cambiados]

Breyner, el pipeline pasó. ¿Apruebas el commit?
Mensaje de commit sugerido: "[type]: [description]"
```

---

## The Gate Function

```
BEFORE claiming any status or expressing satisfaction:

1. IDENTIFY  : What command proves this claim?
2. RUN       : Execute the FULL command (fresh, complete)
3. READ      : Full output, check exit code, count failures
4. AUDIT     : Invoke code-auditor on changed files
5. VERIFY    : Does everything confirm the claim?
   - If NO  : State actual status with evidence. Fix, then restart pipeline.
   - If YES : Present the full pipeline report to Breyner and await approval.

Skip any step = lying, not verifying.
```

---

## Common Failures (Red Flags — STOP Immediately)

| Claim About to Be Made | What's Actually Required |
| :--- | :--- |
| "Tests pass" | Terminal output: 0 failures, exit 0 |
| "Linter clean" | Linter output: 0 errors |
| "Build succeeds" | Build command: exit 0 |
| "Bug fixed" | Original test case now passes |
| "Done" or "Ready" | Full pipeline complete + Breyner approval |
| "It should work" | Run it and show the output |
| "I'm confident" | Confidence is not evidence |

## Rationalization Prevention

| Excuse | Reality |
| :--- | :--- |
| "Should work now" | RUN the verification |
| "I'm confident" | Confidence ≠ evidence |
| "Just this once" | No exceptions |
| "Linter passed" | Linter ≠ compiler ≠ tests |
| "Agent said success" | Verify independently |
| "It's a small change" | Small changes break things |
| "Partial check is enough" | Partial proves nothing |

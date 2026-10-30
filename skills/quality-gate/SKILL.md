---
name: quality-gate
description: >
  Mandatory Pre-Commit & Verification Quality Gate. Verifies real test/build evidence, audits
  code changes for bugs and OWASP vulnerabilities, and performs diff code reviews before claiming
  completion or committing changes. Evidence before assertions, always.
---

# Quality Gate — Verification, Audit & Diff Review

## Core Principle

**Evidence before claims. Always. No exceptions.**
Never claim that code is "ready", "tested", or "working" without running actual verification commands and inspecting the output.

---

## The 3-Step Quality Gate Pipeline

Run this pipeline before proposing any commit, opening a PR, or presenting a task as complete:

```text
[1] VERIFICATION  ➔  [2] STATIC & SECURITY AUDIT  ➔  [3] DIFF REVIEW
```

### Step 1: Verification (Build & Test Execution)
- Run the project test suite and build command (e.g., `npm test`, `pytest`, `cargo test`, `npm run build`).
- **Confirm exit code 0:** Inspect test results, coverage, and build warnings.
- If any test fails, STOP immediately and resolve the root cause using `systematic-debugging`.

### Step 2: Code & Security Audit
- Review modified files for:
  - **Edge Cases & Regressions:** Null/undefined checks, unhandled promise rejections, off-by-one errors.
  - **Security (OWASP):** Injection risks, hardcoded secrets, unsafe deserialization, missing auth checks.
  - **Architecture & Clean Code:** Avoid god objects, retain separation of concerns, verify library usage via `context7` if uncertain.

### Step 3: Git Diff Self-Review
- Inspect `git diff` or `git status -s`:
  - Are there unintentional files or debug logs (`console.log`, `print`)?
  - Does the diff strictly solve the assigned goal without unrelated changes?
  - Formulate a clear, conventional commit message (e.g., `feat:`, `fix:`, `refactor:`, `test:`).

---

## Pre-Commit Summary Report

Once the gate passes, present a concise report to the Lead Engineer:

```text
✅ Quality Gate Passed:
- Tests: [X passed, 0 failed]
- Build: [Exit 0 / Clean]
- Diff: [N files modified, 0 secrets/lint issues]
- Proposed commit: "[type]: [description]"
```

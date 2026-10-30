---
name: project-planning
description: >
  End-to-end planning orchestrator: Clarifies ambiguous requirements, explores architectural
  trade-offs through collaborative brainstorming, and produces actionable, bite-sized implementation
  plans with test criteria. Use before starting any major feature, refactor, or complex task.
---

# Project Planning: Clarification, Brainstorming & Actionable Plans

## Overview

A structured, 3-phase planning workflow designed to turn ambiguous ideas into bulletproof, test-driven software without wasted tokens or hallucinated requirements.

```text
Phase 1: AMBIGUITY CHECK  ➔  Phase 2: BRAINSTORMING & ARCH  ➔  Phase 3: BITE-SIZED PLAN
```

---

## Phase 1: Clarify Ambiguity First

**Core Principle:** A 30-second clarification question saves 30 minutes of wasted coding and thousands of wasted tokens. Never guess user intent on architectural choices, database designs, authentication mechanisms, or destructive actions.

### Golden Rules:
1. **Never guess:** If a requirement has more than one plausible interpretation, pause and ask.
2. **Present choices:** Do not ask open-ended questions like *"what should I do?"*. Present 2-3 concrete options with pros, cons, and a clear recommendation.
3. **Confirm boundary conditions:** Identify edge cases, auth requirements, error states, and third-party dependencies before proceeding.

---

## Phase 2: Collaborative Brainstorming & Architecture

Help turn ideas into fully formed designs and specs through natural collaborative dialogue.

1. **Understand Intent:** Identify the intended outcome, who it is for, and what success looks like.
2. **Explore Approaches:** Always evaluate at least 2 viable architectural paths (e.g., Simple/Direct vs Decoupled/Extensible).
3. **Present Design & Trade-offs:** Show the chosen approach, why it was chosen, and its potential limitations.
4. **Get Approval:** Wait for alignment before writing the implementation plan.

---

## Phase 3: Bite-Sized Implementation Plan

Convert the agreed design into an actionable, bite-sized task plan saved to `docs/plans/YYYY-MM-DD-<feature-name>.md`.

### Plan Guidelines:
- **Right-Sizing:** Each task is an atomic step with its own test cycle (2-5 minutes of work).
- **No Placeholders:** Never write "TODO", "implement later", or "add validation". Provide actual file paths, signatures, and test code.
- **TDD Embedded:** Every task specifies:
  1. The failing test.
  2. The command to run the test and verify it fails.
  3. The minimal implementation code.
  4. The command to verify the test passes.
  5. The git commit message.

### Standard Plan Header:
```markdown
# [Feature Name] Implementation Plan

**Goal:** [One sentence describing what this builds]
**Architecture:** [Approach and trade-offs]
**Tech Stack:** [Key technologies and libraries]

## Tasks
- [ ] Task 1: [Component/Module]
  - Path: `src/path/to/file.ts`
  - Test: `tests/path/to/test.ts`
  - Action: Write failing test, implement, verify pass, commit.
```

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

## Phase 1: The Tech Lead Filter & Socratic Discovery

**Core Principle:** A 30-second clarification question saves 30 minutes of wasted coding and thousands of wasted tokens. Never guess user intent on architectural choices, database designs, authentication mechanisms, or stack selection. Never act as a compliant code-dispenser.

### Golden Rules:
1. **Challenge the Premise (Anti-Overengineering):** When the user asks for a specific technology (e.g. *"quiero un login con React"*), verify if that technology is the right tool or overengineered for their goal. Propose leaner alternatives (e.g., native HTML/CSS/JS, Astro, Supabase Auth) when appropriate.
2. **Never guess or assume:** If a requirement has multiple interpretations (e.g., login method: password vs OTP vs OAuth; storage: local vs remote; design: minimalist vs complex), stop and run a discovery interview.
3. **Interactive & Frictionless Questioning:** Present 2-3 focused questions with concrete choices using interactive tools (`ask_question` in Antigravity or concise numbered options) so the user can answer with a click instead of writing essays.
4. **Confirm boundary conditions:** Identify edge cases, auth flows, error states, and third-party dependencies before writing any code.

---

## Phase 2: Collaborative Brainstorming & Architecture

Help turn ideas into fully formed designs and specs through critical, collaborative engineering dialogue.

1. **Understand Intent:** Identify the intended outcome, who it is for, and what success looks like.
2. **Explore Approaches (Trade-Off Matrix):** Always evaluate at least 2 viable architectural paths:
   - *Option A (Lean / Minimal):* Quickest time-to-market, zero bloat, lowest maintenance.
   - *Option B (Scalable / Extensible):* Future-proof, richer ecosystem, higher complexity.
3. **Present Design & Trade-offs:** Recommend the best path with clear justification, potential pitfalls, and edge cases.
4. **Get Approval:** Wait for explicit alignment from the user before generating the implementation plan or touching code.

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

---

## References & Companions

* [spec-document-reviewer-prompt.md](./references/spec-document-reviewer-prompt.md) — Prompt to verify specs/plans for completeness and consistency before implementation.
* [visual-companion.md](./references/visual-companion.md) — Optional browser-based visual companion for showing UI mockups, wireframes, and architecture diagrams during Phase 2 brainstorming.
* If bootstrapping a brand-new repository without an `AGENTS.md`, offer to generate one from [`zen/references/AGENTS-TEMPLATE.md`](../zen/references/AGENTS-TEMPLATE.md) once the stack and test commands are chosen.

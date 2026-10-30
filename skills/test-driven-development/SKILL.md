---
name: test-driven-development
description: >
  Test-Driven Development (TDD) core standard. Enforces Red-Green-Refactor loop, testing at public
  interfaces (seams), vertical slicing, and robust mocking boundaries. Activates when implementing
  features, fixing bugs, refactoring, or writing integration and unit tests.
---

# Test-Driven Development (TDD) & Testing Standards

## Overview

**Core Principle:** If you didn't watch the test fail, you don't know if it tests the right thing.
Write the test first. Watch it fail. Write minimal code to pass. Clean up with confidence.

```text
🔴 1. RED (Write Failing Test)  ➔  🟢 2. GREEN (Minimal Code)  ➔  🔵 3. REFACTOR (Clean Code)
```

---

## The Iron Law

```text
NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST
```

If you write code before the test: delete it and start over from tests. No exceptions.

---

## 🎯 Seams: Where Tests Live

Tests verify observable behavior through **public interfaces (seams)**, not internal implementation details:
* A **seam** is the public boundary where behavior is observed without reaching inside.
* Tests must survive internal refactorings. If changing private methods breaks a test while external behavior remains unchanged, the test was poorly designed.
* See [tests.md](./references/tests.md) for concrete examples and [mocking.md](./references/mocking.md) for mocking rules.

---

## 🚫 Critical Anti-Patterns to Avoid

1. **Implementation-Coupled Tests:**
   * Mocks internal helpers or verifies private state. Breaks when refactoring. Always test what the user/caller receives through the public API.
2. **Tautological Tests:**
   * The assertion recalculates the expected value using the exact same logic as the production code (`expect(add(a, b)).toBe(a + b)`). This passes by construction and can never catch a bug. Expected values must come from independent, known literals.
3. **Horizontal Slicing (Bulk Tests):**
   * Never write 20 tests first and then all implementation code. Work in **vertical slices (tracer bullets)**: 1 test ➔ 1 minimal implementation ➔ verify pass ➔ repeat.

---

## 🔄 The Red-Green-Refactor Cycle

### 1. 🔴 RED — Write Failing Test
* Write a minimal test targeting one behavior.
* Run the test suite:
  ```bash
  npm test / pytest / cargo test
  ```
* **Verify:** Confirm it fails with the expected error (feature missing, not a syntax error or typo).

### 2. 🟢 GREEN — Write Minimal Code
* Implement the simplest code possible to turn the test green.
* Do not add speculative features or over-engineer (YAGNI).
* **Verify:** Run the test and confirm exit code 0 (`PASS`).

### 3. 🔵 REFACTOR — Clean Up
* Remove duplication, improve variable names, extract helpers.
* Keep all tests green.

---

## 🎭 Mocking Rules (When to Mock)

Mock at **system boundaries** only:
* External third-party APIs (Stripe, Twilio, SendGrid).
* Time / Randomness.
* Databases (prefer in-memory or ephemeral test DB when possible).

**Do NOT mock:**
* Your own domain entities, classes, or business modules.
* Consult [mocking.md](./references/mocking.md) for dependency injection patterns.

---

## 📚 References & Detailed Guides
* [Writing Good Tests Guide](./references/writing-good-tests.md)
* [Good vs Bad Tests Examples](./references/tests.md)
* [Mocking Boundaries & Best Practices](./references/mocking.md)

---
name: architecture-decision-records
description: >
  Guide the creation and maintenance of Architecture Decision Records (ADRs) and living documentation.
  Use when proposing significant architectural changes, evaluating technology trade-offs,
  recording why a design choice was made, or establishing project decision histories.
---

# Architecture Decision Records (ADR) & Technical Specs

## Overview

**Core Principle:** Code explains *how* the system works; an Architecture Decision Record explains *why* it was built that way and what alternatives were rejected. ADRs prevent teams from re-litigating settled debates and provide historical clarity.

---

## Standard ADR Format (Michael Nygard Pattern)

Save ADRs in `docs/adr/NNNN-title-in-kebab-case.md` (e.g. `docs/adr/0001-use-postgresql-for-relational-data.md`):

```markdown
# [Number]. [Short title of the architectural decision]

- **Status**: [Proposed | Accepted | Superseded by ADR-XXXX | Deprecated]
- **Deciders**: [Names / Roles involved]
- **Date**: [YYYY-MM-DD]

## Context & Problem Statement
What is the business or technical context that requires a decision? What constraints exist?
Keep it objective and grounded in facts.

## Considered Options
1. Option 1: Brief summary
2. Option 2: Brief summary
3. Option 3: Brief summary

## Decision Outcome
Chosen option: "[Option X]", because [justification tied to constraints and priorities].

### Positive Consequences
- [Advantage 1]
- [Advantage 2]

### Negative Consequences & Trade-offs
- [Known trade-off or limitation]
- [Additional maintenance / complexity introduced]

## Pros and Cons of the Options

### Option 1
- Good, because [argument]
- Bad, because [argument]

### Option 2
- Good, because [argument]
- Bad, because [argument]
```

---

## When to Write an ADR

Always create an ADR for:
1. Selecting or replacing a major framework, database, or cloud provider.
2. Introducing a new architectural pattern (e.g., Event-Driven, Microservices, CQRS).
3. Defining security, authentication, or compliance strategies.
4. Breaking backward compatibility or migrating data storage schemes.

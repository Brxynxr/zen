---
name: clean-architecture
description: >
  Enforce Clean Architecture, Domain-Driven Design (DDD), and SOLID principles, and manage
  Architecture Decision Records (ADRs). Use when structuring modules, designing domain entities,
  decoupling database/framework dependencies, or documenting major architectural trade-offs.
---

# Clean Architecture, Domain-Driven Design & ADRs

## Core Principle

**Keep business logic independent of external frameworks, databases, and UI layers.**
Changes in your database (e.g., PostgreSQL to MongoDB) or UI/HTTP framework (e.g., Express to Fastify, Next.js, FastAPI) must never require changing business domain rules.

---

## Architectural Layers

```text
[ External / Frameworks ] ➔ [ Interface Adapters ] ➔ [ Application / Use Cases ] ➔ [ Core Domain Entities ]
```

1. **Domain Entities:** Enterprise business rules, pure domain types, zero external dependencies.
2. **Use Cases / Application Services:** Application-specific business rules, orchestrating data flow to and from entities.
3. **Interface Adapters (Controllers, Gateways, Presenters):** Translates data between use cases and external tools.
4. **Frameworks & Drivers (DB, Web, Devices):** Ephemeral details; kept at the perimeter.

---

## Architecture Decision Records (ADR)

When significant technical or architectural decisions are made:
- Record the decision in `docs/adr/YYYY-MM-DD-<title>.md`.
- **Structure:**
  1. **Context:** What problem was being solved?
  2. **Alternatives Considered:** Which solutions were evaluated?
  3. **Decision:** Which solution was chosen and why?
  4. **Consequences:** What are the positive outcomes and trade-offs/limitations?

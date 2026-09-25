---
name: clean-architecture-patterns
description: >
  Apply Clean Architecture, Domain-Driven Design (DDD), and SOLID principles to software projects.
  Use when structuring new modules, designing services, refactoring business logic,
  decoupling database/framework dependencies, or establishing repository patterns.
---

# Clean Architecture & Domain-Driven Design Standards

## Overview

**Core Principle:** Keep business logic independent of external frameworks, databases, and UI layers. Changes in your database (e.g., PostgreSQL to MongoDB) or UI framework (e.g., Express to Fastify or React to Vue) should not alter business domain rules.

```text
       ┌──────────────────────────────────────────────┐
       │             Infrastructure Layer             │
       │   (HTTP Controllers, ORMs, Database, CLI)    │
       │       ┌──────────────────────────────┐       │
       │       │      Application Layer       │       │
       │       │ (Use Cases, Workflows, DTOs) │       │
       │       │       ┌──────────────┐       │       │
       │       │       │ Domain Layer │       │       │
       │       │       │ (Entities,   │       │       │
       │       │       │  ValueObjs,  │       │       │
       │       │       │  DomainRules)│       │       │
       │       │       └──────────────┘       │       │
       │       └──────────────────────────────┘       │
       └──────────────────────────────────────────────┘
                    Dependence points INWARD
```

---

## The 3 Concentric Layers

### 1. Domain Layer (Pure Business Rules)
- Contains business entities, domain types, value objects, and repository **interfaces**.
- **Rule:** ZERO dependencies on third-party frameworks, HTTP libraries, or database drivers. Pure language code (TypeScript, Python, Go, Java).
- Throws domain-specific business errors (e.g., `InsufficientFundsError`, `UserAlreadyActiveError`).

### 2. Application Layer (Use Cases & Orchestration)
- Defines the specific use cases of the application (e.g., `RegisterUserUseCase`, `CancelSubscriptionUseCase`).
- Orchestrates domain entities and calls repositories via interfaces (Dependency Inversion).
- Maps raw database entities into clean **DTOs** (Data Transfer Objects) before returning.

### 3. Infrastructure Layer (Frameworks, Drivers & Adapters)
- Concrete implementations of repository interfaces (e.g., `PostgresUserRepository` implementing `UserRepositoryInterface`).
- API routes, controllers, serializers, email senders, and cloud service clients.
- Injects infrastructure dependencies into application use cases using Dependency Injection (DI).

---

## SOLID Practical Guidelines

1. **Single Responsibility (SRP)**:
   - Separate validation, business execution, and database persistence into distinct units. A controller should only handle HTTP parsing and response formatting.
2. **Open/Closed (OCP)**:
   - Use strategy patterns or polymorphism for behavior extensions rather than sprawling `switch` or `if/else` statements.
3. **Liskov Substitution (LSP)**:
   - Derived implementations of interfaces must honor all contracts without unexpected exceptions.
4. **Interface Segregation (ISP)**:
   - Prefer small, focused interfaces (`UserReader`, `UserWriter`) over giant monolithic interfaces (`UserManager`).
5. **Dependency Inversion (DIP)**:
   - High-level modules (Use Cases) must not import low-level modules (TypeORM, Prisma, Mongoose models). Both depend on abstractions (interfaces).

---

## Red Flags & Anti-Patterns to Avoid

- **Fat Controllers**: Controllers exceeding 30 lines containing SQL queries or business logic.
- **Leaky Abstractions**: Passing ORM models or database cursors directly into the UI / HTTP response.
- **Circular Dependencies**: Services importing each other back and forth.
- **God Objects**: A single `Utils` or `Service` file exceeding 500 lines handling multiple distinct domains.

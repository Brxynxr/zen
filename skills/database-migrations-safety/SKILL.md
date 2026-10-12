---
name: database-migrations-safety
description: >
  Enforce safe schema migrations, zero-downtime database changes, indexing best practices,
  and query performance safeguards. Use when creating or modifying database schemas, writing SQL
  migrations, altering tables, adding indexes, using ORMs (Prisma, Drizzle, TypeORM, Alembic),
  or diagnosing database locks and slow queries.
---

# Database Migrations Safety & Performance Standards

## Overview

**Core Principle:** Database migrations in production must be backward-compatible, lock-free, and reversible. Never execute blocking schema changes directly against live tables. Schema evolution must decouple code deployment from database state.

---

## The Iron Laws of Database Migrations

```text
1. ZERO-DOWNTIME VIA EXPAND & CONTRACT: NEVER RENAME OR DROP COLUMNS IN A SINGLE DEPLOY
2. CONCURRENT INDEX CREATION: NEVER CREATE INDEXES ON LARGE TABLES WITHOUT CONCURRENT FLAGS
3. ALWAYS PROVIDE REVERSIBLE ROLLBACKS: EVERY MIGRATION MUST HAVE A TESTED DOWN STEP
4. AVOID TABLE LOCKS: NO DEFAULT VALUES THAT TRIGGER RE-WRITES ON LARGE EXISTING TABLES
5. AUDIT QUERIES FOR N+1 AND MISSING COVERING INDEXES BEFORE SHIPPING
```

---

## 1. The Expand and Contract Pattern (Zero-Downtime)

When renaming a column or changing a data type:

### Step 1: Expand
- Add the new column as nullable or with a non-locking default.
- Deploy application code that reads from the old column and writes to **both** old and new columns.

### Step 2: Backfill
- Run a background script to backfill historical rows from the old column to the new column in batches (e.g., 500 rows/batch with pauses to avoid replication lag).

### Step 3: Contract
- Deploy application code that reads and writes exclusively to the new column.
- In a subsequent migration, drop the old column or mark it deprecated.

---

## 2. Preventing Table Locks & Blocking Migrations

### Adding Indexes
- **PostgreSQL**: Always use `CREATE INDEX CONCURRENTLY`. Standard `CREATE INDEX` acquires an `ACCESS EXCLUSIVE` lock, blocking all reads and writes until complete.
  ```sql
  -- ❌ RISKY: Blocks reads/writes on large tables
  CREATE INDEX idx_users_email ON users(email);

  -- ✅ SAFE: Builds index concurrently without locking writes
  CREATE INDEX CONCURRENTLY idx_users_email ON users(email);
  ```

### Adding Columns with Defaults
- In PostgreSQL 11+, adding columns with constant defaults is fast (metadata-only update).
- In older engines or with volatile defaults (e.g., `DEFAULT random()`), add column as nullable first, then backfill, then add `NOT NULL` constraint with `NOT VALID` followed by `VALIDATE CONSTRAINT`.

### Changing Column Types
- Changing types (e.g., `VARCHAR(50)` to `TEXT`, or `INT` to `BIGINT`) can trigger a full table rewrite.
- Follow Expand & Contract instead of in-place type alterations for tables over 100k rows.

---

## 3. Indexing Best Practices & Query Optimization

- **Composite Indexes**: Order columns by equality filter first, range filter second:
  `(status, created_at)` satisfies `WHERE status = 'active' ORDER BY created_at DESC`.
- **Foreign Keys**: Always create explicit indexes on foreign key columns to prevent cascade table locks during deletes/updates.
- **Avoid Over-Indexing**: Every index slows down `INSERT`, `UPDATE`, and `DELETE`. Remove unused or redundant indexes.
- **Partial Indexes**: Use partial indexes for skewed boolean or status flags:
  ```sql
  CREATE INDEX CONCURRENTLY idx_orders_unprocessed ON orders(created_at) WHERE status = 'pending';
  ```

---

## 4. ORM & Query Safeguards (Prisma, Drizzle, SQLAlchemy)

- **N+1 Query Detection**: Never run queries inside loops. Use eager loading (`include`, `with`, `joinedload`) or batch loaders (`DataLoader`).
- **Bounded Pagination**: Never execute unbounded `SELECT * FROM table`. Always enforce `LIMIT` / cursor-based pagination.
- **Connection Pooling**: Always configure connection pools (`min`, `max`, `idleTimeout`) and use PgBouncer / poolers when deploying to serverless environments (Vercel, AWS Lambda).
- **Transaction Timeouts**: Keep transactions as short as possible. Never make external HTTP requests or heavy CPU calculations inside an open database transaction.

---

## 5. Pre-Migration Verification Checklist

Before applying any migration to staging or production:

- [ ] Does the migration have an automated test verifying both `up` and `down`?
- [ ] Are all new indexes created concurrently?
- [ ] Are foreign key columns indexed?
- [ ] Is the migration idempotent or wrapped in a safe transaction?
- [ ] Has the execution time been estimated on a production-scale dataset?
- [ ] Is there a rollback runbook documented?

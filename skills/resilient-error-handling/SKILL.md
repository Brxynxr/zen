---
name: resilient-error-handling
description: >
  Standardize production-grade error handling, RFC 7807 problem details, network retries,
  circuit breakers, timeouts, and structured logging without leaking sensitive data.
  Use when writing try/catch blocks, error middleware, API responses, or network calls.
---

# Resilient Error Handling & Observability Standards

## Overview

**Core Principle:** Errors are a normal part of software execution, not exceptional anomalies. Handle errors explicitly, return standardized structures, fail fast, and provide actionable observability without leaking internal implementation details.

---

## 1. Standard API Error Format (RFC 7807 Problem Details)

All HTTP error responses must adhere to the **RFC 7807** standard:

```json
{
  "type": "https://api.example.com/errors/insufficient-funds",
  "title": "Insufficient Account Balance",
  "status": 422,
  "detail": "Account balance of $12.50 is lower than the required transfer amount of $50.00.",
  "instance": "/transfers/tx_987654321",
  "invalid_params": [
    { "name": "amount", "reason": "Exceeds available balance" }
  ],
  "traceId": "req_01HPX79N12ABCXYZ"
}
```

- **Never** return generic `{ "error": "Internal server error" }` without a unique `traceId` / `requestId`.
- **Never** return raw stack traces or internal DB error codes (`PG_ERROR_23505`) to end users in production.

---

## 2. Error Categorization & Typed Hierarchy

Distinguish cleanly between the 3 classes of errors:

1. **User / Operational Errors (4xx)**:
   - Invalid input, unauthorized access, missing entity, rate limit exceeded.
   - Handled gracefully with explicit user messages.
2. **Domain / Business Rule Errors (422)**:
   - Entity valid in syntax, but business invariant violated (e.g. attempting to cancel an already shipped order).
3. **Internal / Infrastructure Faults (5xx)**:
   - Database unreachable, disk full, external payment gateway down.
   - Logged with high severity and stack trace; user gets friendly error + `traceId`.

---

## 3. Network Resiliency: Timeouts, Retries & Circuit Breaking

When making external API or database calls:

- **Mandatory Timeouts**: Never make an HTTP or database request without an explicit timeout (e.g., 3s–10s max). A missing timeout can hang all worker threads indefinitely.
- **Exponential Backoff with Jitter**:
  ```text
  Delay = min(BaseDelay * 2^(Attempt), MaxDelay) + random_jitter()
  ```
  Retrying immediately or with static delays causes "thundering herd" problems.
- **Idempotency Check**: ONLY retry idempotent operations (GET, PUT, DELETE or requests with an `Idempotency-Key` header). Never blindly retry non-idempotent POSTs (e.g. charge card).

---

## 4. Structured Logging & PII Sanitization

- Use structured JSON logs (`pino`, `winston`, `structlog`) rather than raw `console.log`.
- Always attach contextual metadata: `timestamp`, `level`, `traceId`, `userId` (hashed or ID only), `durationMs`.
- **Sanitize PII & Secrets**: Automatically mask credit cards, passwords, auth tokens, and personal email addresses before writing to stdout.

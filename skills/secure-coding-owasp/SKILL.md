---
name: secure-coding-owasp
description: >
  Enforce OWASP Top 10 security standards and defensive coding across backend and frontend code.
  Use when writing or modifying authentication, authorization, API endpoints, database queries,
  CORS/headers, session management, or handling user inputs and secrets.
---

# Secure Coding & OWASP Defensive Standards

## Overview

**Core Principle:** Never trust client-side data. Enforce security controls at the server and architectural boundary, fail securely, and minimize the attack surface.

## The Iron Laws of Application Security

```text
1. NEVER CONCATENATE UNTRUSTED INPUT INTO SQL/NOSQL QUERIES (ALWAYS PARAMETERIZE)
2. NEVER COMMIT SECRETS OR HARDCODE TOKENS/KEYS IN CODE
3. NEVER EXPOSE INTERNAL STACK TRACES OR DATABASE SCHEMAS IN PRODUCTION RESPONSES
4. VALIDATE AT THE BOUNDARY (STRICT SCHEMAS) AND SANITIZE BEFORE RENDERING
```

---

## 1. Injection Prevention (SQL / NoSQL / Command)

- **SQL**: Always use parameterized queries or trusted ORMs.
  ```typescript
  // ❌ VULNERABLE:
  db.query(`SELECT * FROM users WHERE email = '${email}'`);

  //  SECURE:
  db.query('SELECT * FROM users WHERE email = $1', [email]);
  ```
- **NoSQL**: Sanitize object keys and validate types before passing to mongo/redis queries to prevent operator injection (`$gt`, `$ne`).
- **Command Injection**: Avoid `exec()` or passing shell commands. Use structured child process calls with separate arguments arrays (`execFile('git', ['status'])`).

---

## 2. Authentication & Session Management

- **Password Hashing**: Use **Argon2id** (recommended) or **Bcrypt** with salt factor ≥ 12. Never use SHA-256 or MD5 for passwords.
- **Tokens & Cookies**:
  - Store session/auth tokens in `HttpOnly; Secure; SameSite=Strict` cookies to block XSS theft.
  - Never store access tokens in `localStorage` or `sessionStorage` if they have sensitive privileges.
  - Implement short expiration times for access tokens (e.g., 15m) and secure refresh token rotation.

---

## 3. Input Validation & Output Encoding (XSS Prevention)

- **Schema Validation**: Parse and validate all incoming inputs (query, params, body) using strict schemas (e.g., Zod, Pydantic, Joi). Reject unexpected fields (`strip` or `strict`).
- **XSS Prevention**:
  - Never use `dangerouslySetInnerHTML`, `v-html`, or `innerHTML` with unsanitized user content. Use DOMPurify if HTML rendering is unavoidable.
  - Set security headers: `Content-Security-Policy (CSP)`, `X-Content-Type-Options: nosniff`.

---

## 4. API Security & Access Control (Broken Object Level Authorization - BOLA)

- **Authorization on EVERY endpoint**: Verify ownership, not just authentication.
  ```typescript
  // ❌ VULNERABLE (User A can view User B's order by guessing orderId):
  app.get('/orders/:id', async (req, res) => Order.findById(req.params.id));

  //  SECURE:
  app.get('/orders/:id', async (req, res) => {
    const order = await Order.findOne({ _id: req.params.id, userId: req.user.id });
    if (!order) return res.status(404).json({ error: 'Order not found' });
  });
  ```
- **CORS**: Never configure `Access-Control-Allow-Origin: *` alongside `credentials: true`. Explicitly whitelist trusted domains.
- **Rate Limiting**: Apply rate-limiting to sensitive endpoints (login, register, password reset, payment processing).

---

## 5. Secrets & Environment Configuration

- Load all secrets via environment variables (`process.env.XYZ`, `os.environ`).
- Always maintain a documented `.env.example` without real secret values.
- Verify `.gitignore` includes `.env`, `.env.local`, `.pem`, and `credentials.json`.

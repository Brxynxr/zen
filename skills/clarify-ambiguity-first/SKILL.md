---
name: clarify-ambiguity-first
description: >
  Stop and ask for clarification when user requirements or technical decisions are ambiguous,
  underspecified, or have multiple architectural directions. Prevents wasting tokens,
  hallucinating intent, and coding the wrong solution based on unverified assumptions.
---

# Clarify Ambiguity First

## Overview

**Core Principle:** A 30-second clarification question saves 30 minutes of wasted coding and thousands of wasted tokens. Never guess user intent on architectural choices, database designs, authentication mechanisms, or destructive actions.

## The Iron Law

```text
NO SILENT ASSUMPTIONS ON AMBIGUOUS REQUIREMENTS
```

When a request has multiple valid, significantly different technical paths:
1. **DO NOT** secretly pick one and start coding.
2. **DO NOT** implement half-measures or hedge bets by generating bloated code.
3. **STOP**, state the ambiguity briefly, present 2-3 concrete options with trade-offs, and ask.

## When to Stop and Ask

- **Architecture / Framework choices**: e.g., "build an auth system" (JWT in memory, HttpOnly cookies, OAuth2, or 3rd party like Supabase/Auth0?).
- **Data models**: e.g., "add payments" (Stripe Elements, hosted checkout, PayPal?).
- **Destructive changes**: e.g., migrations dropping columns, replacing existing core modules, resetting databases.
- **Underspecified requirements**: e.g., "make this faster" or "add tests" without specifying scope or target metrics.

## How to Ask Efficiently

Keep questions concise, structured, and easy to answer:

1. **State the decision point**: One clear sentence.
2. **Offer 2-3 concise options**:
   - **Option A (Recommended)**: Brief rationale.
   - **Option B**: Alternative with key trade-off.
3. **Wait for response before writing implementation code.**

## Red Flags - STOP

- Thinking: *"I'll just pick PostgreSQL and hope they don't want MongoDB."*
- Thinking: *"I'll guess what columns they need in this table."*
- Thinking: *"I'll write code now and ask if they like it later."*
- **ANY impulse to start implementing when two equally valid paths exist.**

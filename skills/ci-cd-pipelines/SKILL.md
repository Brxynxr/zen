---
name: ci-cd-pipelines
description: >
  Standardize resilient, fast, and secure CI/CD pipelines (GitHub Actions, GitLab CI).
  Use when designing build/test workflows, automating deployment, configuring dependency caching,
  securing CI secrets, setting up semantic releases, or troubleshooting failed pipeline runs.
---

# CI/CD Pipelines & Continuous Delivery Standards

## Overview

**Core Principle:** CI/CD pipelines are production code. They must be reproducible, fast, secure by default, and fail immediately upon regression. A flaky or slow pipeline destroys engineering velocity and erodes trust.

---

## The Iron Laws of CI/CD Engineering

```text
1. MINIMAL PERMISSIONS: ALWAYS DEFINE LEAST-PRIVILEGE GITHUB_TOKEN PERMISSIONS EXPLICITLY
2. CANCEL REDUNDANT RUNS: USE CONCURRENCY GROUPS TO ABORT OUTDATED COMMITS
3. PIN ACTIONS & DEPENDENCIES: AVOID FLOATING UNPINNED SCRIPTS OR THIRD-PARTY ACTIONS
4. AGGRESSIVE CACHING: NEVER DOWNLOAD NPM/PYTHON/RUST PACKAGES FROM SCRATCH ON EVERY RUN
5. FAIL FAST & ISOLATE: RUN LINTING AND UNIT TESTS IN PARALLEL BEFORE EXPENSIVE INTEGRATION JOBS
```

---

## 1. Pipeline Architecture & Structure

Structure pipelines into distinct, independent phases to provide fast feedback:

```text
┌─────────────────┐     ┌─────────────────┐
│   Static Check  │ ──> │   Unit Tests    │ ──> ┌──────────────────────┐
│  (Lint/Types)   │     │ (Matrix Run)    │     │ E2E / Integration    │ ──> ┌───────────────────┐
└─────────────────┘     └─────────────────┘     └──────────────────────┘     │ Deploy / Release  │
                                                                             └───────────────────┘
```

### GitHub Actions Best-Practice Foundation

```yaml
name: CI

on:
  push:
    branches: [main, master]
  pull_request:
    branches: [main, master]

# 1. Cancel redundant runs on new pushes
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

# 2. Strict least-privilege permissions at workflow level
permissions:
  contents: read

jobs:
  lint-and-typecheck:
    runs-on: ubuntu-latest
    timeout-minutes: 10
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: 'npm' # or 'pnpm' / 'yarn'
      - run: npm ci
      - run: npm run lint
      - run: npm run typecheck

  test:
    needs: lint-and-typecheck
    runs-on: ubuntu-latest
    timeout-minutes: 15
    strategy:
      fail-fast: false
      matrix:
        node-version: [18, 20]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
          cache: 'npm'
      - run: npm ci
      - run: npm test -- --coverage
```

---

## 2. Speed & Caching Strategies

- **Lockfile Enforcement**: Always use `npm ci`, `pnpm install --frozen-lockfile`, or `poetry install --sync` instead of `npm install` to guarantee deterministic builds.
- **Package Manager Caching**: Leverage native cache options in `actions/setup-node`, `actions/setup-python`, `actions/setup-go`, or `dtolnay/rust-toolchain`.
- **Docker Layer Caching**: In container builds, use GitHub Actions cache backend:
  ```yaml
  - uses: docker/build-push-action@v5
    with:
      cache-from: type=gha
      cache-to: type=gha,mode=max
  ```
- **Job Parallelization**: Separate linting, formatting, type checking, and unit testing into parallel jobs rather than a sequential single-job script.

---

## 3. Supply Chain & Security Hardening

- **Never Print Secrets**: Ensure shell commands with tokens or passwords are never echoed into logs.
- **Restrict Fork PR Permissions**: Never grant write permissions or give secret access to `pull_request_target` without strict commit-hash vetting.
- **Pin Trusted Actions**: Pin third-party GitHub Actions to commit hashes or verified official release tags (`v4`).
- **Secret Scanning & Vulnerability Gate**: Integrate automated security scans (e.g., CodeQL, Trivy, or `npm audit --audit-level=high`) in the PR check pipeline.

---

## 4. Release Automation & Semantic Versioning

- **Conventional Commits**: Enforce commit conventions (`feat:`, `fix:`, `chore:`, `perf:`) to automate changelogs.
- **Automated Releases**: Use tools like `semantic-release` or `changesets` triggered only on the main branch upon successful CI pass.
- **Artifact Protection**: Never deploy directly to production without passing tests, building in a clean runner, and generating a verified release artifact.

---
name: qa-and-security-auditor
description: Execute a full testing cycle (lint, unit, ACID integration, E2E), audit security/payment vulnerabilities, and enforce feature-branch PR gates after every feature.
---

# QA, Full Testing Cycle & Security Auditor Skill

Run this skill **after implementing every single feature** and before opening or merging any Pull Request:

1. **Git Branching & PR Hygiene Gate:**
   - Verify the current branch is a dedicated feature/fix branch (`feat/*`, `fix/*`, `chore/*`) and **NEVER** `main` or `master` (`git branch --show-current`).
   - Ensure commits are atomic and cleanly scoped before opening a Pull Request to `main` / `master`.
2. **Mandatory 4-Stage Full Testing Cycle (After Every Feature):**
   - **Stage 1 — Static & Type Check:** Run linter and strict typechecking (`ruff` / `mypy` / `tsc --noEmit` / `eslint`). Zero errors allowed.
   - **Stage 2 — Unit & Edge-Case Suite (TestSprite-ready):** Write and execute happy-path + 3 mandatory edge-case tests for the feature:
     1. Empty / malformed / injection input.
     2. Unauthorized user attempting cross-tenant access (IDOR).
     3. External API / LLM timeout or rate-limit failure (graceful fallback).
   - **Stage 3 — ACID Transaction & Outbox Integration Tests:**
     - Simulate a mid-transaction failure and verify `ROLLBACK` leaves zero partial/orphan rows in the database.
     - Verify that domain side-effects write an `outbox_events` record (`status='PENDING'`) atomically alongside the business state and handle duplicate/idempotent processing safely.
   - **Stage 4 — E2E & Contract Verification:** Verify API status codes, response schemas, and UI/PWA offline fallbacks.
3. **Security & Payment Audit:**
   - Verify `.env` is in `.gitignore` and no keys (`sk-`, `AIza`, DB URIs) exist in git history.
   - Check that all AI endpoints require authentication + per-user rate limits.
   - Audit payment webhooks (Stripe / Paymob / PayPal) for raw-body HMAC signature verification and transactional idempotency keys (prevent double-charging or replay attacks).
4. **Release Verdict:** Output a concise `PASS / BLOCK` table with test execution counts, coverage summary, and exact file/line numbers for any blocker before the PR can merge to `main`/`master`.



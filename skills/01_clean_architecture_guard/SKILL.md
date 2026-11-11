---
name: clean-architecture-guard
description: Enforce Clean Architecture, SOLID principles, ACID transactions, and the Transactional Outbox Pattern when generating or refactoring code with AI.
---

# Clean Architecture & Data Reliability Guard Skill

When the user asks you to build a feature, review code, or scaffold an app:

1. **Audit Layer Boundaries First:**
   - Check if UI/controllers talk directly to the database or external APIs. If so, extract an interface in `domain/` and an implementation in `infrastructure/`.
2. **Apply SOLID Checks:**
   - **Single Responsibility:** Split any file > 250 lines or any function doing both I/O and business math.
   - **Liskov & Dependency Inversion:** Business logic must depend on abstractions (ports), never concrete SDKs (adapters).
3. **Database Protection, ACID Transactions & Outbox Pattern:**
   - Never expose internal DB IDs or raw stack traces to the client.
   - Always use parameterized queries / ORM bindings and cursor/limit pagination.
   - **ACID Unit of Work:** Any use case that mutates multiple tables (e.g., creating an order + deducting credits + recording an audit log) MUST execute inside a single atomic database transaction (`BEGIN ... COMMIT / ROLLBACK`) via an `IUnitOfWork` interface.
   - **Transactional Outbox Pattern (Zero Dual-Write Bugs):** Never call external side effects (emails, WhatsApp/n8n webhooks, Stripe/Paymob calls, or async AI jobs) inside the middle of a DB transaction or fire-and-forget after commit. Instead, persist an `outbox_events` row in the **same ACID transaction** and dispatch it via an idempotent background worker (`SELECT ... FOR UPDATE SKIP LOCKED`).
4. **Full Verification & Feature Branch Gate:**
   - Ensure the implementation is developed on a dedicated feature branch (`feat/<name>`) rather than `main`/`master`.
   - Run the full testing cycle (lint + typecheck + unit + ACID rollback & outbox integration tests) before declaring the task done.
5. **Output Format:**
   - State the folder/layer structure and transaction boundaries before writing code.
   - Highlight any "Vibe Coding Trap" you prevented (e.g., dual-write race conditions, partial DB writes without rollback, N+1 queries, missing auth check).



---
name: acid-transactions-and-outbox
description: Implement ACID database transactions (Unit of Work), Transactional Outbox Pattern, idempotent webhook consumers, and concurrency-safe locking to prevent dual-write bugs and data corruption.
---

# ACID Transactions & Transactional Outbox Pattern Skill

Use this skill whenever an application performs multi-table database writes, processes payments/credits, triggers external webhooks/emails/WhatsApp messages, or dispatches background AI jobs:

## 1. The Dual-Write Anti-Pattern (NEVER Do This)
Never write code that updates the database and immediately calls an external API/broker in the same request handler:
```text
❌ BAD (Dual-Write Trap):
1. db.save(order)
2. stripe.charge() / send_email() / publish_webhook()  <-- If this fails or times out, DB and external state diverge!
```

## 2. Enforce ACID Transactions via Unit of Work (`IUnitOfWork`)
- Wrap all multi-entity mutations inside an explicit atomic transaction (`BEGIN ... COMMIT / ROLLBACK`).
- Define `IUnitOfWork` in `domain/interfaces` (or `application/ports`) and implement it in `infrastructure/db`:
  - **Atomicity:** If any step fails, roll back the entire transaction so zero partial records remain.
  - **Isolation & Locking:** Use `SELECT ... FOR UPDATE` (pessimistic locking) or version columns (`optimistic locking`) when modifying balances, quotas, or inventory to prevent race conditions (`Lost Update` / double-spend).

## 3. Implement the Transactional Outbox Pattern
1. **Outbox Schema (`outbox_events` table):**
   ```sql
   CREATE TABLE outbox_events (
       id UUID PRIMARY KEY,
       tenant_id VARCHAR(64) NOT NULL,
       aggregate_type VARCHAR(64) NOT NULL,   -- e.g. 'Order', 'Lead', 'Subscription'
       aggregate_id VARCHAR(128) NOT NULL,
       event_type VARCHAR(128) NOT NULL,       -- e.g. 'order.paid', 'lead.qualified'
       idempotency_key VARCHAR(128) UNIQUE NOT NULL,
       payload JSONB NOT NULL,
       status VARCHAR(24) NOT NULL DEFAULT 'PENDING', -- PENDING | PROCESSING | PUBLISHED | FAILED_DLQ
       retry_count INT NOT NULL DEFAULT 0,
       max_retries INT NOT NULL DEFAULT 5,
       next_attempt_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
       last_error TEXT,
       created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
       processed_at TIMESTAMPTZ
   );
   CREATE INDEX idx_outbox_poll ON outbox_events (status, next_attempt_at) WHERE status = 'PENDING';
   ```
2. **Atomic Write (Inside Use Case):**
   - Within the **same ACID transaction** (`with uow:`), persist the domain entity update AND insert the `outbox_events` row (`status = 'PENDING'`). Commit both together.
3. **Outbox Relay Worker (Polling Publisher with `SKIP LOCKED`):**
   - Run a background worker loop that fetches pending events safely across concurrent workers:
     ```sql
     SELECT * FROM outbox_events
     WHERE status = 'PENDING' AND next_attempt_at <= NOW()
     ORDER BY created_at ASC
     LIMIT 20
     FOR UPDATE SKIP LOCKED;
     ```
   - On delivery success: mark `status = 'PUBLISHED'` and set `processed_at = NOW()`.
   - On failure: increment `retry_count`, apply exponential backoff (`next_attempt_at = NOW() + 2^retry_count seconds`), and move to `status = 'FAILED_DLQ'` when `retry_count >= max_retries`.
4. **Idempotent Consumer / Inbox Pattern:**
   - Every downstream consumer or webhook handler must check `idempotency_key` before executing side effects so duplicate deliveries ("at-least-once" delivery) are safely ignored.

## 4. Mandatory Verification Suite
Before marking any transactional feature complete, write and run automated tests proving:
1. **ACID Rollback Test:** Inject an exception before commit and assert that both the business table and `outbox_events` table have `0` uncommitted rows.
2. **Outbox Delivery & Retry Test:** Verify `PENDING -> PUBLISHED` transition on success and exponential backoff -> `FAILED_DLQ` on repeated downstream failure.
3. **Idempotency Test:** Replay the same `idempotency_key` twice and assert the side effect executes exactly once.


# AGENTS.md — Senior AI Engineering Directives (by @Khallad-tech)

## 1. Role & Engineering Standard
You are a Senior Full-Stack & AI Systems Architect (10+ years experience). You do NOT write fragile "vibe-coded" prototypes. Every feature must be modular, testable, observable, secure, and ready for production traffic.

## 2. Architecture & Data Reliability Rules (Clean Architecture + DDIA)
- **Strict Layer Separation:**
  - `domain/` — Pure business logic, entities, domain events, and interfaces (ports). Zero framework or database imports.
  - `application/` — Use cases, Unit of Work orchestration, agent workflows, and DTOs.
  - `infrastructure/` — Database clients (Postgres/Vector DB), Outbox relay workers, external APIs, LLM providers, payment gateways, and telemetry exporters.
  - `presentation/` — UI components, API routes, controllers, and webhook endpoints.
- **Never** call database queries or raw LLM SDKs directly inside UI components or route handlers.
- **ACID Transactions & Transactional Outbox Pattern (Mandatory for Multi-Step Writes):**
  - Wrap all multi-table mutations in an explicit **ACID database transaction** (`BEGIN ... COMMIT / ROLLBACK`) via a Unit of Work (`uow`) pattern.
  - **No Dual-Writes:** Never update the database AND directly call an external side-effect (Stripe/Paymob API, email/WhatsApp webhook, LLM job, or message broker) in the same request thread without transactional guarantees.
  - Instead, insert both the business entity change and an `outbox_events` record (`id`, `aggregate_type`, `aggregate_id`, `event_type`, `payload`, `status='PENDING'`, `retry_count`, `created_at`) inside the **same atomic DB transaction**.
  - Process `outbox_events` asynchronously via an idempotent background worker (`SELECT ... FOR UPDATE SKIP LOCKED`) with exponential backoff and Dead-Letter Queue (`status='FAILED_DLQ'`) handling.

## 3. AI, RAG & Agentic Safety Rules
- **Cost & Token Guardrails:** Always set `max_tokens`, timeouts, and retry backoffs on every LLM/Agent call. Cache deterministic embeddings and repeated queries.
- **RAG vs. Agentic Decision:**
  - Use **RAG** when the user needs grounded answers from private data. Enforce citations and chunk-level metadata filtering (`tenant_id`).
  - Use **Agents** only when multi-step tool execution is required. Restrict tool permissions to least-privilege (never give an agent raw `DROP`/`DELETE` DB access).
- **Structured Outputs:** Enforce JSON Schema / Pydantic / Zod validation on all LLM outputs before passing them to downstream code.

## 4. Security & Payments Checklist (Pre-Commit Gate)
- Never hardcode API keys, database URLs, or webhook secrets. Validate all env vars at startup.
- Verify webhook signatures (Stripe / Paymob / Lemon Squeezy) using raw request bodies before fulfilling orders, and enforce idempotency keys (`event_id`) inside an ACID transaction.
- Enforce rate-limiting and authentication on every AI-triggering endpoint to prevent API bill attacks.

## 5. Free-Tier Production Monitoring & Observability
- **Health & Readiness Probes:** Expose `/healthz` (liveness) and `/readyz` (DB + dependency connectivity check) on every backend service.
- **Tail Latency & Metrics (Free Stack):** Track `P50`, `P95`, and `P99` latency (never rely on arithmetic average alone), error rates (`4xx`/`5xx`), LLM token usage, and Outbox queue depth using **Prometheus + Grafana Cloud (Free Tier)** or **OpenTelemetry**.
- **Error Tracking & Uptime (Zero-Cost Tools):**
  - Integrate **Sentry (Free Developer Tier)** with PII scrubbing for real-time exception and stack-trace alerting.
  - Configure structured JSON logging (`trace_id`, `tenant_id`, `latency_ms`, `status_code`) compatible with **Grafana Loki / Pino / structlog**.
  - Set up external uptime & SSL monitoring via **Uptime Kuma** (self-hosted) or **Better Stack / Cronitor Free Tier**.

## 6. Git Branching, Full Testing Cycle & GitHub CI/CD Rules
1. **Always Work on a Feature Branch (Never Push Directly to `main` / `master`):**
   - Before writing any code, create a dedicated branch: `git checkout -b feat/<feature-slug>` or `fix/<bug-slug>`.
   - Commit in small, atomic vertical slices with conventional commit messages (`feat:`, `fix:`, `refactor:`, `test:`, `ci:`).
2. **Mandatory Full Testing Cycle After Every Single Feature:**
   - You may **never** mark a feature complete or open a PR until you execute and pass the full verification suite:
     1. **Static Analysis & Linting:** Typechecker (`tsc --noEmit` / `mypy` / `ruff`) + linter (`eslint` / `flake8`).
     2. **Unit Tests:** Fast domain & application use-case tests (including failure/rollback paths).
     3. **Integration & Contract Tests:** Database ACID rollback tests, Outbox event persistence checks, and API schema validation.
     4. **End-to-End (E2E) & Security Audit:** Critical user journey verification + secret/auth/IDOR scan.
3. **GitHub Pull Request & Automated CI/CD Gate:**
   - Push the feature branch (`git push -u origin feat/<feature-slug>`) and open a Pull Request (`gh pr create`) targeting `main` / `master` with a summary of changes, test output, and rollback plan.
   - Every PR must pass the automated **GitHub Actions CI/CD workflow** (`.github/workflows/ci.yml`) running lint, unit/integration tests, security audit, and build verification before merge is allowed.



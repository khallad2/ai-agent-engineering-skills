---
name: free-production-monitoring
description: Build production-grade observability, tail-latency tracking (P50/P95/P99), error alerting, structured logging, and uptime monitoring using 100% free-tier and open-source tools.
---

# Free-Tier Production Monitoring & Observability Skill

When preparing any backend, AI agent, or full-stack web application for production, implement this **Zero-Cost Observability Stack** so you catch outages, slow tail latencies, and runaway LLM costs before users complain:

## 1. The 100% Free Production Monitoring Stack
| Pillar | Free Tool / Open-Source Choice | What It Monitors |
|---|---|---|
| **Error & Crash Tracking** | **Sentry** (Free Developer Tier) or **GlitchTip** (Open-Source) | Unhandled exceptions, stack traces, release regressions, user context (with PII scrubbed). |
| **Metrics & Tail Latency** | **Prometheus + Grafana Cloud** (Free Forever Tier: 10k series) | `P50` / `P95` / `P99` request latency, RPS, `4xx`/`5xx` error rates, Outbox queue lag, LLM token usage & cost. |
| **Structured Logs** | **Grafana Loki** (Free Tier) + `structlog` (Python) / `pino` (Node.js) | JSON-formatted logs indexed by `trace_id`, `tenant_id`, `route`, `status_code`, and `duration_ms`. |
| **LLM & Agent Tracing** | **Langfuse** (Open-Source / Free Cloud Tier) or **Helicone** | Prompt/completion traces, token cost per tenant, RAG retrieval latency, and hallucination scores. |
| **Uptime & SSL Alerts** | **Uptime Kuma** (Self-Hosted Docker) or **Better Stack** (Free Tier) | 1-minute HTTP checks on `/healthz` and `/readyz` with instant Telegram / Discord / Slack alerts. |

## 2. Mandatory Application Instrumentation Rules
1. **Health & Readiness Endpoints:**
   - `GET /healthz`: Lightweight liveness check returning `200 OK` (`{"status": "alive"}`).
   - `GET /readyz`: Deep readiness check verifying DB connection (`SELECT 1`), cache connectivity, and pending Outbox DLQ count (`200 OK` if healthy, `503 Service Unavailable` if degraded).
2. **Never Trust Average Latency — Track `P50`, `P95`, and `P99` (DDIA Standard):**
   - Arithmetic mean (`avg`) hides slow RAG/LLM outliers affecting your best customers.
   - Instrument an in-memory percentile tracker or Prometheus `Histogram` on every API route and AI call.
   - Define explicit **SLOs (Service Level Objectives)**: e.g., Standard API `P95 < 300ms`, AI/RAG endpoint `P95 < 2500ms`, Error Rate `< 1%`.
3. **Correlation IDs & Structured JSON Logging:**
   - Attach a middleware that reads or generates `X-Request-ID` / `trace_id` on every request and injects it into all log entries, Outbox events, and error responses.
   - Never use raw `print()` or unstructured `console.log()` in production code.
4. **Actionable Alerting Rules (Zero Alert Fatigue):**
   - Trigger high-priority alerts (Telegram / Slack / Email) immediately when:
     - `/readyz` fails for `>= 2` consecutive checks,
     - `5xx` error rate exceeds `2%` over a 5-minute window,
     - `outbox_events` with `status = 'FAILED_DLQ'` is `> 0`, or
     - Daily LLM token spend exceeds the configured tenant budget cap.


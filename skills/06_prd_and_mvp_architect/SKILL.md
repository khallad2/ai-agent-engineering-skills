---
name: prd-and-mvp-architect
description: Interactive AI Product Manager & Systems Architect that interviews the developer with 5 sharp questions before generating PRD.md, ARCHITECTURE.md, and TASKS.md.
---

# Interactive PRD & MVP Architect Skill

When the user presents an app idea, client brief, or feature request, **DO NOT write application code immediately**. Follow this strict 3-Phase workflow:

## Phase 1: The 5-Question Senior PM Interview (Interactive Gate)
Stop and ask the user these 5 concise questions (in Arabic or English matching the user's language):
1. **The 1 Core Loop:** ما هي العملية الواحدة الأساسية (Trigger → Action → Result) التي يدفع العميل مالاً من أجلها في أول يوم؟
2. **Roles & Tenants:** من هم المستخدمون الأساسيون (مثلاً: صاحب شركة/عيادة + عميل نهائي) وكيف نفصل بيانات كل شركة (`tenant_id`)؟
3. **AI Architecture Need:** هل نحتاج RAG (إجابة من ملفات خاصة)، أم Agent ينفذ مهام في الداتابيز/APIs، أم الاثنين معاً؟
4. **Monetization & Payments:** كيف سيدفع العميل (اشتراك شهري أم دفع لمرة واحدة) وما هي بوابة الدفع المستهدفة (Paymob / Stripe / Lemon Squeezy)؟
5. **Hard Constraints:** هل الواجهة تحتاج دعم كامل للغة العربية (RTL)، وما هو الحد الأقصى المقبول لتكلفة الـ API شهرياً لكل عميل؟

*Wait for the user's answers before moving to Phase 2.*

## Phase 2: Generate `PRD.md` & `ARCHITECTURE.md`
Once the user answers:
1. Cut any feature bloat into a strict **MoSCoW Table** (capping `v1.0 Must-Haves` at **1 Core Loop + max 3 screens**).
2. Write **`PRD.md`** with at least 3 testable user stories using `GIVEN / WHEN / THEN` (including 1 anti-hallucination edge case and 1 security/payment edge case).
3. Write **`ARCHITECTURE.md`** with:
   - A Mermaid C4 Container diagram following Clean Architecture (`domain/`, `application/`, `infrastructure/`, `presentation/`).
   - A PostgreSQL + `pgvector` schema with mandatory `tenant_id` foreign keys, unique constraints, and an **`outbox_events` table** for ACID transactional side-effects.
   - REST API JSON request/response contracts + `/healthz` and `/readyz` monitoring probes.
   - An AI Unit Economics table calculating monthly LLM token cost vs. subscription price.

## Phase 3: Generate Atomic `TASKS.md` (With Feature-Branch & Test Gates)
Break the build into vertical-slice tasks (each touching `≤ 3 files`) where every single task enforces:
- Creating a feature branch (`git checkout -b feat/task-N-...`),
- Running the full testing cycle (`pytest` / `npm test` + lint + typecheck), and
- Opening a Pull Request (`gh pr create`) to merge into `main`/`master`.


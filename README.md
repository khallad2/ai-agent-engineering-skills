# 🚀 AI Agent Engineering Skills & Multi-Agent Pack (`@Khallad-tech`)

[![CI Validation](https://github.com/khallad2/ai-agent-engineering-skills/actions/workflows/validate_pack.yml/badge.svg)](https://github.com/khallad2/ai-agent-engineering-skills/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-emerald.svg)](./LICENSE)
[![Works With](https://img.shields.io/badge/Works%20With-Google%20Antigravity%20%7C%20Claude%20Code%20%7C%20Cursor%20%7C%20Gemini%20CLI-blue)](#)

> **Stop "Vibe Coding" fragile prototypes that crash in production.**  
> Upgrade **Google Antigravity**, **Claude Code**, **Gemini CLI**, **Cursor**, and **OpenCode** into a disciplined **Senior Software Engineering Team** with 1 command.
>
> **حوّل أي أداة برمجة بالذكاء الاصطناعي من كتابة كود عشوائي (Vibe Coding) إلى فريق هندسي محترف يبني تطبيقات Production جاهزة للبيع.**

---

## ⚡ 10-Second Install (For Vibe Coders & Builders)
### الطريقة الأسهل: سطر واحد فقط وركّب كل المهارات والـ Agents تلقائياً!

#### 🍎 Mac / Linux (Terminal)
```bash
curl -fsSL https://raw.githubusercontent.com/khallad2/ai-agent-engineering-skills/main/install.sh | bash
```

#### 🪟 Windows (PowerShell)
```powershell
irm https://raw.githubusercontent.com/khallad2/ai-agent-engineering-skills/main/install.ps1 | iex
```

#### 📁 Drop `AGENTS.md` Into Any Project Folder (1 Command)
Inside your project folder, run this to enforce Senior Engineering Rules (`AGENTS.md`):
```bash
curl -fsSL https://raw.githubusercontent.com/khallad2/ai-agent-engineering-skills/main/AGENTS_TEMPLATE.md -o AGENTS.md
```

---

## 💬 Copy-Paste Prompts for Vibe Coders (كيف تستخدمها بدون تعقيد؟)

Once installed, you don't need to know complex architecture terms. Just paste one of these prompts into **Google Antigravity / Claude Code / Cursor**:

1. **لبناء مشروع جديد من الصفر بدون تخريف (Start a New App):**
   > *"Use `prd-and-mvp-architect` to interview me with 5 questions and generate `PRD.md`, `ARCHITECTURE.md`, and `TASKS.md` for my idea."*
2. **لمنع ضرب الداتابيز أو ضياع المدفوعات (Fix Payments & Database):**
   > *"Apply `clean-architecture-guard` and `acid-transactions-and-outbox` to this feature so all database writes and webhooks are 100% atomic."*
3. **لفحص الكود وتشغيل الاختبارات قبل الـ Merge (Run Full Testing Cycle & Security Audit):**
   > *"Run `qa-and-security-auditor` and `github-cicd-and-gitflow` on my current feature branch before opening a Pull Request."*
4. **لإضافة مراقبة مجانية للسيرفر والأخطاء (Add Free Production Monitoring):**
   > *"Apply `free-production-monitoring` to add `/healthz`, `/readyz`, `P95/P99` latency tracking, and Sentry/Grafana Cloud Free Tier hooks."*

---

## 📦 What's Inside the Pack? (محتويات الحزمة)

### 🧠 1. Nine Production Engineering Skills (`skills/`)
| # | Skill Folder | What Problem It Solves (English & العربية) |
|---|---|---|
| **01** | [`01_clean_architecture_guard`](./skills/01_clean_architecture_guard/SKILL.md) | **Clean Architecture & SOLID:** Prevents spaghetti code; enforces strict `domain` / `application` / `infrastructure` / `presentation` boundaries.<br>*يمنع خلط كود الواجهة بالداتابيز ويفصل الطبقات باحترافية.* |
| **02** | [`02_rag_and_agentic_architect`](./skills/02_rag_and_agentic_architect/SKILL.md) | **RAG & Agentic AI Guardrails:** Hybrid search (`BM25 + vector`), strict `tenant_id` isolation, token cost caps, and zero-hallucination citations.<br>*يبني أنظمة RAG و Agents دقيقة بدون هلوسة أو فواتير API عالية.* |
| **03** | [`03_qa_and_security_auditor`](./skills/03_qa_and_security_auditor/SKILL.md) | **4-Stage Full Testing Cycle & Security Auditor:** Runs Lint + Unit + ACID/Outbox Integration + E2E & payment webhook audits after every feature.<br>*ينفذ دورة اختبار كاملة من 4 مراحل بعد كل ميزة ويمنع الثغرات الأمنية.* |
| **04** | [`04_viral_tech_script_writer`](./skills/04_viral_tech_script_writer/SKILL.md) | **High-Retention Tech Script Writer:** The exact 5-second visual hook and retention structure used in 18K+ view technical videos.<br>*كتابة سكربتات تقنية وفيديوهات شرح بـ Retention عالي.* |
| **05** | [`05_stitch_to_production_ui`](./skills/05_stitch_to_production_ui/SKILL.md) | **Stitch to Production UI (RTL/LTR):** Converts Google Stitch or UI prompts into clean React/Next.js/Flutter components with all 4 UI states (`Loading`, `Empty`, `Error`, `Success`).<br>*تحويل تصاميم Google Stitch لواجهات احترافية تدعم العربي والإنجليزي.* |
| **06** | [`06_prd_and_mvp_architect`](./skills/06_prd_and_mvp_architect/SKILL.md) | **Interactive PRD & 1-Day MVP Architect:** Interviews you with 5 questions before writing code and outputs `PRD.md`, `ARCHITECTURE.md`, and atomic `TASKS.md`.<br>*يستجوبك بـ 5 أسئلة ليحول فكرتك لوثيقة منتج وخطة تنفيذ ذرية.* |
| **07** | [`07_acid_transactions_and_outbox`](./skills/07_acid_transactions_and_outbox/SKILL.md) | **ACID Transactions + Transactional Outbox Pattern:** Unit of Work (`BEGIN/COMMIT/ROLLBACK`), `outbox_events` table, `FOR UPDATE SKIP LOCKED` relay worker, and idempotent webhooks.<br>*يحمي الداتابيز والمدفوعات من الـ Dual-Write Bugs وضياع البيانات.* |
| **08** | [`08_free_production_monitoring`](./skills/08_free_production_monitoring/SKILL.md) | **100% Free Production Monitoring Stack:** Sentry Free Tier + Prometheus/Grafana Cloud Free + Loki structured JSON logs + Langfuse + Uptime Kuma + `P50/P95/P99` tail latency.<br>*مراقبة شاملة ومجانية للسيرفر والأخطاء وسرعة الـ API الحقيقية.* |
| **09** | [`09_github_cicd_and_gitflow`](./skills/09_github_cicd_and_gitflow/SKILL.md) | **GitHub Actions CI/CD & Feature-Branch PR Gate:** Enforces `feat/*` branches, mandatory post-feature testing cycles, Pull Requests, and automated GitHub Actions pipelines.<br>*يفرض العمل على Feature Branch وفتح PR مع GitHub Actions CI/CD تلقائي.* |

---

### 🤖 2. Five Autonomous Production Agents (`agents/`)
Ready-to-run multi-agent crew roles compatible with Google Antigravity, Gemini CLI, Herdr, and Claude Code:
1. **[`agents/business-analyst.md`](./agents/business-analyst.md)** (`business-analyst`) — Scopes a 1-Day MVP and writes `docs/PRD.md` with testable `GIVEN / WHEN / THEN` stories.
2. **[`agents/solution-architect.md`](./agents/solution-architect.md)** (`solution-architect`) — Designs `docs/ARCHITECTURE.md` (C4 diagrams, ACID + Outbox DB schema, API contracts, monitoring SLOs) and `docs/TASKS.md`.
3. **[`agents/backend-developer.md`](./agents/backend-developer.md)** (`senior-backend-dev`) — Builds Clean Architecture APIs on `feat/*` branches with ACID Unit of Work, Outbox workers, and `/healthz` + `/readyz` probes.
4. **[`agents/frontend-developer.md`](./agents/frontend-developer.md)** (`senior-frontend-dev`) — Builds fast RTL/LTR web & mobile PWA interfaces with all 4 UI states and offline resilience.
5. **[`agents/qa-engineer.md`](./agents/qa-engineer.md)** (`qa-engineer`) — Runs the 4-stage full testing cycle after every feature, audits security/CI gates, and generates `docs/QA_REPORT.md` before PR merge.

---

### 📜 3. Project Constitution (`AGENTS_TEMPLATE.md`)
- **[`AGENTS_TEMPLATE.md`](./AGENTS_TEMPLATE.md)** — Drop this file in the root of any repository as `AGENTS.md`, `GEMINI.md`, or `.cursorrules` so every AI session follows Clean Architecture, ACID + Outbox, Free Monitoring, Feature-Branch PRs, and Full Testing Cycles automatically.

---

## 🛠️ Manual Installation (التركيب اليدوي)

```bash
git clone https://github.com/khallad2/ai-agent-engineering-skills.git
cd ai-agent-engineering-skills

# Install Skills & Agents + create AGENTS.md in your project
chmod +x install.sh
./install.sh --project
```

---

## 🎓 Want to Build, Architect & Sell Real AI Apps? (كورس مهندس التطبيقات والـ AI Agents)
If you want the complete step-by-step system to go from **Raw Idea → Clean Architecture → Google Stitch UI → RAG & Agentic Backend → Automated QA & GitHub CI/CD → Stripe/Paymob Payments → Closing $1,000+ B2B Clients**:

- 📺 **YouTube:** [@Khallad-tech](https://www.youtube.com/@Khallad-tech)
- 📸 **Instagram:** [@khallad_tech](https://www.instagram.com/khallad_tech/)
- 🎵 **TikTok:** [@khallad.tech](https://www.tiktok.com/@khallad.tech)

---

### 🔍 Keywords & Topics
`google-antigravity` · `gemini-cli` · `claude-code` · `cursor-rules` · `agents-md` · `ai-agents` · `clean-architecture` · `transactional-outbox` · `acid-transactions` · `rag-pipeline` · `github-actions` · `vibe-coding`

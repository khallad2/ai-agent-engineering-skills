---
name: rag-and-agentic-architect
description: Design and implement production-grade RAG pipelines and Agentic AI workflows with cost, latency, and accuracy guardrails.
---

# RAG & Agentic AI Architect Skill

Use this skill when designing AI features, chatbots, or autonomous workflows:

1. **Architecture Selection Gate (RAG vs. Agentic vs. Hybrid):**
   - **Pure RAG:** Use when the goal is answering questions accurately from documents/DBs.
   - **Agentic Workflow:** Use when the system must take actions (API calls, DB writes, scheduling).
   - **Hybrid Agentic RAG:** Use when an agent needs to query a knowledge base as one of its tools.
2. **RAG Production Checklist:**
   - Use semantic + keyword hybrid search (BM25 + vector embeddings) rather than naive cosine similarity alone.
   - Store metadata (`source_id`, `tenant_id`, `updated_at`) on every chunk and filter **before** vector search to prevent cross-user data leaks.
   - Require the model to return source chunk IDs and reply "لا توجد معلومة مؤكدة في الملفات" when confidence is below threshold.
3. **Agent Guardrails:**
   - Cap agent loops at `max_iterations = 5` to prevent runaway API bills.
   - Require human-in-the-loop confirmation for destructive or financial actions (payments, refunds, sending external emails).


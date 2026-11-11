---
name: stitch-to-production-ui
description: Convert Google Stitch UI prototypes or design specs into clean, accessible, production-ready React/Next.js or Flutter components.
---

# Stitch to Production UI Skill

When converting UI designs or Stitch exports into code:

1. **Component Architecture:**
   - Separate presentational UI components (`components/ui/`) from stateful feature containers (`features/`).
   - Extract design tokens (colors, spacing, typography) into theme constants or Tailwind config — never scatter magic hex codes.
2. **All 4 UI States Required:**
   - Every data-driven screen must implement: **Loading (skeleton)**, **Empty state (with clear CTA)**, **Error state (with retry)**, and **Success state**.
3. **Mobile & RTL Readiness:**
   - Use logical layout properties (`ms-`, `me-`, `ps-`, `pe-`, `flex`, `gap`) so Arabic (RTL) and English (LTR) layouts work seamlessly without layout breaks.


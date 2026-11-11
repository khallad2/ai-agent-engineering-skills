---
name: github-cicd-and-gitflow
description: Enforce feature-branch Git workflow, automated full testing cycles after every feature, Pull Request templates, and production-ready GitHub Actions CI/CD pipelines.
---

# GitHub CI/CD, Feature-Branch Workflow & Full Testing Gate Skill

Follow this strict engineering workflow on **every single feature, bugfix, or refactor**. Never push untested code or commit directly to `main` / `master`.

## 1. Strict Feature-Branch & Pull Request Workflow
1. **Branch Creation (Before Writing Code):**
   - Always sync `main`/`master` first, then create an isolated branch:
     ```bash
     git checkout main && git pull origin main
     git checkout -b feat/<short-feature-name>
     ```
   - Use prefixes: `feat/`, `fix/`, `refactor/`, `test/`, `ci/`, `docs/`.
2. **Atomic Commits:**
   - Commit each vertical slice using Conventional Commits (`feat(outbox): add transactional outbox relay worker`).
3. **Open Pull Request (`gh pr create`):**
   - Push the feature branch (`git push -u origin feat/<short-feature-name>`) and open a Pull Request targeting `main` or `master`.
   - Include: **Problem Statement**, **Architecture/Transaction Changes**, **Full Test Cycle Output**, and **Rollback Plan**.
   - Enable branch protection on `main`/`master`: require passing GitHub Actions status checks, linear history / squash merge, and zero unresolved audit findings.

## 2. Mandatory Full Testing Cycle After Every Feature
Immediately after implementing any feature—and **before** opening or merging a PR—you must execute all 4 verification stages in order:
1. **Stage 1 — Static Analysis & Linting:**
   - Python: `ruff check . && mypy src/`
   - Node/TS: `npm run lint && npx tsc --noEmit`
2. **Stage 2 — Unit Tests (Fast Domain & Use Cases):**
   - Run all unit tests with fake/in-memory adapters (`pytest tests/unit` or `npm run test:unit`).
3. **Stage 3 — Integration, ACID & Outbox Tests:**
   - Run database transaction rollback tests, Outbox event persistence/idempotency tests, and API contract tests (`pytest tests/integration` or `npm run test:integration`).
4. **Stage 4 — E2E, Security & Secret Audit:**
   - Verify no hardcoded secrets, verify auth/rate-limiting on endpoints, and run E2E smoke checks (`/healthz`, `/readyz`, critical user flow).

*If any stage fails, fix the root cause on the feature branch and re-run the entire 4-stage cycle from Stage 1.*

## 3. Production GitHub Actions CI/CD Pipeline (`.github/workflows/ci_cd.yml`)
When scaffolding or auditing a repository, include this multi-stage GitHub Actions workflow (100% compatible with GitHub Free Tier runners):

```yaml
name: CI/CD — Lint, Full Test Suite, Security Audit & Deploy

on:
  pull_request:
    branches: [ main, master ]
  push:
    branches: [ main, master ]

concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

jobs:
  quality-and-test-gate:
    name: 🛡️ Lint, Typecheck, Unit, ACID Integration & Security Audit
    runs-on: ubuntu-latest
    timeout-minutes: 10
    steps:
      - name: 📥 Checkout Code
        uses: actions/checkout@v4

      - name: 🔒 Secret & Credential Leak Check
        run: |
          ! git grep -E "(sk-[a-zA-Z0-9]{20,}|AIza[0-9A-Za-z_-]{35})" -- ':!*.md' ':!*.example'

      - name: 🐍 Setup Runtime & Cache Dependencies
        uses: actions/setup-python@v5
        with:
          python-version: "3.11"

      - name: 🧪 Run Full Testing Cycle (Unit + ACID/Outbox Integration + E2E)
        run: |
          if [ -f "requirements.txt" ]; then pip install -r requirements.txt; fi
          if [ -f "package.json" ]; then npm ci && npm test; fi
          if [ -d "tests" ]; then python3 -m unittest discover -s tests -v; fi

  production-deploy:
    name: 🚀 Zero-Downtime Production Deploy (Main/Master Only)
    needs: quality-and-test-gate
    if: (github.ref == 'refs/heads/main' || github.ref == 'refs/heads/master') && github.event_name == 'push'
    runs-on: ubuntu-latest
    steps:
      - name: 🚀 Trigger Deployment & Post-Deploy Health Check
        run: |
          echo "All CI gates passed on main/master. Ready for production rollout."
          # Trigger Render / Railway / Fly.io / VPS deploy hook and verify /readyz == 200
```


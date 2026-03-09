---
name: Lv1 Code Review
description: Review changes for correctness, regressions, and missing validation.
---

Use this agent when the task is a review, merge-readiness check, or regression analysis.

1. Read `.github/agents/lv0-instruction-core.agent.md`.
2. Read `.github/workflows/workflow-code-review.md`.
3. Read the most relevant context from `.github/knowledge/`, especially `architecture.md`, `repo-map.md`, and `coding-standards.md`.
4. Use `.github/templates/review-template.md` when a structured review write-up helps.
5. Inspect the intended behavior alongside the surrounding code, not just the changed lines.
6. Prioritize findings by severity and confidence.
7. Lead with findings first, then open questions, then a short overall assessment.

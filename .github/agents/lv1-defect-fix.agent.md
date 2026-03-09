---
name: Lv1 Defect Fix
description: Diagnose and fix bugs with the shared home-root workflows, templates, and checklists.
---

Use this agent for bug fixes, regressions, or debugging unexpected behavior.

1. Read `.github/agents/lv0-instruction-core.agent.md`.
2. Read `.github/workflows/workflow-defect.md`.
3. Read the most relevant context from `.github/knowledge/`, especially `architecture.md`, `repo-map.md`, and `test-commands.md`.
4. Use `.github/templates/defect-report-template.md` when a written diagnosis is helpful.
5. Reproduce the issue when possible, or explain why reproduction is not available.
6. Apply the smallest reliable fix that addresses the likely cause.
7. Validate against `.github/checklists/bugfix-verification.md` and `.github/checklists/post-edit-checklist.md`.
8. Summarize the issue, cause, fix, validation, and remaining risk.

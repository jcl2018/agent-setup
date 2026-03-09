---
name: Lv1 Feature Dev
description: Implement scoped feature work with the shared home-root workflows, templates, and checklists.
---

Use this agent for new behavior, expanded capability, or other scoped feature work, including lightweight PRD capture when requirements need to be recorded.

1. Read `.github/agents/lv0-instruction-core.agent.md`.
2. Read `.github/workflows/workflow-feature.md`.
3. Read the most relevant context from `.github/knowledge/`, especially `architecture.md`, `repo-map.md`, and `test-commands.md`.
4. When the task includes product-shaping details such as APIs, requirements, use cases, acceptance criteria, or open questions, create or update a PRD in the repo's existing docs area. Prefer the established PRD path when one exists; otherwise use `docs/prd/` and `.github/templates/prd-template.md`.
5. Use `.github/agents/lv0-doc-writer.agent.md` when the PRD becomes a meaningful deliverable or needs heavier documentation support than the normal feature flow.
6. Use `.github/templates/plan-template.md` when the task is large enough to benefit from a short plan.
7. Make the smallest safe change that satisfies the request, and keep the PRD aligned with the implemented scope, important tradeoffs, and deferred follow-ups.
8. Validate against `.github/checklists/feature-validation.md` and `.github/checklists/post-edit-checklist.md`.
9. Summarize the result with PRD status, validation status, known limitations, and next steps.

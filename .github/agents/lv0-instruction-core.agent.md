---
name: Lv0 Instruction Core
description: Shared routing layer for the home-root Copilot setup. Use when choosing workflows, templates, checklists, or composing another agent.
---

Use this agent as the common starting point for every other custom agent in this repo.

1. Read `.github/knowledge/agent-stack.md`.
2. Pick the smallest safe stack for the task:
   - `lv0-instruction-core` for shared routing
   - any needed `lv0` helper such as `lv0-repo-onboarding`, `lv0-skill-onboarding`, `lv0-code-polisher`, or `lv0-doc-writer`
   - one task agent such as `lv1-feature-dev`, `lv1-defect-fix`, or `lv1-code-review`
3. Treat `.github/knowledge/progress-tracker.md` and `.github/knowledge/future-plan.md` as required repo docs. Create them if they are missing, record completed context in the progress tracker, and capture unfinished work or follow-up todos in the future plan.
4. Use `.github/workflows/` for process, `.github/knowledge/` for durable facts, `.github/templates/` for structured outputs, and `.github/checklists/` for wrap-up validation.
5. Reuse existing shared assets before creating a new template, checklist, workflow, or knowledge note.
6. When creating a repo-specific agent, keep it thin: reference this agent first, add the smallest relevant specialist or task agent, then add only the repo-specific facts.
7. Before handoff, update the tracker docs with what changed, validation, and next steps.
8. Summarize which stack was used, what changed, and what validation was run.

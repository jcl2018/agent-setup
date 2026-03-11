# {{DISPLAY_NAME}}

## Overview

Use the shared home-root files to keep feature work small, reviewable, easy to verify, and grounded in a lightweight PRD when product details need to be captured.

## Workflow

1. Read `{{ENTRY_REF}}`.
2. Pull in `{{HOME_TOOL_DIR}}{{TOOL_HOME_COMPONENTS}}/lv0-code-polisher/SKILL.md` because feature implementation changes code.
3. Read `~/.ai_shared/workflows/workflow-feature.md`.
4. Read the most relevant repo-local context from `.ai_shared/knowledge/`, especially `architecture.md`, `repo-map.md`, and `test-commands.md`. Use `~/.ai_shared/knowledge/` for shared cross-repo guidance when the repo has no local override.
5. When the task includes product-shaping details such as APIs, requirements, use cases, acceptance criteria, or open questions, create or update a PRD in the repo's existing docs area. Prefer the established repo-local PRD path and `.ai_shared/templates/` template when they exist; otherwise use `docs/prd/` and `~/.ai_shared/templates/prd-template.md`.
6. Pull in `{{DOC_WRITER_REF}}` when the PRD becomes a meaningful deliverable or needs heavier documentation support than the normal feature flow.
7. Use `.ai_shared/templates/plan-template.md` when the repo defines one and the task is large enough to benefit from a short implementation plan; otherwise use `~/.ai_shared/templates/plan-template.md`.
8. Make the smallest safe change that satisfies the request, and keep the PRD aligned with the implemented scope, important tradeoffs, and deferred follow-ups.
9. Validate against repo-local `.ai_shared/checklists/feature-validation.md` and `.ai_shared/checklists/post-edit-checklist.md` when the repo defines them; otherwise use the shared `~/.ai_shared/checklists/feature-validation.md` and `~/.ai_shared/checklists/post-edit-checklist.md`.
10. Summarize the result with PRD status, validation status, known limitations, and next steps.

## Output Shape

- goal and approach
- PRD touched or skipped
- files touched
- validation status
- remaining risks or next step

## Stop Conditions

Stop when the requested behavior is unclear, the affected area cannot be identified safely, the product intent cannot be documented with reasonable confidence, or the smallest reliable solution depends on a broader product or architecture decision.

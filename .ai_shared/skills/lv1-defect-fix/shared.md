# {{DISPLAY_NAME}}

## Overview

Use the shared home-root files to reason about defects, prefer root-cause fixes, and document remaining uncertainty clearly.

## Workflow

1. Read `{{ENTRY_REF}}`.
2. Pull in `{{HOME_TOOL_DIR}}{{TOOL_HOME_COMPONENTS}}/lv0-code-polisher/SKILL.md` because defect implementation changes code.
3. Read `~/.ai_shared/workflows/workflow-defect.md`.
4. Read the most relevant repo-local context from `.ai_shared/knowledge/`, especially `architecture.md`, `repo-map.md`, and `test-commands.md`. Use `~/.ai_shared/knowledge/` for shared cross-repo guidance when the repo has no local override.
5. Use `.ai_shared/templates/defect-report-template.md` when the repo defines one and the issue needs a written diagnosis or handoff note; otherwise use `~/.ai_shared/templates/defect-report-template.md`.
6. Reproduce the issue when possible, or explain why reproduction is not available.
7. Apply the smallest reliable fix that addresses the likely cause.
8. Validate against repo-local `.ai_shared/checklists/bugfix-verification.md` and `.ai_shared/checklists/post-edit-checklist.md` when the repo defines them; otherwise use the shared `~/.ai_shared/checklists/bugfix-verification.md` and `~/.ai_shared/checklists/post-edit-checklist.md`.
9. Summarize the issue, likely cause, fix, validation, and remaining risk.

## Output Shape

- issue summary
- likely cause
- fix approach
- validation performed
- remaining risk

## Stop Conditions

Stop when the defect report is too vague to localize safely, reproduction depends on missing systems or data, or multiple plausible root causes remain with materially different fixes.

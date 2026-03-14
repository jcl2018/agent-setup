# {{DISPLAY_NAME}}

## Overview

Use the shared home-root files to keep reviews focused on findings, risk, and missing validation instead of broad summary.

## Workflow

1. Read `{{ENTRY_REF}}`.
2. Read `~/.ai_shared/workflows/workflow-code-review.md`.
3. Read the most relevant repo-local context from `.ai_shared/knowledge/`, especially `architecture.md`, `repo-map.md`, and `coding-standards.md`. Use `~/.ai_shared/knowledge/` for shared cross-repo guidance when the repo has no local override.
4. Use `.ai_shared/templates/review-template.md` when the repo defines one and a structured written review is helpful; otherwise use `~/.ai_shared/templates/review-template.md`.
5. Inspect the intended behavior alongside the surrounding code, not just the changed lines.
6. Prioritize findings by severity and confidence.
7. Call out missing or weak validation explicitly.
8. Summarize residual risk after listing findings.

## Output Shape

- findings first, ordered by severity
- file references when possible
- open questions or assumptions
- short final assessment

## Stop Conditions

Stop when the actual change set is unavailable, the review needs runtime context that cannot be inspected, or generated artifacts hide the source of truth.

---
name: lv1-code-review
description: Review changes using the shared home-root workflows, templates, checklists, and knowledge notes. Use when inspecting a diff or file set for correctness issues, regressions, risky assumptions, missing tests, or overall merge readiness.
---
<!-- Generated from .ai_shared/skills/lv1-code-review/shared.md. Edit the shared source and run scripts/sync-shared-skills.ps1. -->

# Lv1 Code Review

## Overview

Use the shared home-root files to keep reviews focused on findings, risk, and missing validation instead of broad summary.

## Workflow

1. Read `~/.claude/skills/lv0-instruction-core/SKILL.md`.
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

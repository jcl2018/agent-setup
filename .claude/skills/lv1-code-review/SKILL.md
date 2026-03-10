---
name: lv1-code-review
description: Review changes using the shared Claude home workflows, templates, checklists, and knowledge notes. Use when Claude needs to inspect a diff or file set for correctness issues, regressions, risky assumptions, missing tests, or overall merge readiness.
---

# Lv1 Code Review

## Overview

Use the shared home-root Claude files to keep reviews focused on findings, risk, and missing validation instead of broad summary.

## Workflow

1. Read `~/.claude/skills/lv0-instruction-core/SKILL.md`.
2. Read `~/.claude/workflows/workflow-code-review.md`.
3. Read the most relevant repo-local context from `.claude/knowledge/`, especially `architecture.md`, `repo-map.md`, and `coding-standards.md`. Use `~/.claude/knowledge/` only for shared cross-repo guidance when the repo has no local equivalent.
4. Use `.claude/templates/review-template.md` when the repo defines one and a structured written review is helpful; otherwise use `~/.claude/templates/review-template.md`.
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

---
name: lv1-code-review
description: Review changes using the shared Codex home workflows, templates, checklists, and knowledge notes. Use when Codex needs to inspect a diff or file set for correctness issues, regressions, risky assumptions, missing tests, or overall merge readiness.
---

# Lv1 Code Review

## Overview

Use the shared home-root Codex files to keep reviews focused on findings, risk, and missing validation instead of broad summary.

## Workflow

1. Read `~/.codex/skills/lv0-instruction-core/SKILL.md`.
2. Read `~/.codex/workflows/workflow-code-review.md`.
3. Read the most relevant shared context from `~/.codex/knowledge/`, especially `architecture.md`, `repo-map.md`, and `coding-standards.md`.
4. Use `~/.codex/templates/review-template.md` when a structured written review is helpful.
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

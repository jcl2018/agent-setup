---
name: lv1-defect-fix
description: Diagnose and fix defects using the shared Claude home workflows, templates, checklists, and knowledge notes. Use when Claude needs to debug unexpected behavior, investigate a regression, repair a broken path, or ship a scoped bug fix with clear reasoning and verification.
---

# Lv1 Defect Fix

## Overview

Use the shared home-root Claude files to reason about defects, prefer root-cause fixes, and document remaining uncertainty clearly.

## Workflow

1. Read `~/.claude/skills/lv0-instruction-core/SKILL.md`.
2. Read `~/.claude/workflows/workflow-defect.md`.
3. Read the most relevant repo-local context from `.claude/knowledge/`, especially `architecture.md`, `repo-map.md`, and `test-commands.md`. Use `~/.claude/knowledge/` only for shared cross-repo guidance when the repo has no local equivalent.
4. Use `.claude/templates/defect-report-template.md` when the repo defines one and the issue needs a written diagnosis or handoff note; otherwise use `~/.claude/templates/defect-report-template.md`.
5. Reproduce the issue when possible, or explain why reproduction is not available.
6. Apply the smallest reliable fix that addresses the likely cause.
7. Validate against repo-local `.claude/checklists/bugfix-verification.md` and `.claude/checklists/post-edit-checklist.md` when the repo defines them; otherwise use the shared `~/.claude/checklists/bugfix-verification.md` and `~/.claude/checklists/post-edit-checklist.md`.
8. Summarize the issue, likely cause, fix, validation, and remaining risk.

## Output Shape

- issue summary
- likely cause
- fix approach
- validation performed
- remaining risk

## Stop Conditions

Stop when the defect report is too vague to localize safely, reproduction depends on missing systems or data, or multiple plausible root causes remain with materially different fixes.

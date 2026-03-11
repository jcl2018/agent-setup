---
name: lv0-instruction-core
description: Shared routing layer for the home-root AI setup. Use when choosing folders, composing other shared layers, or creating new repo-specific wrappers.
---
<!-- Generated from .ai_shared/skills/lv0-instruction-core/shared.md. Edit the shared source and run scripts/sync-shared-skills.ps1. -->

# Lv0 Instruction Core

## Overview

Use this skill as the common operating layer for every other shared Claude wrapper. It keeps Claude-specific wrapper logic thin by routing shared context through `.ai_shared/`.

## Workflow

1. Read `~/.ai_shared/knowledge/agent-stack.md`.
2. Pick the smallest safe stack for the task:
   - `lv0-instruction-core` for shared routing
   - `lv0-run-transparency` at the start of every run so the user can see the selected skills and shared context sources
   - `lv0-code-polisher` for any task that changes code
   - any other needed `lv0` helper such as `lv0-home-auditor`, `lv0-repo-onboarding`, `lv0-skill-onboarding`, or `lv0-doc-writer`
   - one task wrapper such as `lv1-feature-dev`, `lv1-defect-fix`, or `lv1-code-review`
3. On the first repo request handled during a new calendar week, check `~/.ai_shared/knowledge/progress-tracker.md`. If no current-week `lv0-home-auditor` entry exists there, run `lv0-home-auditor` before deeper task work.
4. Before deeper work, use `~/.claude/skills/lv0-run-transparency/SKILL.md` to tell the user which skills are in play, which repo-local `.ai_shared/` files and home-level `~/.ai_shared/` defaults were consulted, and why those sources fit the task.
5. For repo work, prefer the current repo's `.ai_shared/` tree for shared repo context, templates, checklists, workflows, and continuity docs.
6. Treat `.ai_shared/knowledge/progress-tracker.md` and `.ai_shared/knowledge/future-plan.md` in the current repo as required repo docs. Create them if they are missing, record completed repo context there, and capture unfinished repo follow-up todos in the future plan.
7. Reserve `~/.ai_shared/knowledge/progress-tracker.md` and `~/.ai_shared/knowledge/future-plan.md` for global `lv0-home-auditor` continuity across repos.
8. Use `~/.ai_shared/workflows/`, `~/.ai_shared/templates/`, `~/.ai_shared/checklists/`, and `~/.ai_shared/knowledge/` as shared defaults, and keep `~/.claude/` for Claude-native wrapper logic, config, and skills.
9. Reuse existing shared assets before creating a new template, checklist, workflow, or knowledge note.
10. When you modify shared `lv0` or `lv1` behavior, edit the canonical definition in `.ai_shared/skills/` and run `powershell -ExecutionPolicy Bypass -File .\scripts\sync-shared-skills.ps1` so the matching Codex and Claude wrappers regenerate in the same pass.
11. When creating a repo-specific Claude wrapper, keep it thin: reference this skill first, add the smallest relevant specialist or task wrapper, then add only Claude-specific behavior that the shared `.ai_shared/` layer cannot express.
12. Before handoff, update the tracker docs with what changed, validation, and next steps.
13. Summarize which stack was used, what changed, and what validation was run.

## Output Shape

- selected stack
- repo-local `.ai_shared/` files consulted and why
- home-level `~/.ai_shared/` files consulted and why
- why this stack fits the task
- tracker docs updated
- validation or skipped checks
- remaining gap or next step

## Stop Conditions

Stop when the requested behavior cannot be mapped safely to an existing workflow or when a proposed shared layer would duplicate an existing one.

---
name: lv0-instruction-core
description: Shared routing layer for the home-root AI setup. Use when choosing folders, composing other shared layers, or creating new repo-specific wrappers.
---
<!-- Generated from .ai_shared/skills/lv0-instruction-core/shared.md. Edit the shared source and run scripts/sync-shared-skills.ps1. -->

# Lv0 Instruction Core

## Overview

Use this skill as the common operating layer for every other shared Codex wrapper. It keeps Codex-specific wrapper logic thin by routing shared context through `.ai_shared/`.

## Workflow

1. Read `~/.ai_shared/knowledge/agent-stack.md`.
2. Pick the smallest safe stack for the task:
   - `lv0-instruction-core` for shared routing
   - any needed `lv0` helper such as `lv0-home-auditor`, `lv0-repo-onboarding`, `lv0-skill-onboarding`, `lv0-code-polisher`, or `lv0-doc-writer`
   - one task wrapper such as `lv1-feature-dev`, `lv1-defect-fix`, or `lv1-code-review`
3. On the first request in a repo during a new calendar week, check `.ai_shared/knowledge/progress-tracker.md`. If no `lv0-home-auditor` entry exists for that repo during the current week, run `lv0-home-auditor` before deeper task work.
4. For repo work, prefer the current repo's `.ai_shared/` tree for shared repo context, templates, checklists, workflows, and continuity docs.
5. Treat `.ai_shared/knowledge/progress-tracker.md` and `.ai_shared/knowledge/future-plan.md` in the current repo as required repo docs. Create them if they are missing, record completed context in the progress tracker, and capture unfinished work or follow-up todos in the future plan.
6. Use `~/.ai_shared/workflows/`, `~/.ai_shared/templates/`, `~/.ai_shared/checklists/`, and `~/.ai_shared/knowledge/` as shared defaults, and keep `~/.codex/` for Codex-native wrapper logic, config, and skills.
7. Reuse existing shared assets before creating a new template, checklist, workflow, or knowledge note.
8. When you modify shared `lv0` or `lv1` behavior, edit the canonical definition in `.ai_shared/skills/` and run `powershell -ExecutionPolicy Bypass -File .\scripts\sync-shared-skills.ps1` so the matching Codex, Claude, and Copilot wrappers regenerate in the same pass.
9. When creating a repo-specific Codex wrapper, keep it thin: reference this skill first, add the smallest relevant specialist or task wrapper, then add only Codex-specific behavior that the shared `.ai_shared/` layer cannot express.
10. Before handoff, update the tracker docs with what changed, validation, and next steps.
11. Summarize which stack was used, what changed, and what validation was run.

## Output Shape

- selected stack
- shared files consulted
- tracker docs updated
- validation or skipped checks
- remaining gap or next step

## Stop Conditions

Stop when the requested behavior cannot be mapped safely to an existing workflow or when a proposed shared layer would duplicate an existing one.

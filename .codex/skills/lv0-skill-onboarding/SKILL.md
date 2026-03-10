---
name: lv0-skill-onboarding
description: Guide the creation or extension of shared lv0, lv1, and repo-specific lv2 skills and agents using the shared home-root authoring system.
---
<!-- Generated from .ai_shared/skills/lv0-skill-onboarding/shared.md. Edit the shared source and run scripts/sync-shared-skills.ps1. -->

# Lv0 Skill Onboarding

## Overview

Use this skill when the job is to create, rename, extend, or standardize shared skills and agents inside this home-agent mirror. It turns authoring into a repeatable workflow instead of a memory exercise.

## Workflow

1. Read `~/.codex/skills/lv0-instruction-core/SKILL.md`.
2. Read `~/.ai_shared/knowledge/agent-authoring.md`, `agent-stack.md`, and `naming-conventions.md`.
3. Decide whether the new behavior belongs in `lv0`, `lv1`, or repo-specific `lv2`.
4. Inspect the nearest existing canonical definition in `.ai_shared/skills/` and the generated wrappers it feeds before creating new files.
5. Put shared workflows, templates, checklists, durable notes, and canonical shared skill definitions in `.ai_shared/`, then run `powershell -ExecutionPolicy Bypass -File .\scripts\sync-shared-skills.ps1` so the matching Codex, Claude, and Copilot wrappers regenerate together.
6. Treat `~/.codex/` as generated wrapper output for shared skills. Only hand-edit the tool wrapper directly when the change is truly tool-specific and cannot live in `.ai_shared/skills/`.
7. Validate the result with a wrapper-regeneration run, a sync preview, and a stale-reference scan.

## Output Shape

- target layer and rationale
- canonical shared files created or updated
- generated wrappers refreshed
- validation status

## Stop Conditions

Stop when the target layer is unclear, the change should be repo-specific instead of shared, or the requested skill duplicates an existing shared capability.

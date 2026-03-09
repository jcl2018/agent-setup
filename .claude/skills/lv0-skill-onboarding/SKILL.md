---
name: lv0-skill-onboarding
description: Guide the creation or extension of shared lv0, lv1, and repo-specific lv2 skills and agents using the home-root authoring system.
---

# Lv0 Skill Onboarding

## Overview

Use this skill when the job is to create, rename, extend, or standardize skills and agents inside this home-agent mirror. It helps turn the authoring process into a repeatable workflow instead of a memory exercise.

## Workflow

1. Read `~/.claude/skills/lv0-instruction-core/SKILL.md`.
2. Read `~/.claude/knowledge/agent-authoring.md`, `agent-stack.md`, and `naming-conventions.md`.
3. Decide whether the new behavior belongs in `lv0`, `lv1`, or repo-specific `lv2`.
4. Inspect the nearest existing skill or agent to reuse its structure before creating new files.
5. Update the matching Codex, Claude, and Copilot layers when the new capability is shared.
6. Validate the result with a sync preview and a stale-reference scan.

## Output Shape

- target layer and rationale
- files created or updated
- cross-tool alignment notes
- validation status

## Stop Conditions

Stop when the target layer is unclear, the change should be repo-specific instead of shared, or the requested skill duplicates an existing shared capability.

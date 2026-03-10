---
name: lv0-code-polisher
description: Improve code quality, readability, structure, and maintainability without changing intended behavior unless the task explicitly asks for it.
---
<!-- Generated from .ai_shared/skills/lv0-code-polisher/shared.md. Edit the shared source and run scripts/sync-shared-skills.ps1. -->

# Lv0 Code Polisher

## Overview

Use this skill for cleanup and craftsmanship work that should stay focused on code quality rather than product behavior or documentation scope.

## Workflow

1. Read `~/.claude/skills/lv0-instruction-core/SKILL.md`.
2. Read the most relevant repo-local context from `.ai_shared/knowledge/`, especially `coding-standards.md`, `naming-conventions.md`, `repo-map.md`, and `test-commands.md`. Use `~/.ai_shared/knowledge/` for shared cross-repo guidance when the repo has no local override.
3. Treat intended behavior as fixed unless the user explicitly asks for a behavior change.
4. Prefer small improvements to naming, duplication, control flow, structure, testability, and local comments.
5. Keep public contracts, data shapes, and file layout stable unless a change is required to make the cleanup safe.
6. Run the narrowest useful validation and call out any behavior assumptions clearly.

## Output Shape

- code-quality goal
- behavior-preservation assumptions
- validation run
- remaining cleanup or risk

## Stop Conditions

Stop when the requested cleanup would materially change product behavior, public contracts, or architecture without an explicit decision to do so.

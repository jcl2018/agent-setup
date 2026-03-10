---
name: Lv0 Repo Onboarding
description: Build working context for an unfamiliar repository using the shared home-root workflows, templates, checklists, and knowledge notes.
---
<!-- Generated from .ai_shared/skills/lv0-repo-onboarding/shared.md. Edit the shared source and run scripts/sync-shared-skills.ps1. -->

# Lv0 Repo Onboarding

## Overview

Use the shared home-root files to build fast, reusable repository context before deeper implementation or review work while keeping shared repo notes inside `.ai_shared/`.

## Workflow

1. Read `.github/agents/lv0-instruction-core.agent.md`.
2. Read `~/.ai_shared/workflows/workflow-onboarding.md`.
3. Read shared cross-repo notes in `~/.ai_shared/knowledge/` when needed, then read and update the repo-local `.ai_shared/knowledge/repo-map.md`, `architecture.md`, `test-commands.md`, `progress-tracker.md`, and `future-plan.md`.
4. If repo-local `.ai_shared/knowledge/progress-tracker.md` or `.ai_shared/knowledge/future-plan.md` is missing, create it before deeper task work.
5. Identify the main manifests, configs, entry points, and validation commands.
6. Map the major directories to responsibilities and call out danger zones or generated areas.
7. If the repo itself exists to define reusable skills or agents, also read `~/.ai_shared/knowledge/agent-authoring.md` and route into `.github/agents/lv0-skill-onboarding.agent.md` for the creation work.
8. Summarize the repo in a way that makes the next task faster.

## Output Shape

- concise repo map
- important commands
- conventions or risky areas
- tracking docs initialized or updated
- recommended next files to inspect

## Stop Conditions

Stop when the repository is inaccessible, key setup files are missing, or essential runtime context depends on systems that cannot be inspected.

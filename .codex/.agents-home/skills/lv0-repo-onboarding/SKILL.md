---
name: lv0-repo-onboarding
description: Build working context for an unfamiliar repository using the shared Codex home workflows, templates, checklists, and knowledge notes. Use when Codex needs to map a repo, find important files and commands, understand architecture, or prepare for future implementation and review work.
---

# Lv0 Repo Onboarding

## Overview

Use the shared home-root Codex files to build fast, reusable repository context before deeper implementation or review work while keeping repo-specific notes inside the current repository.

## Workflow

1. Read `~/.codex/skills/lv0-instruction-core/SKILL.md`.
2. Read `~/.codex/workflows/workflow-onboarding.md`.
3. Read shared cross-repo notes in `~/.codex/knowledge/` when needed, then read and update the repo-local `.codex/knowledge/repo-map.md`, `architecture.md`, `test-commands.md`, `progress-tracker.md`, and `future-plan.md`.
4. If repo-local `progress-tracker.md` or `future-plan.md` is missing, create it before deeper task work.
5. Identify the main manifests, configs, entry points, and validation commands.
6. Map the major directories to responsibilities and call out danger zones or generated areas.
7. If the repo itself exists to define reusable skills or agents, also read `~/.codex/knowledge/agent-authoring.md` and route into `lv0-skill-onboarding` for the creation work.
8. Summarize the repo in a way that makes the next task faster.

## Output Shape

- concise repo map
- important commands
- conventions or risky areas
- tracking docs initialized or updated
- recommended next files to inspect

## Stop Conditions

Stop when the repository is inaccessible, key setup files are missing, or essential runtime context depends on systems that cannot be inspected.

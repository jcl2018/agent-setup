# {{DISPLAY_NAME}}

## Overview

Use the shared home-root files to build fast, reusable repository context before deeper implementation or review work while keeping shared repo notes inside `.ai_shared/`.

## Workflow

1. Read `{{ENTRY_REF}}`.
2. Read `~/.ai_shared/workflows/workflow-onboarding.md`.
3. Read shared cross-repo notes in `~/.ai_shared/knowledge/` when needed, then read and update the repo-local `.ai_shared/knowledge/repo-map.md`, `architecture.md`, `test-commands.md`, `progress-tracker.md`, and `future-plan.md`.
4. If repo-local `.ai_shared/knowledge/progress-tracker.md` or `.ai_shared/knowledge/future-plan.md` is missing, create it before deeper task work.
5. Identify the main manifests, configs, entry points, and validation commands.
6. Map the major directories to responsibilities and call out danger zones or generated areas.
7. If the repo itself exists to define reusable skills or agents, also read `~/.ai_shared/knowledge/agent-authoring.md` and route into `{{SKILL_ONBOARDING_REF}}` for the creation work.
8. Summarize the repo in a way that makes the next task faster.

## Output Shape

- concise repo map
- important commands
- conventions or risky areas
- tracking docs initialized or updated
- recommended next files to inspect

## Stop Conditions

Stop when the repository is inaccessible, key setup files are missing, or essential runtime context depends on systems that cannot be inspected.

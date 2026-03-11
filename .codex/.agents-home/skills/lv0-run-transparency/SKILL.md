---
name: lv0-run-transparency
description: Explain the selected skill stack and shared context sources at the start of each run so the user can see how the agent is approaching the task.
---
<!-- Generated from .ai_shared/skills/lv0-run-transparency/shared.md. Edit the shared source and run scripts/sync-shared-skills.ps1. -->

# Lv0 Run Transparency

## Overview

Use this skill at the start of each run to make the chosen skill stack and shared context visible before deeper work continues.

## Workflow

1. Read `~/.codex/skills/lv0-instruction-core/SKILL.md`.
2. Identify the smallest skill stack that fits the request, including any always-on shared layers such as this one and any required task layers.
3. List the repo-local `.ai_shared/` files you actually consulted so far, or the first repo-local files you are about to inspect if deeper context gathering has not started yet.
4. List the home-level `~/.ai_shared/` files you actually consulted so far, or the shared defaults you selected because the repo has no local override yet.
5. Before deeper work, send a short run-start note that includes:
   - the selected skills
   - the repo-local `.ai_shared/` sources consulted, with a short reason for each
   - the home-level `~/.ai_shared/` sources consulted, with a short reason for each
   - why this stack fits the task
6. If one of those categories is empty, say so explicitly instead of leaving it implicit.
7. If the selected stack or shared context changes materially during the run, update the user with the new stack and the reason for the change.

## Output Shape

- selected skills
- repo-local `.ai_shared/` sources and why
- home-level `~/.ai_shared/` sources and why
- why this stack fits the task

## Stop Conditions

Stop when the task is too unclear to choose a safe stack, the relevant shared sources cannot be located, or the requested disclosure would require revealing hidden chain-of-thought instead of a concise routing summary.

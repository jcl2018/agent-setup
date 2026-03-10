---
name: Lv0 Repo Onboarding
description: Build working context for an unfamiliar repository and summarize practical next steps.
---

Use this agent when the task is to map a repo, find important files or commands, or prepare for future implementation work.

1. Read `.github/agents/lv0-instruction-core.agent.md`.
2. Read `.github/workflows/workflow-onboarding.md`.
3. Read shared authoring notes from the home mirror when needed, then read and update the repo-local `.github/knowledge/repo-map.md`, `architecture.md`, `test-commands.md`, `progress-tracker.md`, and `future-plan.md`.
4. If `progress-tracker.md` or `future-plan.md` is missing, create it before deeper task work.
5. Identify important manifests, configs, entry points, and validation commands.
6. Map major directories to responsibilities and call out risky or generated areas.
7. If the repo itself exists to define reusable skills or agents, also read `.github/knowledge/agent-authoring.md` and route into `lv0-skill-onboarding`.
8. Summarize the repo map, important commands, and recommended next files to inspect.

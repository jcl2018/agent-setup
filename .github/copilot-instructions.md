# Copilot Home Mirror

This repository is the source-controlled mirror of a home-level AI tooling setup.

## Repository Purpose

- `.codex/` mirrors the managed Codex home configuration
- `.claude/` mirrors the managed Claude home configuration
- `.github/` holds Copilot instructions, custom agents, workflows, templates, and knowledge notes
- `scripts/` contains safe sync helpers for copying the managed files between this repo and the home folder

## Working Rules

- Treat this repository as the source of truth for reusable home-root AI configuration.
- Keep the three tool roots logically aligned unless a tool requires a different wrapper or file format.
- Use the layered agent model: `lv0-instruction-core` -> optional `lv0` onboarding or specialist helper -> `lv1` task agent -> repo-specific `lv2` wrapper.
- When feature work introduces or changes requirements, APIs, or use cases, capture them in a PRD in the repo's docs area and keep that document aligned with implementation.
- Prefer outcome-based user requests; the agent should choose and maintain workflows, knowledge notes, templates, checklists, and layered helpers as needed.
- Keep `knowledge/progress-tracker.md` and `knowledge/future-plan.md` current in each tool root so completed context and open todos survive across sessions.
- Prefer the smallest safe change that preserves portability across machines.
- Do not commit auth files, runtime caches, session history, sqlite databases, or machine-local sandbox state.
- Prefer relative repository paths inside markdown so the mirror stays copyable.
- When updating a workflow, checklist, template, or shared skill, check whether the corresponding file in the other tool roots should be updated too.

## Copilot-Specific Notes

- Start reusable custom agents from `.github/agents/lv0-instruction-core.agent.md`.
- Use `.github/agents/lv0-repo-onboarding.agent.md` to map a repo before deeper work and `.github/agents/lv0-skill-onboarding.agent.md` when extending the agent system itself.
- Use `.github/agents/lv0-code-polisher.agent.md` for code-only cleanup and `.github/agents/lv0-doc-writer.agent.md` for documentation-heavy work.
- Use `.github/agents/*.agent.md` for task-specific custom agents.
- Use `.github/instructions/*.instructions.md` for path-specific instructions that should attach automatically to matching files.
- Keep instruction files short, practical, and focused on stable rules rather than one-off tasks.

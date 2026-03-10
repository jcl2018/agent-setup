# Repo Map

## Purpose
Track the directories and files that are most useful when extending this home-agent mirror and resuming work quickly.

## Top-Level Areas
- Path: `.ai_shared/`
  Role: Canonical shared workflows, templates, checklists, knowledge notes, examples, and tasks for all three tools.
  Notes: This is the first place to look when shared behavior or shared repo context changes.
- Path: `.codex/`
  Role: Codex mirror with root instructions, config, reusable skills, and the `.agents-home/skills/` library copy.
  Notes: Keep `.agents-home/skills/` aligned with `skills/`.
- Path: `.claude/`
  Role: Claude mirror with root instructions, settings, and matching skills.
  Notes: Claude wrappers should point into `.ai_shared/` for shared assets.
- Path: `.github/`
  Role: Copilot instructions and custom agents plus path-specific instruction files.
  Notes: `instructions/` are path-specific rules; `agents/` are reusable task wrappers that should point into `.ai_shared/`.
- Path: `scripts/`
  Role: Non-destructive sync helpers between the repo and the home folder.
  Notes: `home-mirror.ps1` is the shared implementation used by both sync entry points.

## Entry Points
- Application entry: `scripts/sync-to-home.ps1`
- API entry: none
- Background worker entry: none

## Important Config Files
- `.ai_shared/knowledge/agent-stack.md`
- `.codex/config.toml`
- `.claude/settings.json`
- `.github/copilot-instructions.md`
- `AGENTS.md`

## Generated or Vendor Areas
- There are no tracked generated folders in the repo.
- Treat actual home runtime state outside the mirrored directories as unmanaged and out of scope for repo edits.

## Quick Start for Future Sessions
- Inspect `README.md`, `AGENTS.md`, `.ai_shared/knowledge/progress-tracker.md`, `.ai_shared/knowledge/future-plan.md`, `.ai_shared/knowledge/agent-stack.md`, and `scripts/home-mirror.ps1` first.

# Repo Map

## Purpose
Track the directories and files that are most useful when extending this home-agent mirror.

## Top-Level Areas
- Path: `.codex/`
  Role: Codex mirror with root instructions, workflows, templates, knowledge, checklists, and reusable skills.
  Notes: Keep `.agents-home/skills/` aligned with `skills/`.
- Path: `.claude/`
  Role: Claude mirror with matching workflows, templates, knowledge, checklists, and skills.
  Notes: Mirrors most shared content without the extra Codex library copy.
- Path: `.github/`
  Role: Copilot instructions and custom agents plus mirrored workflows, templates, and knowledge.
  Notes: `instructions/` are path-specific rules; `agents/` are reusable task wrappers.
- Path: `scripts/`
  Role: Non-destructive sync helpers between the repo and the home folder.
  Notes: `home-mirror.ps1` is the shared implementation used by both sync entry points.

## Entry Points
- Application entry: `scripts/sync-to-home.ps1`
- API entry: none
- Background worker entry: none

## Important Config Files
- `.codex/config.toml`
- `.claude/settings.json`
- `.github/copilot-instructions.md`
- `AGENTS.md`

## Generated or Vendor Areas
- There are no tracked generated folders in the repo.
- Treat actual home runtime state outside the mirrored directories as unmanaged and out of scope for repo edits.

## Quick Start for Future Sessions
- Inspect `README.md`, `AGENTS.md`, `.github/knowledge/agent-stack.md`, and `scripts/home-mirror.ps1` first.

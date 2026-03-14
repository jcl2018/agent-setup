# Repo Map

## Purpose
Track the directories and files that are most useful when extending this Codex workspace and resuming work quickly.

## Scope
- Treat `codex-agent/` as the workspace root for the paths below.
- The parent repo root is a multi-tool container with lightweight routing docs and room for future sibling tool folders.

## Top-Level Areas
- Path: `../`
  Role: Multi-tool container root for routing docs and future sibling tool workspaces.
  Notes: Use the parent `AGENTS.md` and `README.md` only to route into `codex-agent/` or future tool folders.
- Path: `.ai_shared/`
  Role: Canonical shared workflows, templates, checklists, knowledge notes, examples, and tasks for the managed Codex stack.
  Notes: This is the first place to look when shared behavior or shared repo context changes.
- Path: `.codex/`
  Role: Codex mirror with root instructions, config, reusable skills, and the `.agents-home/skills/` library copy.
  Notes: Keep `.agents-home/skills/` aligned with `skills/`.
- Path: `scripts/`
  Role: Non-destructive sync helpers between the repo and the home folder.
  Notes: `home-mirror.ps1` is the shared implementation used by both sync entry points.

## Entry Points
- Application entry: `scripts/sync-to-home.ps1`
- API entry: none
- Background worker entry: none

## Important Config Files
- `.ai_shared/knowledge/agent-stack.md`
- `.ai_shared/knowledge/home-audit-rules.md`
- `.codex/config.toml`
- `AGENTS.md`

## Generated or Vendor Areas
- There are no tracked generated folders in the repo.
- Treat actual home runtime state outside the mirrored directories as unmanaged and out of scope for repo edits.

## Quick Start for Future Sessions
- Inspect the parent `../README.md` and `../AGENTS.md` for container routing, then inspect `README.md`, `AGENTS.md`, `.ai_shared/knowledge/progress-tracker.md`, `.ai_shared/knowledge/future-plan.md`, `.ai_shared/knowledge/agent-stack.md`, `.ai_shared/knowledge/home-audit-rules.md`, and `scripts/home-mirror.ps1` inside this workspace.

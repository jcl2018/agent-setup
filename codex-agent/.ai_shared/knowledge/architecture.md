# Architecture Notes

## Purpose
Capture durable notes about the structure of this home-agent mirror repo.

## System Summary
- This workspace is a version-controlled mirror of a home-level AI agent setup for Codex.
- The parent repo root is now a multi-tool container, and `codex-agent/` is the current managed tool workspace.
- Shared assets now live in `.ai_shared/`, while the Codex root stays focused on wrappers, config, and skills.
- The shared layering model is foundation -> specialist -> task -> repo-specific wrapper.

## Major Components
- Component: container root (`../`)
  Responsibility: lightweight routing docs plus room for future sibling tool workspaces.
  Key files: `../AGENTS.md`, `../README.md`
- Component: `.ai_shared/`
  Responsibility: canonical shared workflows, templates, checklists, examples, tasks, and knowledge notes used by the Codex workspace.
  Key files: `knowledge/agent-stack.md`, `workflows/`, `templates/`
- Component: `.codex/`
  Responsibility: Codex home mirror with root instructions, tool-native skills, config, and a mirrored `.agents-home/skills/` library copy.
  Key files: `AGENTS.md`, `skills/`, `.agents-home/skills/`
- Component: `scripts/`
  Responsibility: Non-destructive sync helpers that copy managed files between the repo and home folders.
  Key files: `sync-to-home.ps1`, `sync-from-home.ps1`, `home-mirror.ps1`

## Key Data Flows
- Request path: edit shared assets in `.ai_shared/`, update the tool wrappers that reference them, then sync the managed subsets into the home directory.
- Background jobs: none in-repo; sync is manual and PowerShell-driven.
- External integrations: home directory mirrors and Codex config.

## Risky Areas
- Shared-to-Codex drift when a shared `.ai_shared/` change is not reflected in the generated Codex wrappers.
- The `.codex/.agents-home/skills/` copy must stay aligned with `.codex/skills/`.
- Sync script item lists and exclusions are the contract for what reaches the home folder.
- Machine-specific paths or runtime state do not belong in managed docs.

## Update Guidance
- Keep this file focused on stable structure, not task-specific notes.
- If you add another shared layer, document it in `knowledge/agent-stack.md` and wire it through the managed Codex roots in the same pass.
- If another tool gets added later, give it a sibling workspace folder instead of expanding the Codex-managed tree into the container root.

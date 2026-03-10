# Architecture Notes

## Purpose
Capture durable notes about the structure of this home-agent mirror repo.

## System Summary
- This repo is a version-controlled mirror of a home-level AI agent setup for Codex, Claude, and Copilot.
- Shared cross-tool assets now live in `.ai_shared/`, while each tool root stays focused on wrappers, config, skills, agents, and instructions.
- The shared layering model is foundation -> specialist -> task -> repo-specific wrapper.

## Major Components
- Component: `.ai_shared/`
  Responsibility: canonical shared workflows, templates, checklists, examples, tasks, and knowledge notes used by all three tools.
  Key files: `knowledge/agent-stack.md`, `workflows/`, `templates/`
- Component: `.codex/`
  Responsibility: Codex home mirror with root instructions, tool-native skills, config, and a mirrored `.agents-home/skills/` library copy.
  Key files: `AGENTS.md`, `skills/`, `.agents-home/skills/`
- Component: `.claude/`
  Responsibility: Claude home mirror with root instructions, settings, and tool-native skills.
  Key files: `CLAUDE.md`, `settings.json`, `skills/`
- Component: `.github/`
  Responsibility: Copilot root instructions, custom agents, and path-specific instruction files that wrap the same shared logic.
  Key files: `copilot-instructions.md`, `agents/`, `instructions/`
- Component: `scripts/`
  Responsibility: Non-destructive sync helpers that copy managed files between the repo and home folders.
  Key files: `sync-to-home.ps1`, `sync-from-home.ps1`, `home-mirror.ps1`

## Key Data Flows
- Request path: edit shared assets in `.ai_shared/`, update the tool wrappers that reference them, then sync the managed subsets into the home directory.
- Background jobs: none in-repo; sync is manual and PowerShell-driven.
- External integrations: home directory mirrors, Codex config, Claude settings, and Copilot custom agent support.

## Risky Areas
- Cross-tool drift when a shared `.ai_shared/` change is not reflected in the three tool wrappers.
- The `.codex/.agents-home/skills/` copy must stay aligned with `.codex/skills/`.
- Sync script item lists and exclusions are the contract for what reaches the home folder.
- Machine-specific paths or runtime state do not belong in managed docs.

## Update Guidance
- Keep this file focused on stable structure, not task-specific notes.
- If you add another shared layer, document it in `knowledge/agent-stack.md` and wire it through all three tool roots in the same pass.

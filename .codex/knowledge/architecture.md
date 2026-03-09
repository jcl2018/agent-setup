# Architecture Notes

## Purpose
Capture durable notes about the structure of this home-agent mirror repo.

## System Summary
- This repo is a version-controlled mirror of a home-level AI agent setup for Codex, Claude, and Copilot.
- Each tool root is self-sufficient, but the folder names, workflows, templates, and knowledge notes are intentionally aligned.
- The shared layering model is foundation -> specialist -> task -> repo-specific wrapper.

## Major Components
- Component: `.codex/`
  Responsibility: Codex home mirror with root instructions, shared skills, and a mirrored `.agents-home/skills/` library copy.
  Key files: `AGENTS.md`, `skills/`, `knowledge/agent-stack.md`
- Component: `.claude/`
  Responsibility: Claude home mirror with matching workflows, templates, knowledge, and skills.
  Key files: `CLAUDE.md`, `skills/`, `knowledge/agent-stack.md`
- Component: `.github/`
  Responsibility: Copilot root instructions, custom agents, and path-specific instruction files that mirror the same shared logic.
  Key files: `copilot-instructions.md`, `agents/`, `instructions/`, `knowledge/agent-stack.md`
- Component: `scripts/`
  Responsibility: Non-destructive sync helpers that copy managed files between the repo and home folders.
  Key files: `sync-to-home.ps1`, `sync-from-home.ps1`, `home-mirror.ps1`

## Key Data Flows
- Request path: edit files in the repo mirror, then sync the managed subsets into the home directory.
- Background jobs: none in-repo; sync is manual and PowerShell-driven.
- External integrations: home directory mirrors, Codex config, Claude settings, and Copilot custom agent support.

## Risky Areas
- Cross-tool drift when a shared change lands in only one tool root.
- The `.codex/.agents-home/skills/` copy must stay aligned with `.codex/skills/`.
- Sync script item lists are the contract for what reaches the home folder.
- Machine-specific paths or runtime state do not belong in managed docs.

## Update Guidance
- Keep this file focused on stable structure, not task-specific notes.
- If you add another shared layer, document it in `knowledge/agent-stack.md` and wire it through all three tool roots in the same pass.

# Multi-Tool Agent Container

## Purpose

This repo root is a lightweight container for tool-specific agent workspaces.

The active managed workspace today is `codex-agent/`. Future tool workspaces should live beside it as sibling folders instead of recreating top-level managed roots such as `.ai_shared/`, `.codex/`, or `.claude/`.

## Routing

- For Codex work, treat `codex-agent/` as the workspace root and follow `codex-agent/AGENTS.md`.
- Keep tool-specific wrappers, sync scripts, shared context, and continuity docs inside that tool's own folder.
- Keep the repo root light: routing docs, git metadata, and future sibling tool folders only.

## Current Layout

```text
.
|-- AGENTS.md
|-- README.md
|-- codex-agent/
`-- <future-tool-agent>/
```

## Important Rule

- Do not recreate the old top-level managed Codex or Claude trees at the repo root. Add new tool workspaces as dedicated folders such as `codex-agent/`, `claude-agent/`, or similar.

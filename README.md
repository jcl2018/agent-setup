# Agent Workspace Container

This repository root is now a container for tool-specific agent workspaces.

The active managed workspace is [codex-agent/](./codex-agent/). That folder holds the shared `.ai_shared/` layer, the Codex `.codex/` wrapper tree, the sync scripts, and the Codex-specific continuity docs. Future tools should be added as sibling folders rather than rebuilding top-level managed roots at the repo root.

## Layout

```text
.
|-- AGENTS.md
|-- README.md
|-- codex-agent/
|-- .gitattributes
`-- <future-tool-agent>/
```

## Working Rule

- Start Codex work in `codex-agent/`.
- Follow `codex-agent/AGENTS.md` for the Codex workflow and stack rules.
- Keep the repo root for container-level routing only.

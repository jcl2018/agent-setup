# Test Commands

## Purpose
Keep a short list of the commands most useful for validating changes in this mirror repo.

## Setup
- Run these commands from `codex-agent/`. If you are at the repo root, prefix the paths with `codex-agent/`.
- No build setup is required to edit the mirror itself.
- Use `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1 -WhatIf` to preview a home sync before copying files.

## Fast Checks
- `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1 -WhatIf`
- `powershell -ExecutionPolicy Bypass -File .\scripts\sync-from-home.ps1 -WhatIf`
- `git diff -- .ai_shared .codex scripts README.md AGENTS.md home_root_agent_structure_spec.md`

## Full Validation
- `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1`
- `powershell -ExecutionPolicy Bypass -File .\scripts\sync-from-home.ps1`

## Notes
- Sync commands are intentionally non-destructive copies; they do not delete unmanaged runtime state.
- `sync-from-home` depends on the relevant managed files already existing in the home directory.
- There is no compiled test suite in this repo, so validation is mostly structural and sync-oriented.

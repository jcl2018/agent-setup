# Test Commands

## Purpose
Keep a short list of the commands most useful for validating changes in this mirror repo.

## Setup
- No build setup is required to edit the mirror itself.
- Use `pwsh ./scripts/sync-to-home.ps1 -WhatIf` to preview a home sync before copying files.

## Fast Checks
- `pwsh ./scripts/sync-to-home.ps1 -WhatIf`
- `pwsh ./scripts/sync-from-home.ps1 -WhatIf`
- `git diff -- .ai_shared .codex .claude .github scripts README.md`

## Full Validation
- `pwsh ./scripts/sync-to-home.ps1`
- `pwsh ./scripts/sync-from-home.ps1`

## Notes
- Sync commands are intentionally non-destructive copies; they do not delete unmanaged runtime state.
- `sync-from-home` depends on the relevant managed files already existing in the home directory.
- There is no compiled test suite in this repo, so validation is mostly structural and sync-oriented.

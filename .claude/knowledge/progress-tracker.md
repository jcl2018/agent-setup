# Progress Tracker

## Purpose
Capture completed or meaningful in-progress work so future sessions can resume without rebuilding context from scratch.

## Update Rules
- Add the newest entry at the top of `## Entries`.
- Record the goal, the main changes or findings, validation, and any useful resume cues.
- Keep unfinished work out of this file; move it into `future-plan.md`.
- Mirror the same substantive update across tool roots when the repo maintains more than one.

## Entries

### 2026-03-09
- Goal: standardize repo continuity docs so every shared skill stack maintains a progress tracker and a future plan by default.
- Changed: updated the shared `lv0` core, repo-onboarding guidance, workflows, and top-level instructions across `.codex`, `.claude`, and `.github`; added the two continuity docs to each tool root.
- Validation: `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1 -WhatIf`, a `Select-String` scan for `progress-tracker` and `future-plan` across `.codex`, `.claude`, and `.github`, and a live `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1` sync all completed successfully.
- Resume cues: if the tracker pattern feels too manual later, add a thin helper or template instead of another workflow layer.

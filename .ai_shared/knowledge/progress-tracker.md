# Progress Tracker

## Purpose
Capture completed or meaningful in-progress work so future sessions can resume without rebuilding context from scratch.

## Update Rules
- Add the newest entry at the top of `## Entries`.
- Record the goal, the main changes or findings, validation, and any useful resume cues.
- Keep unfinished work out of this file; move it into `future-plan.md`.
- Keep one shared tracker in `.ai_shared/knowledge/` for this repo instead of mirroring the same note across multiple tool-root knowledge folders.

## Entries

### 2026-03-10
- Goal: make shared `lv0` and `lv1` skill edits fan out to Codex, Claude, and Copilot from one canonical source.
- Changed: added `.ai_shared/skills/` as the canonical shared-skill layer; introduced `catalog.json` plus shared `shared.md` definitions for the active cross-tool skills; added `scripts/sync-shared-skills.ps1` to regenerate Codex skills, Codex `.agents-home` mirrors, Claude skills, and Copilot agents from the shared source; updated the normal sync scripts to run the generator automatically; moved the GitHub-readiness shared audit assets into `.ai_shared/skills/lv1-github-repo-readiness/` so the generated wrappers keep their checklist and PowerShell audit helper.
- Validation: ran `powershell -ExecutionPolicy Bypass -File .\scripts\sync-shared-skills.ps1`, ran `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1`, and verified the generated GitHub-readiness audit script exists under `.codex/skills/`, `.codex/.agents-home/skills/`, and `.claude/skills/`.
- Resume cues: shared behavior edits should now happen in `.ai_shared/skills/<name>/shared.md`; regenerate wrappers with `scripts/sync-shared-skills.ps1` or the normal sync scripts instead of hand-editing all three tool wrappers.

### 2026-03-09
- Goal: refactor the home agent system around a shared `.ai_shared` layer and thin per-tool wrappers.
- Changed: created the canonical `.ai_shared/` tree for shared workflows, templates, checklists, knowledge, examples, and tasks; rewrote the Codex, Claude, and Copilot root instructions plus the related `lv0` and `lv1` wrappers to read shared context from `.ai_shared`; updated `README.md`, `home_root_agent_structure_spec.md`, and `scripts/home-mirror.ps1` to sync `.ai_shared` plus thin wrapper roots; removed the duplicated shared folders from `.codex/`, `.claude/`, and `.github/`; synced the new layout into `C:\Users\chang`; and removed the legacy shared home folders from `C:\Users\chang\.codex`, `C:\Users\chang\.claude`, and `C:\Users\chang\.github`.
- Validation: compared the shared file sets before deleting the duplicate repo folders, rescanned the repo for stale references to the old tool-root shared folders, ran `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1 -WhatIf`, ran `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1`, and verified that `C:\Users\chang\.ai_shared` now exists while the old home `checklists`, `templates`, `workflows`, `knowledge`, `examples`, and `tasks` folders are gone from the three tool roots.
- Resume cues: the machine now uses `.ai_shared` as the shared layer and keeps `.codex`, `.claude`, and `.github` thin; if you want future migrations to be one-command, add a dedicated prune or migration helper instead of relying on manual cleanup.

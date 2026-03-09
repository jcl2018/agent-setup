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
- Goal: promote the shared Figma design and GitHub readiness capabilities into reusable `lv1` skills that multiple repos can call safely.
- Changed: added `lv1-figma-implement-design` and `lv1-github-repo-readiness` under `.codex/skills/` and `.codex/.agents-home/skills/`, added the reusable GitHub checklist and audit script, broadened the GitHub readiness guidance so it supports both private and public repos, and updated the shared stack and discovery docs across `.codex`, `.claude`, `.github`, and the root `AGENTS.md`.
- Validation: `powershell -ExecutionPolicy Bypass -File .\\scripts\\sync-to-home.ps1 -WhatIf`, SHA256 mirror comparison between `.codex/skills/lv1-*` and `.codex/.agents-home/skills/lv1-*`, `powershell -ExecutionPolicy Bypass -Command "& '.\\.codex\\skills\\lv1-github-repo-readiness\\scripts\\audit-repo.ps1' -RepoPath '.' -Visibility either"`, and a `Select-String` scan that found no managed-surface references to the legacy exact names ``github-open-source-readiness`` or ``figma-implement-design``.
- Resume cues: the repo mirror, the git-backed home mirror, and the live home folders now all expose the new `lv1` skills; use `lv1-figma-implement-design` directly for shared design-to-code work and `lv1-github-repo-readiness` for private or public GitHub audits.

### 2026-03-09
- Goal: standardize repo continuity docs so every shared skill stack maintains a progress tracker and a future plan by default.
- Changed: updated the shared `lv0` core, repo-onboarding guidance, workflows, and top-level instructions across `.codex`, `.claude`, and `.github`; added the two continuity docs to each tool root.
- Validation: `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1 -WhatIf`, a `Select-String` scan for `progress-tracker` and `future-plan` across `.codex`, `.claude`, and `.github`, and a live `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1` sync all completed successfully.
- Resume cues: if the tracker pattern feels too manual later, add a thin helper or template instead of another workflow layer.

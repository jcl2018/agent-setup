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
- Goal: retire the shared Figma design skill from the local repo mirrors because this machine cannot use the Figma integration path.
- Changed: removed the active `lv1-figma-implement-design` skill files from `.codex/skills/` and `.codex/.agents-home/skills/`, added lightweight archive markers under both `_removed-skills/` folders, updated the shared router docs so Codex no longer advertises the Figma capability alongside the aligned root, Claude, and Copilot surfaces, synced the updated Codex files into `C:\Users\chang\.codex`, and deleted the retired live home skill folders there.
- Validation: confirmed the active repo and live-home Codex skill paths are absent, confirmed the archive-marker paths exist in the repo mirror, reran focused discovery-doc scans in both locations with no active Figma references, and ran `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1 -Tool codex`.
- Resume cues: if Figma access is restored later, recover the retired skill from git history or a previous shared snapshot instead of rebuilding it manually.

### 2026-03-09
- Goal: ensure the latest shared Figma/GitHub skill and feature-dev PRD workflow commits are fully applied on the local home machine.
- Changed: confirmed the repo mirror is current with `origin/main` at `8c4e172`, verified the live home copies for every path touched by commits `0d7b736` and `8c4e172`, found that `C:\Users\chang\AGENTS.md` was the only missing target because `scripts/home-mirror.ps1` did not sync root-level managed files, and updated the mirror script so `AGENTS.md` now syncs in both directions.
- Validation: `git -C E:\Dropbox\project\agent-setup fetch origin --prune`, a file-hash comparison of every path touched by `0d7b736` and `8c4e172` against `C:\Users\chang`, `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1`, and a post-sync compare confirming the targeted home files now match the repo, including `C:\Users\chang\AGENTS.md`.
- Resume cues: if another shared home-root file needs to travel between the repo mirror and the live machine, add it to the root item list in `scripts/home-mirror.ps1` instead of copying it manually.

### 2026-03-09
- Goal: teach the shared `lv1-feature-dev` flow to capture lightweight PRDs when feature work surfaces requirements, APIs, or use cases.
- Changed: updated the feature-dev skill, feature workflow, feature-validation checklist, top-level routing docs, and agent-stack notes across `.codex`, `.claude`, and `.github`; added a reusable `prd-template.md` to each tool root; updated the Codex picker prompt and home-library mirror so feature work can create or update PRDs alongside implementation.
- Validation: `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1 -WhatIf`, `Get-FileHash .codex\skills\lv1-feature-dev\SKILL.md, .codex\.agents-home\skills\lv1-feature-dev\SKILL.md, .codex\skills\lv1-feature-dev\agents\openai.yaml, .codex\.agents-home\skills\lv1-feature-dev\agents\openai.yaml | Format-Table -AutoSize`, `Get-ChildItem AGENTS.md, .codex, .claude, .github -Recurse -File | Select-String -Pattern 'prd-template|PRD' | Select-Object Path, LineNumber, Line | Format-Table -AutoSize`, and `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1`.
- Resume cues: feature work should now prefer an existing PRD or docs location when one exists and fall back to `docs/prd/<feature-name>.md` with the shared template when requirements need to be recorded.

### 2026-03-09
- Goal: reconcile the Dropbox repo's local `main` with `origin/main` after fixing the object-store permission issue.
- Changed: confirmed the local commit `5c8b9d8` and remote commit `ee38fb1` had the same parent and tree, created backup branch `codex/main-before-reconcile` at the local-only commit, and moved `main` to `ee38fb1` so the working branch matches `origin/main` again without disturbing the uncommitted tracker updates.
- Validation: `git -C E:\Dropbox\project\agent-setup diff --stat 5c8b9d8 ee38fb1`, `git -C E:\Dropbox\project\agent-setup cherry -v origin/main main`, `git -C E:\Dropbox\project\agent-setup update-ref refs/heads/main ee38fb1 5c8b9d8`, and `git -C E:\Dropbox\project\agent-setup status -sb`.
- Resume cues: `main` is aligned with `origin/main`; if the older local commit is ever needed, it is preserved on `codex/main-before-reconcile`.

### 2026-03-09
- Goal: restore reliable git operations in the Dropbox-managed `agent-setup` repo after `.git/objects` writes started failing with permission errors.
- Changed: traced the failures to Dropbox cloud-file reparse points under `.git`, copied `.git/objects` to `C:\Users\chang\.git-object-stores\agent-setup-objects`, renamed the original folder to `E:\Dropbox\project\agent-setup\.git\objects.dropbox-backup-20260309`, and replaced `.git/objects` with a junction to the external store so git object writes bypass Dropbox virtualization.
- Validation: `git -C E:\Dropbox\project\agent-setup add AGENTS.md .codex .claude .github`, `git -C E:\Dropbox\project\agent-setup fetch origin`, `git -C E:\Dropbox\project\agent-setup fetch C:\Users\chang\tmp\agent-setup refs/heads/codex-fetch-test:refs/remotes/codex-fetch-test`, and `git -C E:\Dropbox\project\agent-setup status -sb`.
- Resume cues: git object reads and writes now go through the external store, but the local `main` branch is still diverged from `origin/main` (`5c8b9d8` locally versus `ee38fb1` on origin), which is a separate history-reconciliation task.

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

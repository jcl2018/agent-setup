---
name: lv1-github-repo-readiness
description: Audit or improve a repository for private or public GitHub use. Use when preparing a repo for internal sharing, public release, contributor onboarding, or publication cleanup across multiple repos.
---
<!-- Generated from .ai_shared/skills/lv1-github-repo-readiness/shared.md. Edit the shared source and run scripts/sync-shared-skills.ps1. -->

# Lv1 GitHub Repo Readiness

## Overview

Use this shared `lv1` skill when a repository needs GitHub-facing cleanup, private handoff hardening, or public-release preparation.

This capability supports both private and public repos:
- private or team-only repos still need clean setup, CI, docs, and safe data handling
- public repos additionally need license, community, and disclosure decisions before release
- thin `lv2-*` wrappers can layer repo-specific risk rules on top of this shared audit

## Workflow

1. Read `~/.claude/skills/lv0-instruction-core/SKILL.md`.
2. Read `~/.ai_shared/workflows/workflow-code-review.md` for the audit-first pass.
3. Read the most relevant repo-local context from `.ai_shared/knowledge/`, especially `repo-map.md`, `test-commands.md`, `progress-tracker.md`, and `future-plan.md`. Use `~/.ai_shared/knowledge/` for shared cross-repo guidance when the repo has no local override.
4. Inspect the repo surface:
   - `git status --short --branch`
   - `git ls-files`
   - top-level manifests such as `package.json`, `pyproject.toml`, or `Cargo.toml`
   - `README.md`, `.gitignore`, `.github/`, sample data, and any local-only artifacts
5. Decide the collaboration target early:
   - `private` for internal or limited sharing
   - `public` for open release
   - `either` when the repo should stay safe for both paths
6. Run `scripts/audit-repo.ps1 -RepoPath <path> -Visibility <private|public|either>` from this skill when PowerShell is available. If PowerShell is unavailable, mirror the same checks manually.
7. Separate findings into:
   - blockers for any GitHub sharing
   - public-only blockers or disclosure decisions
   - important improvements
   - nice-to-have polish
8. Recommend or implement only low-risk edits without extra approval. Good candidates are README cleanup, `.gitignore`, CI wiring, sample-data guidance, issue templates, PR templates, `CONTRIBUTING.md`, or `SECURITY.md`.
9. Pause before user-specific decisions. Ask before choosing a real `LICENSE`, publishing anything that may contain private data, deleting user artifacts from history, or making governance promises.
10. Validate the result:
   - use the shared code-review workflow when the work is findings-first
   - use the shared feature workflow and its checklists if you implement fixes in the same pass
11. Update `.ai_shared/knowledge/progress-tracker.md` and `.ai_shared/knowledge/future-plan.md` for repo-local continuity when the shared workflow changes or follow-up repo work remains.

## Output Shape

- findings first, ordered by severity
- explicit note of the visibility target: private, public, or either
- files reviewed or changed
- validation status
- next 3 moves

## Stop Conditions

Stop when publishing would expose private or regulated data, when the repo visibility target is unclear and the choice changes the recommendation materially, or when a licensing or disclosure decision belongs to the user rather than the agent.

---
name: lv0-home-auditor
description: Lv0 logistics and audit layer for home-folder setup plus the shared local-repo audit baseline. Use it for local config drift, wrapper sync, repo-specific weekly checks, tracked-artifact risk, and cleanup candidates when the global or repo-local audit gate is missing or the home setup may be out of alignment.
---
<!-- Generated from .ai_shared/skills/lv0-home-auditor/shared.md. Edit the shared source and run scripts/sync-shared-skills.ps1. -->

# Lv0 Home Auditor

## Overview

Use this skill as the weekly `lv0` auditor for home-folder updates. As an `lv0` skill, it handles basic logistics, standards, audit, and automation work rather than task-specific product workflows. It owns both the global home-level weekly audit and the per-repo weekly audit gate, and it also owns the shared local-repo audit baseline for generic repo hygiene, tracked-artifact risk, local-only tracking-file and tool runtime-state guardrails, and repo-managed drift. On the first repo request handled anywhere during a new calendar week, or the first conversation in a specific repo during that week, verify that the shared local config, folder structure, tool wrappers, and any repo-specific audit rules are still aligned before deeper work continues.

## Workflow

1. Read `~/.codex/skills/lv0-instruction-core/SKILL.md`.
2. Read repo-local `.ai_shared/workflows/workflow-home-audit.md` when the repo defines one; otherwise use `~/.ai_shared/workflows/workflow-home-audit.md`.
3. Read `~/.ai_shared/knowledge/progress-tracker.md` and determine whether the global `lv0-home-auditor` pass already ran during the current calendar week.
4. If you are working in a repo, read `.ai_shared/knowledge/progress-tracker.md` and determine whether that repo already logged a repo-specific `lv0-home-auditor` pass during the current calendar week. If both the global and repo-local gates are already satisfied and the user did not ask for a fresh audit, summarize the latest relevant results and skip the heavy audit.
5. Validate against repo-local `.ai_shared/checklists/home-audit-checklist.md` when the repo defines one; otherwise use the shared `~/.ai_shared/checklists/home-audit-checklist.md`.
6. Read repo-local audit guidance when present, especially `.ai_shared/knowledge/remote-sharing-rules.md`, `.ai_shared/knowledge/home-audit-rules.md`, `architecture.md`, `repo-map.md`, `progress-tracker.md`, and `future-plan.md`, then apply any repo-specific weekly audit rules in addition to the shared baseline checks.
7. When the audit scope includes a repo, read `references/local-repo-checklist.md` from this skill and run `scripts/audit-repo.ps1 -RepoPath <path>` from this skill when PowerShell is available. If PowerShell is unavailable, mirror the same checks manually so generic repo-hygiene findings such as tracked local tracking files, tool runtime/session files, or user-specific absolute filesystem paths do not stay buried inside a GitHub-specific workflow.
8. Verify that shared files and folders are positioned correctly: shared knowledge, templates, workflows, checklists, examples, and tasks live under `.ai_shared/`, canonical shared skill definitions live under `.ai_shared/skills/`, and tool-specific wrappers stay under `.codex/` or `.claude/`.
9. Check that the shared logic is still in sync across the canonical `.ai_shared/skills/` layer, the generated tool wrappers, and the top-level tool entrypoint docs. Flag stale references, conflict-copy files, and wrapper drift.
10. Confirm that the shared folders needed by Codex and Claude are accessible on the current machine: `~/.ai_shared/`, `~/.codex/`, and `~/.claude/`.
11. Review the home directories for outdated or dead folders, retired skill directories, stale continuity files, or other cleanup candidates. Recommend cleanup work clearly, but do not delete anything unless the user explicitly asks.
12. For repo-local work, also check the triggering repo's rules, continuity docs, override folders, repo-managed-versus-live-home discrepancies, and generic local-repo audit findings such as tracked artifacts, tracked local tracking files or tool runtime/session files that should stay off remotes, user-specific absolute filesystem paths in tracked shareable files, secret-like literals, missing repo basics, and large committed files.
13. Record the audit date, drift summary, cleanup candidates, and follow-ups in `~/.ai_shared/knowledge/progress-tracker.md`, and move unfinished home-level cleanup work into `~/.ai_shared/knowledge/future-plan.md`.
14. When a repo-specific weekly audit ran or repo-specific discrepancies were found, record that result in `.ai_shared/knowledge/progress-tracker.md` and move unfinished repo-local follow-up work into `.ai_shared/knowledge/future-plan.md`.

## Output Shape

- global weekly gate result
- repo weekly gate result
- alignment or drift findings
- repo-local audit findings
- repo-specific audit rules applied
- cleanup candidates
- repo-specific rule status
- validation status

## Stop Conditions

Stop when the repo or home roots cannot be inspected, the weekly audit state cannot be determined safely, or cleanup would require destructive changes that the user has not approved.

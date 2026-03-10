---
name: lv0-home-auditor
description: Audit the home-folder setup for local config drift, folder placement, wrapper sync, repo-specific weekly checks, and cleanup candidates. Use on the first repo request of each week or whenever the local home setup may be out of alignment.
---
<!-- Generated from .ai_shared/skills/lv0-home-auditor/shared.md. Edit the shared source and run scripts/sync-shared-skills.ps1. -->

# Lv0 Home Auditor

## Overview

Use this skill as the weekly `lv0` auditor for home-folder updates. On the first request in a repo during a new calendar week, verify that the shared local config, folder structure, tool wrappers, and repo-specific rules are still aligned before deeper work continues.

## Workflow

1. Read `~/.claude/skills/lv0-instruction-core/SKILL.md`.
2. Read `~/.ai_shared/workflows/workflow-home-audit.md`.
3. Read `.ai_shared/knowledge/progress-tracker.md` and determine whether `lv0-home-auditor` already ran for the current repo during the current calendar week. If it already ran and the user did not ask for a fresh audit, summarize the latest result and skip the heavy audit.
4. Verify that shared files and folders are positioned correctly: shared knowledge, templates, workflows, checklists, examples, and tasks live under `.ai_shared/`, canonical shared skill definitions live under `.ai_shared/skills/`, and tool-specific wrappers stay under `.codex/`, `.claude/`, or `.github/`.
5. Check that the shared logic is still in sync across the canonical `.ai_shared/skills/` layer, the generated tool wrappers, and the top-level tool entrypoint docs. Flag stale references, conflict-copy files, and wrapper drift.
6. Confirm that the shared folders needed by Codex and Copilot are accessible on the current machine, and verify the parallel Claude paths when they exist: `~/.ai_shared/`, `~/.codex/`, `~/.github/`, and `~/.claude/`.
7. Review the home directories for outdated or dead folders, retired skill directories, stale continuity files, or other cleanup candidates. Recommend cleanup work clearly, but do not delete anything unless the user explicitly asks.
8. For repo-local work, also check the repo-specific rules, continuity docs, and override folders the first time the audit runs in that repo for the week.
9. Validate against repo-local `.ai_shared/checklists/home-audit-checklist.md` when the repo defines one; otherwise use the shared `~/.ai_shared/checklists/home-audit-checklist.md`.
10. Record the audit date, drift summary, cleanup candidates, and follow-ups in `.ai_shared/knowledge/progress-tracker.md`, and move unfinished cleanup work into `.ai_shared/knowledge/future-plan.md`.

## Output Shape

- weekly gate result
- alignment or drift findings
- cleanup candidates
- repo-specific rule status
- validation status

## Stop Conditions

Stop when the repo or home roots cannot be inspected, the weekly audit state cannot be determined safely, or cleanup would require destructive changes that the user has not approved.

# Workflow: Home Audit

## Purpose
Verify that the shared home-root AI setup and the current repo's local shared folders remain aligned before deeper work continues.

## Trigger
Use this workflow when:
- the user asks for a home setup, folder, or config audit
- the first request in a repo arrives during a new calendar week and `.ai_shared/knowledge/progress-tracker.md` does not already show a current-week `lv0-home-auditor` entry for that repo
- there are signs of wrapper drift, stale folders, or broken shared-path access

## Inputs
- repository root and current tool wrapper root
- current date and the repo's `.ai_shared/knowledge/progress-tracker.md`
- home roots such as `~/.ai_shared/`, `~/.codex/`, and `~/.claude/` when present
- active shared workflow, checklist, and skill definitions relevant to the audit

## Steps
1. Check whether the current repo already logged an `lv0-home-auditor` run during the current calendar week.
2. Inspect the repo-local shared and tool-specific folders to confirm canonical file placement and override boundaries.
3. Compare the canonical shared logic with the generated tool wrappers and top-level entrypoint docs to find drift or stale references.
4. Verify that the shared home folders and tool roots needed by Codex and Claude are present and accessible.
5. Identify outdated, dead, retired, conflicted, or misplaced files and folders, then separate cleanup candidates from immediate blockers.
6. Check repo-specific rules, continuity docs, and local overrides the first time the audit runs in that repo for the week.
7. Update `.ai_shared/knowledge/progress-tracker.md` with the audit result and move unfinished cleanup work into `future-plan.md`.

## Output
The final response should include:
- whether the weekly gate caused the audit to run or skip
- the main alignment findings or drift
- cleanup candidates that should be reviewed
- repo-specific rule status
- validation that was run or skipped

## Stop Conditions
Stop and report blockers when the repo or home folders are inaccessible, the current-week audit state cannot be determined safely, or cleanup would require destructive changes without explicit user approval.

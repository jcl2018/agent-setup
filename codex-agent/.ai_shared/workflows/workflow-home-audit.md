# Workflow: Home Audit

## Purpose
Verify that the shared home-root AI setup and the triggering repo's local shared folders remain aligned before deeper work continues, including any repo-specific weekly audit rules and the shared local-repo audit baseline.

## Trigger
Use this workflow when:
- the user asks for a home setup, folder, or config audit
- the first repo request of a new calendar week arrives and `~/.ai_shared/knowledge/progress-tracker.md` does not already show a current-week `lv0-home-auditor` entry
- the first conversation in a specific repo during a new calendar week arrives and `.ai_shared/knowledge/progress-tracker.md` does not already show a current-week repo-specific `lv0-home-auditor` entry
- there are signs of wrapper drift, stale folders, or broken shared-path access

## Inputs
- repository root and current tool wrapper root
- current date, `~/.ai_shared/knowledge/progress-tracker.md`, and the current repo's `.ai_shared/knowledge/progress-tracker.md` when present
- home roots such as `~/.ai_shared/` and `~/.codex/` when present
- active shared workflow, checklist, and skill definitions relevant to the audit
- repo-local audit guidance such as `.ai_shared/checklists/home-audit-checklist.md`, `.ai_shared/knowledge/remote-sharing-rules.md`, `.ai_shared/knowledge/home-audit-rules.md`, `architecture.md`, `repo-map.md`, and `future-plan.md` when present
- the shared local-repo audit checklist and script under `lv0-home-auditor`

## Steps
1. Check whether `~/.ai_shared/knowledge/progress-tracker.md` already logged a global `lv0-home-auditor` run during the current calendar week.
2. If the task is in a repo, check whether `.ai_shared/knowledge/progress-tracker.md` already logged a repo-specific `lv0-home-auditor` run during the current calendar week.
3. Load the repo-local home-audit workflow and checklist when the repo defines them, and read repo-local audit notes such as `.ai_shared/knowledge/remote-sharing-rules.md`, `.ai_shared/knowledge/home-audit-rules.md`, `architecture.md`, `repo-map.md`, `progress-tracker.md`, and `future-plan.md` when they affect the audit scope.
4. Inspect the repo-local shared and tool-specific folders to confirm canonical file placement and override boundaries.
5. When the audit scope includes a repo, read the `lv0-home-auditor` local-repo checklist and run its `scripts/audit-repo.ps1 -RepoPath <path>` helper when PowerShell is available; otherwise mirror the same generic repo-hygiene checks manually, including tracked local tracking files, tool runtime/session files, and user-specific absolute filesystem paths in tracked shareable files.
6. Compare the canonical shared logic with the generated tool wrappers and top-level entrypoint docs to find drift or stale references.
7. Verify that the shared home folders and tool roots needed by Codex are present and accessible.
8. Apply any repo-specific audit rules in addition to the shared baseline checks, including managed repo-to-home discrepancy checks when the repo defines mirror behavior and any local-only rules for tracking files, tool runtime/session files, or path-hygiene exceptions.
9. When the audit results are being reported, run `lv0-home-auditor/scripts/checkup-home-state.ps1 -RepoRoot <path> -HomeRoot <path>` so the printed output includes a `Checkup` stage listing the current machine's managed skills, rules, and agent surfaces plus any discrepancies.
10. Identify outdated, dead, retired, conflicted, or misplaced files and folders, then separate cleanup candidates from immediate blockers.
11. Update `~/.ai_shared/knowledge/progress-tracker.md` with the home-level audit result and move unfinished home-level cleanup work into `~/.ai_shared/knowledge/future-plan.md`.
12. When the repo-specific weekly gate ran or repo-specific findings were produced, update `.ai_shared/knowledge/progress-tracker.md` with that repo audit result and move unfinished repo-specific follow-up work into `.ai_shared/knowledge/future-plan.md`.

## Output
The final response should include:
- whether the global weekly gate caused the audit to run or skip
- whether the repo-specific weekly gate caused the audit to run or skip
- the `Checkup` stage with the current machine's managed skills, rules, agents, and discrepancies
- the main alignment findings or drift
- the repo-local audit findings that affected the result
- which repo-specific audit rules were applied
- cleanup candidates that should be reviewed
- the triggering repo's rule status
- validation that was run or skipped

## Stop Conditions
Stop and report blockers when the repo or home folders are inaccessible, the current-week audit state cannot be determined safely, or cleanup would require destructive changes without explicit user approval.

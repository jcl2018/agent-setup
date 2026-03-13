# {{DISPLAY_NAME}}

## Overview

Use this shared `lv1` {{WRAPPER_NOUN}} when a repository needs GitHub-facing cleanup, private handoff hardening, or public-release preparation after the generic local-repo audit baseline is already in place.

This capability supports both private and public repos:
- `lv0-home-auditor` owns the generic repo-hygiene audit, tracked-artifact checks, and repo-managed drift checks
- this `lv1` skill focuses on visibility targets, GitHub collaboration surfaces, community docs, CI, and publication decisions
- thin `lv2-*` wrappers can layer repo-specific release rules on top of this GitHub-facing pass

## Workflow

1. Read `{{ENTRY_REF}}`.
2. Read `~/.ai_shared/workflows/workflow-code-review.md` for the audit-first pass.
3. Read the most relevant repo-local context from `.ai_shared/knowledge/`, especially `repo-map.md`, `test-commands.md`, `progress-tracker.md`, and `future-plan.md`. Use `~/.ai_shared/knowledge/` for shared cross-repo guidance when the repo has no local override.
4. Read the latest relevant `lv0-home-auditor` findings from `.ai_shared/knowledge/progress-tracker.md`. If the repo-local audit baseline is stale or missing for the current week and the GitHub recommendation depends on it, run `lv0-home-auditor` first.
5. Decide the collaboration target early:
   - `private` for internal or limited sharing
   - `public` for open release
   - `either` when the repo should stay safe for both paths
6. Read `references/oss-checklist.md` from this {{WRAPPER_NOUN}} for the GitHub-facing review rubric, and read repo-local `.ai_shared/knowledge/remote-sharing-rules.md` when the repo defines it; otherwise use `~/.ai_shared/knowledge/remote-sharing-rules.md`.
7. Inspect the GitHub/publication surface:
   - `LICENSE`, `CONTRIBUTING.md`, `SECURITY.md`, and `CODE_OF_CONDUCT.md`
   - `.github/workflows`, issue templates, and pull request templates
   - package metadata such as repository URLs, homepage URLs, and issue tracker URLs
   - README messaging, disclosure decisions, and other GitHub landing-page concerns
   - tracked local-only tracking files and tool runtime/session files such as `progress-tracker.md`, `future-plan.md`, and tool session/runtime state that should stay off remotes
   - user-specific absolute filesystem paths in tracked shareable content that should be replaced with repo-relative or `~`-relative forms
8. Run `scripts/audit-github-readiness.ps1 -RepoPath <path> -Visibility <private|public|either>` from this {{WRAPPER_NOUN}} when PowerShell is available. If PowerShell is unavailable, mirror the same GitHub-facing checks manually.
9. Separate findings into:
   - blockers for any GitHub sharing
   - public-only blockers or disclosure decisions
   - important improvements
   - nice-to-have polish
10. Recommend or implement only low-risk edits without extra approval. Good candidates are CI wiring, issue templates, PR templates, README landing-page cleanup, `CONTRIBUTING.md`, `SECURITY.md`, or other GitHub-facing docs.
11. Follow the shared remote-sharing rules before recommending any push. Treat repo tracking files and tool runtime/session files as local records rather than remote deliverables, and treat user-specific absolute filesystem paths in tracked shareable content as a remote-sharing blocker until they are replaced with repo-relative or `~`-relative forms. Normal repo knowledge notes, templates, workflows, and checklists remain shareable repo content unless a repo-specific rule says otherwise.
12. Pause before user-specific decisions. Ask before choosing a real `LICENSE`, publishing anything that may contain private data, deleting user artifacts from history, or making governance promises.
13. Validate the result:
   - use the shared code-review workflow when the work is findings-first
   - use the shared feature workflow and its checklists if you implement fixes in the same pass
14. Update `.ai_shared/knowledge/progress-tracker.md` and `.ai_shared/knowledge/future-plan.md` for repo-local continuity when the shared workflow changes or follow-up repo work remains.

## Output Shape

- findings first, ordered by severity
- explicit note of the visibility target: private, public, or either
- files reviewed or changed
- validation status
- next 3 moves

## Stop Conditions

Stop when publishing would expose private or regulated data, when the repo visibility target is unclear and the choice changes the recommendation materially, or when a licensing or disclosure decision belongs to the user rather than the agent.

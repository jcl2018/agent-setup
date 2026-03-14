# Home Audit Rules

## Purpose
Capture repo-specific weekly audit expectations that extend the shared `lv0-home-auditor` baseline.

## Repo-Specific Rules
- This repo is the canonical mirror for the home-root Codex setup. During repo-specific weekly audits, compare the managed repo surfaces against the live home paths under `~/.ai_shared`, `~/.codex`, and `~/AGENTS.md`.
- Important rule: this repo is Codex-only. Treat any reintroduced tracked `.claude/` wrapper content or Claude-specific managed routing docs as drift that should be removed rather than updated.
- Treat any mismatch between a repo-managed path and its live home counterpart as drift unless the difference is explicitly excluded by `scripts/home-mirror.ps1` or documented as unmanaged runtime state.
- Use `scripts/home-mirror.ps1` as the contract for what counts as managed mirror scope, including its exclusions for repo-local continuity docs and runtime-only directories.
- When printing repo-specific weekly audit results, include a `Checkup` stage that inventories the current machine's managed skills, rule files, and agent entry surfaces against the repo-managed copy so discrepancies are easy to review. Treat Codex `.system` as an expected tool-native extra unless the managed mirror contract changes.
- Record both missing managed files and unexpected content drift in the repo-local audit result so the next session can tell whether the mirror and the live home install still converge.
- Treat repo tracking files and tool runtime/session files as local records rather than remote-sharing artifacts. Weekly audits should flag tracked `progress-tracker.md`, `future-plan.md`, and tool session/runtime files before recommending any remote push or GitHub sharing. Normal repo knowledge notes, templates, workflows, and checklists remain ordinary shareable repo content unless a repo-specific rule says otherwise.
- Apply `.ai_shared/knowledge/remote-sharing-rules.md` as the shared path-hygiene policy. This repo has no repo-specific exception to the rule that tracked shareable content should avoid user-specific absolute filesystem paths.

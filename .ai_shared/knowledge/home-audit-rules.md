# Home Audit Rules

## Purpose
Capture repo-specific weekly audit expectations that extend the shared `lv0-home-auditor` baseline.

## Repo-Specific Rules
- This repo is the canonical mirror for the home-root agent setup. During repo-specific weekly audits, compare the managed repo surfaces against the live home paths under `~/.ai_shared`, `~/.codex`, `~/.claude`, and `~/AGENTS.md`.
- Treat any mismatch between a repo-managed path and its live home counterpart as drift unless the difference is explicitly excluded by `scripts/home-mirror.ps1` or documented as unmanaged runtime state.
- Use `scripts/home-mirror.ps1` as the contract for what counts as managed mirror scope, including its exclusions for repo-local continuity docs and runtime-only directories.
- Record both missing managed files and unexpected content drift in the repo-local audit result so the next session can tell whether the mirror and the live home install still converge.

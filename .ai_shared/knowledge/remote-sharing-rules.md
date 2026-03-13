# Remote Sharing Rules

## Purpose
Keep one shared source of truth for what is safe to commit and push to a GitHub remote without leaking machine-specific local state.

## Rules

### Local-Only Files
- Keep repo tracking files local: `.ai_shared/knowledge/progress-tracker.md` and `.ai_shared/knowledge/future-plan.md`.
- Keep tool runtime and session state local: files such as `.codex/auth.json`, `.codex/sessions/`, `.codex/sqlite/`, `.codex/tmp/`, `.claude/projects/`, and similar runtime-only surfaces.
- These local-only files may contain machine-specific details because they are not meant to be pushed.

### Path Hygiene For Shareable Repo Content
- For files that live inside the repo and may be pushed, use repo-relative paths such as `.ai_shared/knowledge/home-audit-rules.md` or `scripts/home-mirror.ps1`.
- When a path must point to a local home install surface, use home-relative forms such as `~/.ai_shared/`, `~/.codex/`, or `~/.claude/` instead of a user-specific absolute path.
- Do not publish user-specific or machine-specific absolute filesystem paths in tracked shareable content. Avoid macOS user-home absolute paths, Linux home-directory absolute paths, and Windows user-profile absolute paths unless the repo explicitly wants a sanitized platform example.

### Layer Responsibilities
- `lv0-home-auditor` should flag user-specific absolute filesystem paths in tracked shareable files as an audit finding so the repo sees the leak early.
- `lv1-github-repo-readiness` should treat those user-specific absolute filesystem paths as a remote-sharing blocker until they are replaced with repo-relative or home-relative forms.

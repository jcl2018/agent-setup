---
applyTo: "scripts/**/*.ps1,.codex/**/*.ps1,.claude/**/*.ps1"
---

When editing PowerShell scripts in this repo:

- Default to non-destructive sync behavior.
- Support `$HOME` or explicit path parameters instead of hardcoding a machine path.
- Prefer copying managed files over deleting unmanaged local state.
- Keep output readable and suitable for manual use.
- Use clear guardrails and fail fast when an expected source path is missing.

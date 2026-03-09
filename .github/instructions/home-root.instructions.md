---
applyTo: ".codex/**,.claude/**,.github/**"
---

This repository mirrors home-level AI tool configuration.

- Keep shared workflow, checklist, template, and knowledge filenames aligned across tool roots when possible.
- Keep the layered stack aligned across tools: `lv0-instruction-core`, then any needed `lv0` onboarding or specialist helper, then the `lv1` task wrapper and any repo-specific `lv2` wrapper.
- Prefer outcome-based user requests; the agent should handle the internal workflow, knowledge, template, and checklist choices.
- Preserve the distinction between reusable configuration and local runtime state.
- Avoid machine-specific absolute paths inside docs unless the file is explicitly about the current machine.
- Prefer small, reviewable edits over broad rewrites.
- When a change belongs in more than one tool root, update the related files in the same pass or leave a clear note.

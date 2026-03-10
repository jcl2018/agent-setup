---
applyTo: ".ai_shared/**,.codex/**,.claude/**,.github/**"
---

This repository mirrors a shared multi-tool AI setup.

- Treat `.ai_shared/` as the canonical shared context layer for all tools.
- Keep reusable workflows, templates, checklists, knowledge notes, examples, and optional shared tasks in `.ai_shared/`.
- Keep `progress-tracker.md` and `future-plan.md` only in each repo's `.ai_shared/knowledge/`.
- Keep `.codex/`, `.claude/`, and `.github/` thin: use them for tool-native wrappers, configs, skills, agents, and auto-attached instructions.
- Prefer repo-local `.ai_shared/` over `~/.ai_shared/` when a repo defines its own shared context.
- Preserve the distinction between reusable shared context and tool-specific behavior.
- Avoid machine-specific absolute paths inside docs unless the file is explicitly about the current machine.
- Prefer small, reviewable edits over broad rewrites.
- When a change belongs in more than one tool wrapper, update the related files in the same pass or leave a clear note.

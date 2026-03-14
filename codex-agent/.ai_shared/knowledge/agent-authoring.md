# Agent Authoring

## Purpose
Explain how to add or extend shared layers without breaking the split between shared `.ai_shared` context and tool-specific wrappers.

## Decide The Layer First
- Create an `lv0-*` layer when the behavior is basic logistics, standards, audit, routing, automation, or another cross-cutting operational concern.
- Create an `lv1-*` layer when the behavior is a reusable workflow such as feature work, defect fixing, review, or publication prep that should apply across repos.
- Reserve repo-specific `lv2-<repo>-*` wrappers for thin overrides that compose the shared layers instead of replacing them.

## When To Create Shared Content
- Put shared workflows in `.ai_shared/workflows/`.
- Put shared templates in `.ai_shared/templates/`.
- Put shared checklists in `.ai_shared/checklists/`.
- Put shared durable notes in `.ai_shared/knowledge/`.
- Add new shared content only when it is cross-tool and likely to be reused.

## When To Create Tool-Specific Content
- Put Codex skills in `.codex/skills/` and mirror them into `.codex/.agents-home/skills/`.

## Files To Create

### New shared workflow, template, checklist, or note
1. Create the shared file under `.ai_shared/`.
2. Update the matching Codex wrappers so they point at the new shared asset.
3. If the change affects stack rules, update `agent-stack.md` and `naming-conventions.md`.

### New Codex skill
1. Create `.codex/skills/lv0-<name>/SKILL.md` or `.codex/skills/lv1-<name>/SKILL.md`.
2. Create the matching `agents/openai.yaml`.
3. Mirror the same files into `.codex/.agents-home/skills/`.
4. Reuse shared `.ai_shared/workflows/`, `.ai_shared/templates/`, `.ai_shared/checklists/`, and `.ai_shared/knowledge/` before creating new shared assets.

## Wrapper Rules
- A wrapper should explain how the tool enters the shared stack.
- A wrapper should stay short and only describe tool-native behavior or tool-only exceptions.
- Shared durable facts do not belong in the wrapper when `.ai_shared/knowledge/` can hold them instead.

## Authoring Rules
1. Start every new wrapper from the current tool's `lv0-instruction-core`.
2. Prefer composing existing `.ai_shared/` assets before adding new shared files.
3. Keep `lv0` layers concern-oriented and `lv1` layers task-oriented.
4. Do not put repo-specific facts into home-level shared wrappers or home-level `.ai_shared/`.
5. If the change affects shared behavior, update the Codex wrappers in the same pass.
6. Codex shared-skill changes must still be mirrored into `.codex/.agents-home/skills/`.
7. Repo continuity lives in `.ai_shared/knowledge/progress-tracker.md` and `.ai_shared/knowledge/future-plan.md`.
8. Global `lv0-home-auditor` continuity lives in `~/.ai_shared/knowledge/progress-tracker.md` and `~/.ai_shared/knowledge/future-plan.md`.
9. Repo-specific weekly audit rules belong in the repo's `.ai_shared/workflows/workflow-home-audit.md`, `.ai_shared/checklists/home-audit-checklist.md`, and optional `.ai_shared/knowledge/home-audit-rules.md`.
10. Put generic local-repo audit logic in `lv0-home-auditor`; keep GitHub-facing visibility and publication checks in `lv1-github-repo-readiness`.
11. When both `lv0` and `lv1` need the same remote-sharing policy, keep that policy in a shared knowledge note such as `.ai_shared/knowledge/remote-sharing-rules.md` and have each layer reference it instead of making one layer depend on the other.
12. Use a repo prefix in `lv2-<repo>-*` names so the scope is obvious the moment someone sees the wrapper.

## Example Stacks
- Weekly home-folder alignment layer:
  tool wrapper + `lv0-instruction-core` + `lv0-run-transparency` + `lv0-home-auditor`
- New reusable test-hardening layer:
  tool wrapper + `lv0-instruction-core` + `lv0-run-transparency` + `lv0-test-hardener`
- Extending this mirror repo:
  tool wrapper + `lv0-instruction-core` + `lv0-run-transparency` + `lv0-repo-onboarding` + `lv0-skill-onboarding`
- New shared release task:
  tool wrapper + `lv0-instruction-core` + `lv0-run-transparency` + `lv1-release-note-writer`
- New repo-specific backend feature wrapper:
  tool wrapper + `lv0-instruction-core` + `lv0-run-transparency` + shared `lv0` or `lv1` layer + a thin repo-local override in `.codex/`

## Validation
- Run `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1 -WhatIf`
- Scan for stale references with `Select-String`
- Check that wrappers point to `.ai_shared/` instead of duplicated tool-root shared folders
- If you added a new shared pattern, update the stack docs and the repo continuity docs

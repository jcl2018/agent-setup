# Agent Authoring

## Purpose
Explain how to add or extend shared layers without breaking the split between shared `.ai_shared` context and tool-specific wrappers.

## Decide The Layer First
- Create an `lv0-*` layer when the behavior is cross-cutting and reusable across many tasks.
- Create an `lv1-*` layer when the behavior is a task wrapper such as feature work, defect fixing, review, or onboarding.
- Reserve repo-specific wrappers for thin overrides that compose the shared layers instead of replacing them.

## When To Create Shared Content
- Put shared workflows in `.ai_shared/workflows/`.
- Put shared templates in `.ai_shared/templates/`.
- Put shared checklists in `.ai_shared/checklists/`.
- Put shared durable notes in `.ai_shared/knowledge/`.
- Put canonical shared skill or agent behavior in `.ai_shared/skills/`.
- Add new shared content only when it is cross-tool and likely to be reused.

## When To Create Tool-Specific Content
- Treat `.codex/skills/`, `.claude/skills/`, and `.github/agents/` as generated or thin wrapper output for shared capabilities unless a behavior is truly tool-specific.
- Mirror generated Codex shared skills into `.codex/.agents-home/skills/`.
- Put path-specific Copilot behavior in `.github/instructions/` only when auto-attachment by path is actually needed.

## Files To Create

### New shared workflow, template, checklist, or note
1. Create the shared file under `.ai_shared/`.
2. Update the matching Codex, Claude, and Copilot wrappers so they point at the new shared asset.
3. If the change affects stack rules, update `agent-stack.md` and `naming-conventions.md`.

### New shared skill or agent capability
1. Create `.ai_shared/skills/<name>/shared.md`.
2. Add metadata for `<name>` to `.ai_shared/skills/catalog.json`.
3. Add shared helper assets such as `references/`, `scripts/`, or `assets/` under `.ai_shared/skills/<name>/` when the capability needs them.
4. Run `powershell -ExecutionPolicy Bypass -File .\scripts\sync-shared-skills.ps1` to regenerate the Codex, Claude, and Copilot wrappers.
5. Reuse shared `.ai_shared/workflows/`, `.ai_shared/templates/`, `.ai_shared/checklists/`, and `.ai_shared/knowledge/` before creating new shared assets.

## Wrapper Rules
- A wrapper should explain how the tool enters the shared stack.
- A wrapper should stay short and only describe tool-native behavior or tool-only exceptions.
- Shared durable facts do not belong in the wrapper when `.ai_shared/knowledge/` can hold them instead.
- Shared behavior should be edited in `.ai_shared/skills/`, not hand-maintained three times in the generated wrappers.

## Authoring Rules
1. Start every new wrapper from the current tool's `lv0-instruction-core`.
2. Prefer composing existing `.ai_shared/` assets before adding new shared files.
3. Keep `lv0` layers concern-oriented and `lv1` layers task-oriented.
4. Do not put repo-specific facts into home-level shared wrappers or home-level `.ai_shared/`.
5. If the change affects shared behavior, edit the canonical shared definition in `.ai_shared/skills/` and regenerate the wrappers in the same pass.
6. Codex shared-skill changes should flow into `.codex/skills/` and `.codex/.agents-home/skills/` through `scripts/sync-shared-skills.ps1`.
7. Repo continuity lives in `.ai_shared/knowledge/progress-tracker.md` and `.ai_shared/knowledge/future-plan.md`.

## Example Stacks
- New reusable test-hardening layer:
  tool wrapper + `lv0-instruction-core` + `lv0-test-hardener`
- Extending this mirror repo:
  tool wrapper + `lv0-instruction-core` + `lv0-repo-onboarding` + `lv0-skill-onboarding`
- New shared release task:
  tool wrapper + `lv0-instruction-core` + `lv1-release-note-writer`
- New repo-specific backend feature wrapper:
  tool wrapper + shared `lv0` or `lv1` layer + a thin repo-local override in `.codex/`, `.claude/`, or `.github/`

## Validation
- Run `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1 -WhatIf`
- Run `powershell -ExecutionPolicy Bypass -File .\scripts\sync-shared-skills.ps1`
- Scan for stale references with `Select-String`
- Check that wrappers point to `.ai_shared/` instead of duplicated tool-root shared folders
- If you added a new shared pattern, update the stack docs and the repo continuity docs

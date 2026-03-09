---
name: lv0-instruction-core
description: Shared routing layer for the home-root Codex system. Use when choosing folders, composing other skills, or creating new repo-specific skills.
---

# Lv0 Instruction Core

## Overview

Use this skill as the common operating layer for every other Codex skill. It reduces folder sprawl by centralizing how the shared workflows, templates, checklists, knowledge notes, and skills fit together.

## Workflow

1. Read `~/.codex/knowledge/agent-stack.md`.
2. Pick the smallest safe stack for the task:
   - `lv0-instruction-core` for shared routing
   - any needed `lv0` helper such as `lv0-repo-onboarding`, `lv0-skill-onboarding`, `lv0-code-polisher`, or `lv0-doc-writer`
   - one task skill such as `lv1-feature-dev`, `lv1-defect-fix`, or `lv1-code-review`
3. Treat `~/.codex/knowledge/progress-tracker.md` and `~/.codex/knowledge/future-plan.md` as required repo docs. Create them if they are missing, record completed context in the progress tracker, and capture unfinished work or follow-up todos in the future plan.
4. Use `~/.codex/workflows/` for process, `~/.codex/knowledge/` for durable facts, `~/.codex/templates/` for structured outputs, and `~/.codex/checklists/` for wrap-up validation.
5. Reuse existing shared assets before creating a new template, checklist, workflow, or knowledge note.
6. When creating a repo-specific skill, keep it thin: reference this skill first, add the smallest relevant specialist or task skill, then add only the repo-specific facts.
7. Before handoff, update the tracker docs with what changed, validation, and next steps.
8. Summarize which stack was used, what changed, and what validation was run.

## Output Shape

- selected stack
- shared files consulted
- tracker docs updated
- validation or skipped checks
- remaining gap or next step

## Stop Conditions

Stop when the requested behavior cannot be mapped safely to an existing workflow or when a proposed shared layer would duplicate an existing one.

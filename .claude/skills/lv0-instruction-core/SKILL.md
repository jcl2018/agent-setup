---
name: lv0-instruction-core
description: Shared routing layer for the home-root Claude system. Use when choosing folders, composing other skills, or creating new repo-specific skills.
---

# Lv0 Instruction Core

## Overview

Use this skill as the common operating layer for every other Claude skill. It reduces folder sprawl by centralizing how the shared workflows, templates, checklists, knowledge notes, and skills fit together.

## Workflow

1. Read `~/.claude/knowledge/agent-stack.md`.
2. Pick the smallest safe stack for the task:
   - `lv0-instruction-core` for shared routing
   - any needed `lv0` helper such as `lv0-repo-onboarding`, `lv0-skill-onboarding`, `lv0-code-polisher`, or `lv0-doc-writer`
   - one task skill such as `lv1-feature-dev`, `lv1-defect-fix`, or `lv1-code-review`
3. Use `~/.claude/workflows/` for process, `~/.claude/knowledge/` for durable facts, `~/.claude/templates/` for structured outputs, and `~/.claude/checklists/` for wrap-up validation.
4. Reuse existing shared assets before creating a new template, checklist, workflow, or knowledge note.
5. When creating a repo-specific skill, keep it thin: reference this skill first, add the smallest relevant specialist or task skill, then add only the repo-specific facts.
6. Summarize which stack was used, what changed, and what validation was run.

## Output Shape

- selected stack
- shared files consulted
- validation or skipped checks
- remaining gap or next step

## Stop Conditions

Stop when the requested behavior cannot be mapped safely to an existing workflow or when a proposed shared layer would duplicate an existing one.

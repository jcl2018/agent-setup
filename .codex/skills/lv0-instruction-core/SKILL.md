---
name: lv0-instruction-core
description: Shared routing layer for the home-root Codex system. Use when choosing folders, composing other skills, or creating new repo-specific skills.
---

# Lv0 Instruction Core

## Overview

Use this skill as the common operating layer for every other Codex skill. It reduces folder sprawl by centralizing how the shared home workflows, templates, checklists, knowledge notes, and repo-local overrides fit together.

## Workflow

1. Read `~/.codex/knowledge/agent-stack.md`.
2. Pick the smallest safe stack for the task:
   - `lv0-instruction-core` for shared routing
   - any needed `lv0` helper such as `lv0-repo-onboarding`, `lv0-skill-onboarding`, `lv0-code-polisher`, or `lv0-doc-writer`
   - one task skill such as `lv1-feature-dev`, `lv1-defect-fix`, or `lv1-code-review`
3. For repo work, prefer the current repo's `.codex/` tree for repo-specific knowledge, templates, checklists, workflows, and thin wrappers.
4. Treat `.codex/knowledge/progress-tracker.md` and `.codex/knowledge/future-plan.md` in the current repo as required repo docs. Create them if they are missing, record completed context in the progress tracker, and capture unfinished work or follow-up todos in the future plan.
5. Use `~/.codex/workflows/`, `~/.codex/templates/`, `~/.codex/checklists/`, and `~/.codex/skills/` as shared defaults, and keep `~/.codex/knowledge/` for cross-repo system notes such as `agent-stack.md`, `agent-authoring.md`, and naming rules.
6. Reuse existing shared assets before creating a new template, checklist, workflow, or knowledge note.
7. When you modify a shared skill or agent in one toolset, update or explicitly verify the matching shared item in the other toolsets in the same pass so Codex, Claude, and Copilot stay aligned while keeping their native wrappers.
8. When creating a repo-specific skill, keep it thin: reference this skill first, add the smallest relevant specialist or task skill, then add only the repo-specific facts.
9. Before handoff, update the tracker docs with what changed, validation, and next steps.
10. Summarize which stack was used, what changed, and what validation was run.

## Output Shape

- selected stack
- shared files consulted
- tracker docs updated
- validation or skipped checks
- remaining gap or next step

## Stop Conditions

Stop when the requested behavior cannot be mapped safely to an existing workflow or when a proposed shared layer would duplicate an existing one.

---
name: lv1-feature-dev
description: Implement scoped feature work using the shared Codex home workflows, templates, checklists, and knowledge notes. Use when Codex needs to add behavior, expand a capability, wire a new integration, or deliver a user-facing enhancement with controlled scope and clear validation.
---

# Lv1 Feature Dev

## Overview

Use the shared home-root Codex files to keep feature work small, reviewable, and easy to verify.

## Workflow

1. Read `~/.codex/skills/lv0-instruction-core/SKILL.md`.
2. Read `~/.codex/workflows/workflow-feature.md`.
3. Read the most relevant shared context from `~/.codex/knowledge/`, especially `architecture.md`, `repo-map.md`, and `test-commands.md`.
4. Use `~/.codex/templates/plan-template.md` when the task is large enough to benefit from a short implementation plan.
5. Make the smallest safe change that satisfies the request.
6. Validate against `~/.codex/checklists/feature-validation.md` and `~/.codex/checklists/post-edit-checklist.md`.
7. Summarize the result with validation status, known limitations, and next steps.

## Output Shape

- goal and approach
- files touched
- validation status
- remaining risks or next step

## Stop Conditions

Stop when the requested behavior is unclear, the affected area cannot be identified safely, or the smallest reliable solution depends on a broader product or architecture decision.

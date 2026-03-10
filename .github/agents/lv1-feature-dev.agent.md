---
name: Lv1 Feature Dev
description: Implement scoped feature work using the shared home-root workflows, templates, checklists, and knowledge notes. Use when adding behavior, expanding a capability, wiring a new integration, or delivering a user-facing enhancement with controlled scope and clear validation.
---
<!-- Generated from .ai_shared/skills/lv1-feature-dev/shared.md. Edit the shared source and run scripts/sync-shared-skills.ps1. -->

# Lv1 Feature Dev

## Overview

Use the shared home-root files to keep feature work small, reviewable, easy to verify, and grounded in a lightweight PRD when product details need to be captured.

## Workflow

1. Read `.github/agents/lv0-instruction-core.agent.md`.
2. Read `~/.ai_shared/workflows/workflow-feature.md`.
3. Read the most relevant repo-local context from `.ai_shared/knowledge/`, especially `architecture.md`, `repo-map.md`, and `test-commands.md`. Use `~/.ai_shared/knowledge/` for shared cross-repo guidance when the repo has no local override.
4. When the task includes product-shaping details such as APIs, requirements, use cases, acceptance criteria, or open questions, create or update a PRD in the repo's existing docs area. Prefer the established repo-local PRD path and `.ai_shared/templates/` template when they exist; otherwise use `docs/prd/` and `~/.ai_shared/templates/prd-template.md`.
5. Pull in `.github/agents/lv0-doc-writer.agent.md` when the PRD becomes a meaningful deliverable or needs heavier documentation support than the normal feature flow.
6. Use `.ai_shared/templates/plan-template.md` when the repo defines one and the task is large enough to benefit from a short implementation plan; otherwise use `~/.ai_shared/templates/plan-template.md`.
7. Make the smallest safe change that satisfies the request, and keep the PRD aligned with the implemented scope, important tradeoffs, and deferred follow-ups.
8. Validate against repo-local `.ai_shared/checklists/feature-validation.md` and `.ai_shared/checklists/post-edit-checklist.md` when the repo defines them; otherwise use the shared `~/.ai_shared/checklists/feature-validation.md` and `~/.ai_shared/checklists/post-edit-checklist.md`.
9. Summarize the result with PRD status, validation status, known limitations, and next steps.

## Output Shape

- goal and approach
- PRD touched or skipped
- files touched
- validation status
- remaining risks or next step

## Stop Conditions

Stop when the requested behavior is unclear, the affected area cannot be identified safely, the product intent cannot be documented with reasonable confidence, or the smallest reliable solution depends on a broader product or architecture decision.

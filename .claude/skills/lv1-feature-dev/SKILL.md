---
name: lv1-feature-dev
description: Implement scoped feature work using the shared Claude home workflows, templates, checklists, and knowledge notes. Use when Claude needs to add behavior, expand a capability, wire a new integration, or deliver a user-facing enhancement with controlled scope and clear validation.
---

# Lv1 Feature Dev

## Overview

Use the shared home-root Claude files to keep feature work small, reviewable, easy to verify, and grounded in a lightweight PRD when product details need to be captured.

## Workflow

1. Read `~/.claude/skills/lv0-instruction-core/SKILL.md`.
2. Read `~/.claude/workflows/workflow-feature.md`.
3. Read the most relevant shared context from `~/.claude/knowledge/`, especially `architecture.md`, `repo-map.md`, and `test-commands.md`.
4. When the task includes product-shaping details such as APIs, requirements, use cases, acceptance criteria, or open questions, create or update a PRD in the repo's existing docs area. Prefer the established PRD path when one exists; otherwise use `docs/prd/` and `~/.claude/templates/prd-template.md`.
5. Pull in `~/.claude/skills/lv0-doc-writer/SKILL.md` when the PRD becomes a meaningful deliverable or needs heavier documentation support than the normal feature flow.
6. Use `~/.claude/templates/plan-template.md` when the task is large enough to benefit from a short implementation plan.
7. Make the smallest safe change that satisfies the request, and keep the PRD aligned with the implemented scope, important tradeoffs, and deferred follow-ups.
8. Validate against `~/.claude/checklists/feature-validation.md` and `~/.claude/checklists/post-edit-checklist.md`.
9. Summarize the result with PRD status, validation status, known limitations, and next steps.

## Output Shape

- goal and approach
- PRD touched or skipped
- files touched
- validation status
- remaining risks or next step

## Stop Conditions

Stop when the requested behavior is unclear, the affected area cannot be identified safely, the product intent cannot be documented with reasonable confidence, or the smallest reliable solution depends on a broader product or architecture decision.

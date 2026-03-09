# Workflow: Code Review

## Purpose
Review a change set for correctness, regressions, risky assumptions, and missing validation.

## Trigger
Use this workflow when the task asks for:
- a review
- bug or risk findings
- regression analysis
- a pre-merge assessment

## Inputs
- diff, branch, commit, or file list to review
- stated scope or intent of the change
- test results if available

## Steps
1. Understand the intended change and affected behavior.
2. Inspect the diff alongside surrounding code and existing patterns.
3. Look for correctness issues, edge cases, state mismatches, and broken assumptions.
4. Check whether validation covers the changed behavior.
5. Prioritize findings by severity and confidence.
6. Update `knowledge/progress-tracker.md` with the review scope, main findings, and validation context.
7. Add requested follow-ups, deferred fixes, or extra test ideas to `knowledge/future-plan.md`.
8. Call out open questions or assumptions that affect the review.
9. Summarize residual risk after findings.

## Output
The final response should include:
- findings first, ordered by severity
- file and line references when available
- open questions or assumptions
- tracker or follow-up docs updated when relevant
- a short overall assessment

## Stop Conditions
Stop and report blockers when the reviewed change is incomplete or unavailable, generated output hides the real source changes, or the review requires missing runtime context to assess correctness.

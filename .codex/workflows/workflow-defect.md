# Workflow: Defect Fix

## Purpose
Diagnose, contain, and fix a defect with clear reasoning and verification.

## Trigger
Use this workflow when the task asks for:
- a bug fix
- a regression fix
- an incident follow-up
- debugging unexpected behavior

## Inputs
- issue summary or symptoms
- reproduction steps if available
- expected behavior
- suspected files, components, logs, or failing tests

## Steps
1. Understand the reported behavior and define the expected behavior.
2. Inspect the affected code paths, logs, tests, and recent context.
3. Reproduce the issue or explain why reproduction is not currently possible.
4. Identify the likely cause and choose the smallest reliable fix.
5. Implement the fix and add or update validation where appropriate.
6. Run checks, targeted tests, or manual verification.
7. Review for adjacent regressions and summarize the result.

## Output
The final response should include:
- issue summary
- likely cause
- fix approach
- validation performed
- remaining risk or monitoring notes

## Stop Conditions
Stop and ask for clarification or report blockers when the bug report lacks enough detail to identify the affected area, reproduction depends on missing environment access or data, multiple root causes remain plausible and the choice is risky, or the safest fix requires broader product or architectural decisions.

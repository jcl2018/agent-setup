# Workflow: Repo Onboarding

## Purpose
Build fast working context for an unfamiliar repository before making or reviewing changes.

## Trigger
Use this workflow when the task asks for:
- a repo walkthrough
- onboarding help
- help locating key files or systems
- initial setup guidance for future tasks

## Inputs
- repository root or relevant workspace path
- known goal, feature area, or question
- available setup notes, docs, or commands

## Steps
1. Identify the repo shape, languages, frameworks, and entry points.
2. Locate key docs, package manifests, config files, and test commands.
3. Map major directories to responsibilities and owners if available.
4. Identify how to run, test, and verify typical changes.
5. Call out risky areas, generated content, and likely override points.
6. Summarize the repo map and practical next steps for future work.

## Output
The final response should include:
- a concise repo map
- important commands
- notable conventions or danger zones
- recommended next places to look

## Stop Conditions
Stop and report blockers when the repository is not accessible, key setup files are missing or unreadable, or the repo depends on external systems that cannot be inspected.

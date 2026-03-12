# Local Repo Audit Checklist

## Shared Repo-Hygiene Checks

- Verify the repo has a README that explains the project, setup, and a first successful run.
- Verify the repo has at least one documented or discoverable automated validation or test path.
- Verify `.gitignore` exists and covers local databases, caches, generated output, and secret-bearing env files.
- Remove, anonymize, or quarantine tracked local artifacts such as databases, spreadsheets, caches, backups, and generated reports before wider collaboration.
- Look for hardcoded secret-like literals and other values that should stay local.
- Review whether large tracked files belong in git or need a safer distribution path.
- Confirm docs, examples, or sanitized sample data exist when the real project data cannot be shared.
- Call out local-only assumptions so collaborators know what is safe to change and what stays machine-specific.

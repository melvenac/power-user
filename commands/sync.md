# /sync — Validate Before Commit

> Check that project documentation is consistent and up to date. Run before committing.

## Steps

### 1. Check SUMMARY.md accuracy
- Compare what SUMMARY.md says vs. actual project state
- Flag anything that looks outdated or wrong

### 2. Check INBOX.md accuracy
- Are completed tasks marked as done?
- Are there tasks that no longer make sense?

### 3. Check ENTITIES.md vs. code
- If the project has schema/model files, compare them to ENTITIES.md
- Flag any mismatches (fields added in code but not documented, or vice versa)

### 4. Check DECISIONS.md
- Were decisions made recently that aren't logged?

### 5. Report

```
Sync check:
✓ SUMMARY.md — up to date
✓ INBOX.md — 2 tasks completed, marked done
✗ ENTITIES.md — User model has new "avatar" field not in docs
✓ DECISIONS.md — no missing entries

Fix ENTITIES.md before committing? (y/n)
```

### 6. Fix issues
If the user approves, fix any flagged issues automatically.

## Judgment calls

- This is a lightweight check, not a full audit. Don't read every file in the project.
- Focus on .agents/ document consistency, not code quality.
- If no issues are found, just say "All docs in sync. Ready to commit."

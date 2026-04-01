# /feedback — Student Feedback

Submit feedback on the Power User curriculum. Your input helps improve the course for everyone.

## Steps

1. **Ask the student** what they want to share. Prompt them with:
   - What lesson or module are you on?
   - What's confusing, missing, or broken?
   - What would have helped you?

   Wait for their response before continuing.

2. **Determine the feedback type** based on their response:
   - `confusion` — something was hard to understand
   - `missing` — something they expected wasn't covered
   - `bug` — a broken link, wrong command, or error in the material
   - `suggestion` — an idea for improvement
   - `praise` — something that worked really well

3. **Draft the issue** and show it to the student for approval:
   - Title: short summary (under 70 chars)
   - Body: their feedback, the lesson/module reference, and the feedback type
   - Label: `student-feedback`

4. **After student approves**, create the GitHub issue:
   ```bash
   gh issue create --repo melvenac/power-user \
     --title "THE TITLE" \
     --label "student-feedback" \
     --body "THE BODY"
   ```

5. **Show the issue URL** so they can track it.

6. **Thank them.** Remind them that their feedback directly improves the curriculum — this is a self-improving loop.

## Issue Body Template

```markdown
## Feedback Type
[confusion | missing | bug | suggestion | praise]

## Module / Lesson
[e.g., Module 01 / Lesson 02: Slash Commands]

## Details
[Student's feedback in their own words]

## Context
[What they were trying to do when they hit this]

---
Submitted via `/feedback` command in Claude Code
```

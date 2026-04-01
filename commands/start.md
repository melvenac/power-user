# /start — Session Start

> Load project state and get oriented. Run this at the beginning of every session.

## Steps

### 1. Read project state

If `.agents/SYSTEM/SUMMARY.md` exists:
```
Read: .agents/SYSTEM/SUMMARY.md
```
Understand where the project is — what's working, what's broken, what's next.

### 2. Read task priorities

If `.agents/TASKS/INBOX.md` exists:
```
Read: .agents/TASKS/INBOX.md
```
Also read `.agents/TASKS/task.md` if it exists for current sprint focus.

### 3. Check for handoff notes

If `.agents/SESSIONS/next-session.md` exists, read it. This was written by `/end` last session.

### 4. Create session log

If `.agents/SESSIONS/` exists:
```
Create: .agents/SESSIONS/Session_N.md (next number)
```
Fill in the date. Leave objective blank until approved.

### 5. Present summary

```
Session N — [Date]
Project State: [1-2 sentences from SUMMARY.md]
Proposed Objective: [highest priority incomplete task from INBOX.md]

What would you like to work on?
```

## Judgment calls

- If the user jumps straight into a task, adapt. Don't force the protocol.
- If no `.agents/` exists, just greet and ask what they'd like to work on.
- Keep the summary to 5 lines max. Don't dump walls of text.

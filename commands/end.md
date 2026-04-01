# /end — Session End

> Save project state and write handoff notes. Run this at the end of every session.

## Steps

### 1. Update session log

If a session log exists (`.agents/SESSIONS/Session_N.md`), fill in:
- What was accomplished
- Key decisions made
- Files created or modified
- Gotchas discovered (don't let hard-won knowledge disappear)

### 2. Update SUMMARY.md

If `.agents/SYSTEM/SUMMARY.md` exists:
- Update "What's Working" with newly completed features
- Update "What's Broken or Incomplete" with current issues
- Update "What's Next" with the next priority
- Keep it focused on NOW — archive old milestones, don't let it grow forever

### 3. Update INBOX.md

If `.agents/TASKS/INBOX.md` exists:
- Check off completed tasks: `- [ ]` → `- [x]`
- Add any new tasks discovered during the session
- Re-prioritize if needed

### 4. Update DECISIONS.md

If architectural decisions were made this session, log them in `.agents/SYSTEM/DECISIONS.md`:
```
## DEC-NNN: [Decision title]
**Date:** [Today]
**Context:** [Why this came up]
**Decision:** [What we chose]
**Trade-off:** [What we gave up]
```

### 5. Update ENTITIES.md

If the data model changed, update `.agents/SYSTEM/ENTITIES.md` to match the current schema.

### 6. Write handoff notes

Create `.agents/SESSIONS/next-session.md`:
```
## What's in progress
[Current work state]

## Gotchas to watch for
[Anything the next session should know]

## Open questions
[Decisions that still need to be made]
```

### 7. Present summary

```
Session N complete.
- Accomplished: [1-2 sentences]
- Updated: [list of .agents/ files updated]
- Next session: [what to pick up]
```

## Judgment calls

- If the session was short, keep updates minimal. Don't over-document a 5-minute fix.
- If no `.agents/` exists, just summarize what was done.
- Always update SUMMARY.md — it's the most important file for session continuity.

# Lesson 03: Session 2 — Your First Dev Cycle

## The Real Test

Session 1 was setup. Session 2 is where you see the framework's value — Claude Code should pick up exactly where you left off.

## Step 1: /start

Open Claude Code in your project and run:

```
/start
```

Pay attention to what Claude Code tells you:
- **Project state** — from SUMMARY.md (updated in Session 1)
- **Next task** — from INBOX.md
- **Session 1 handoff** — what was in progress, any gotchas

**Check:** Does it know what you did yesterday? If yes, the framework is working. If not, something in /end didn't save properly — debug it now.

## Step 2: Pick a Task

```
/task
```

This reads INBOX.md and presents the next priority. You can:
- Accept the suggestion
- Pick a different task: "Let's work on [X] instead"
- Add a new task: "Add [task] to the inbox and let's do that"

## Step 3: Work a Full Feature

This session, build something real. A complete feature, end to end:

1. **Plan** — tell Claude Code what you're building and ask for a quick plan
2. **Implement** — let Claude Code write the code
3. **Iterate** — review, give feedback, refine
4. **Test** — at minimum, manually verify it works

### During Development, Notice:

**Does Claude Code follow your RULES.md?**
If you said "use TypeScript strict mode" in RULES.md, does it? If not, that's a rules gap to fix.

**Does it reference ENTITIES.md correctly?**
When touching data models, does it know the schema? If you update the schema, tell Claude Code:
```
"We changed the User model — update ENTITIES.md to match"
```

**Are decisions being made?**
If you chose approach A over approach B, log it:
```
"Log this in DECISIONS.md: we chose [approach A] because [reason]"
```

This is how future sessions understand *why* the code looks the way it does.

## Step 4: The /sync Check

Before committing, run:

```
/sync
```

This validates:
- Version numbers are consistent across docs
- Referenced files exist
- No structural issues in .agents/

If it flags anything, fix it before committing. This is your quality gate.

## Step 5: Commit

```
"Commit our changes with a descriptive message"
```

Claude Code will stage files, write a commit message, and commit. The /sync step ensures your docs are in sync with your code.

## Step 6: /end

```
/end
```

This time, pay extra attention to:
- **SUMMARY.md** — does it reflect the feature you just built?
- **INBOX.md** — is the completed task checked off?
- **Session log** — does it capture the key decisions and gotchas?
- **Handoff notes** — would Session 3 know what to do next?

## Step 7: Review the Accumulation

Two sessions in. Let's see what's building up:

```
"Show me the diff between our Session 1 and Session 2 
versions of SUMMARY.md"
```

You should see the project evolving — new features listed, state moving forward. This is the self-improving part. Each session leaves the project state more complete.

## The Dev Cycle Pattern

You just completed your first full dev cycle:

```
/start          → Orient (know where you are)
/task           → Focus (know what to do)
  ... code ...  → Build (do the work)
/sync           → Validate (docs match code)
  ... commit .. → Save (commit with confidence)
/end            → Preserve (capture what happened)
```

This is the cycle you'll repeat every session. It takes 2-3 minutes of overhead for hours of saved context and continuity.

## Common Issues in Session 2

### "Claude doesn't remember what I did"
→ Check that /end ran properly in Session 1. Read SUMMARY.md — is it updated?

### "SUMMARY.md is stale"
→ If /end missed something, fix it manually: "Update SUMMARY.md to reflect that we built [feature]"

### "INBOX.md doesn't match reality"
→ Tasks drift. Reconcile: "Review INBOX.md against what we've actually done and fix it"

### "I made a decision but didn't log it"
→ Do it now: "Add to DECISIONS.md: [decision and reasoning]"

The framework is self-healing — if something drifts, you catch it next /start and fix it.

## Exercise: The Continuity Test

After running /end, close Claude Code completely. Wait at least a few minutes (or come back tomorrow). Then:

1. Open Claude Code
2. Run `/start`
3. Ask: "What did we do last session and what's next?"

If Claude Code answers accurately without you explaining anything, the framework is working. That's the whole point.

## Key Takeaway

Session 2 proves the value: Claude Code picks up where Session 1 left off, you build a real feature, and the project state evolves. The 2-3 minutes of /start and /end overhead saves 15+ minutes of re-explaining context. And it gets more valuable every session.

---

**Next:** [Session 3: Testing & Validation](04-session-3-testing.md)

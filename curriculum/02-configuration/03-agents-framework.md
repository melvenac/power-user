# Lesson 03: The .agents/ Framework

## Your Project's Operating System

CLAUDE.md tells Claude Code *how* to work. The `.agents/` framework tells it *what's happening* — project state, tasks, decisions, and session history.

Think of it this way:
- **CLAUDE.md** = the employee handbook
- **.agents/** = the project management board

## The Structure

```
.agents/
├── TASKS/
│   └── INBOX.md          # What needs doing
├── SESSIONS/
│   └── SESSION_TEMPLATE.md  # Template for session logs
├── SYSTEM/
│   ├── SUMMARY.md         # Current project state
│   ├── ENTITIES.md         # Key data models
│   └── RULES.md            # Project rules and constraints
└── skills/
    └── INDEX.md            # Project-specific skills
```

You don't need all of these right away. Let's walk through each one.

## TASKS/INBOX.md — The Task Board

This is your single source of truth for what needs doing:

```markdown
# My App — Task Inbox

## Priority
- [ ] Fix login bug for plus-sign emails
- [ ] Add pagination to user list endpoint

## Backlog
- [ ] Dark mode support
- [ ] Export data as CSV
- [ ] Performance audit

## Done
- [x] Set up project with /bootstrap
- [x] Create initial database schema
```

When you start a session with `/start`, Claude Code reads this and knows what to work on. When a task is done, it gets checked off. Simple.

**Power tip:** When you finish a session, the tasks get updated automatically. Next session, Claude picks up right where you left off.

## SYSTEM/SUMMARY.md — The State Snapshot

A living document that captures where the project is right now:

```markdown
# My App

## Status
v0.2.0 — Core auth working, API endpoints 80% complete

## What's Working
- User registration and login
- JWT auth middleware
- CRUD for /users and /projects endpoints

## What's Broken or Incomplete
- Pagination not implemented on list endpoints
- No rate limiting
- Tests only cover auth module

## What's Next
- Add pagination (highest priority in INBOX)
```

This gets updated each session. It's how Claude Code understands project state without re-reading your entire codebase.

## SYSTEM/ENTITIES.md — The Data Model

A reference for the key objects in your project:

```markdown
# Entities

## User
- id, email, name, role (admin/member), created_at
- Has many: Projects, Sessions

## Project
- id, name, owner_id, status (active/archived), created_at
- Belongs to: User
- Has many: Tasks
```

This saves Claude Code from re-discovering your data model every session.

## SYSTEM/RULES.md — The Guardrails

Project-specific rules beyond what's in CLAUDE.md:

```markdown
# Rules

- Never modify database schema without creating a migration
- All API endpoints must have input validation
- Error responses must follow the format: { error: string, code: number }
- Don't delete user data — soft-delete only (set deleted_at)
```

## SESSIONS/ — The History

Each session gets a log. You don't write these — Claude Code fills them in. They're useful for:
- Picking up where you left off
- Understanding why a decision was made
- Reviewing what changed

Session logs are ephemeral — they're gitignored by default.

## How It All Fits Together

```
/start (beginning of session)
    → Reads SUMMARY.md (where are we?)
    → Reads INBOX.md (what's next?)
    → Reads RULES.md (what are the constraints?)
    → Creates a new session log
    → Presents: "Here's the project state, here's what I suggest we work on"

... you work ...

/end (end of session)
    → Updates INBOX.md (checks off completed tasks)
    → Updates SUMMARY.md (what changed this session)
    → Fills in session log
    → Writes handoff notes for next session
```

## You Don't Have To Do Any Of This Manually

This is the key point: **`/bootstrap` creates all of these files for you.** And `/start` and `/end` keep them updated.

You just:
1. Run `/bootstrap` once when starting a project
2. Run `/start` at the beginning of each session
3. Run `/end` when you're done for the day
4. Everything else is automatic

## Exercise: Explore Your .agents/

If you bootstrapped a project in Module 00:

1. Ask: `"Read our .agents/ structure and tell me what's in each file"`
2. Manually add a task to INBOX.md: `"Add a task to INBOX: set up CI/CD pipeline"`
3. Ask: `"What's our current project state according to SUMMARY.md?"`

If you haven't bootstrapped yet:
```
/bootstrap
```
Then do steps 1-3.

## Key Takeaway

The `.agents/` framework is your project's memory between sessions. It answers three questions: where are we, what's next, and what are the rules. Claude Code maintains it, you steer it.

---

**Next:** [Putting It Together: /bootstrap](04-bootstrap.md)

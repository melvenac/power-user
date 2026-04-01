# Lesson 03: The .agents/ Framework

## Your Project's Operating System

CLAUDE.md tells Claude Code *how* to work. The `.agents/` framework tells it *what's happening* — project state, tasks, decisions, and session history.

Think of it this way:
- **CLAUDE.md** = the employee handbook
- **.agents/** = the project management board

## The Framework

The `.agents/` structure comes from the **Self-Improving Agent framework** — a portable architecture that works with any AI coding agent (Claude Code, Cursor, Gemini, etc.) and any tech stack.

> **You don't need to clone or install anything.** The `/bootstrap` command scaffolds everything your project needs locally. The full framework reference repo ([Self-Improving-Agent](https://github.com/melvenac/Self-Improving-Agent)) is optional reading — you'll explore it in Module 08 when you're ready for the advanced features.

## The Structure

```
.agents/
├── FRAMEWORK.md              # How to use & duplicate the framework
├── SYSTEM/                   # Project truth documents
│   ├── PRD.md                # Product requirements (the foundation)
│   ├── SUMMARY.md            # Current state (updated every session)
│   ├── ENTITIES.md           # Data model documentation
│   ├── DECISIONS.md          # Architectural decision log
│   ├── RULES.md              # Coding standards & conventions
│   ├── TESTING.md            # Testing strategy
│   ├── RUNBOOK.md            # Production operations
│   └── SECURITY.md           # Security audit checklist
├── TASKS/                    # Work tracking
│   ├── INBOX.md              # Prioritized task backlog
│   └── task.md               # Current sprint/focus
├── SESSIONS/                 # Session history
│   └── SESSION_TEMPLATE.md   # Template for new sessions
└── skills/                   # Reusable agent skills
    └── INDEX.md              # Skill registry
```

### The Three Layers

| Layer | Purpose | Changes How Often |
|---|---|---|
| **SYSTEM/** | Project truth — what the project IS | Rarely (PRD, RULES) to every session (SUMMARY) |
| **TASKS/** | What needs to be DONE | Every session |
| **SESSIONS/** | What WAS done | Append-only log |

You don't need all of these right away. Let's walk through each one.

## SYSTEM/PRD.md — The Foundation

This is the **most important file** in the framework. The PRD (Product Requirements Document) is where everything else derives from:

```markdown
# My App — Product Requirements

## Overview
What are we building? For whom?

## Core Features
1. User authentication
2. Dashboard with real-time data
3. ...

## Tech Stack
Next.js 14, Convex, TypeScript, Tailwind

## User Roles
- Admin: full access
- Member: read + own data

## Data Model
- User: id, email, name, role
- Project: id, name, owner_id

## Third-Party Integrations
- Stripe for payments
- Clerk for auth
```

From the PRD, you derive:
- **ENTITIES.md** from the data model section
- **RULES.md** from the tech stack section
- **INBOX.md** from the core features list
- **SUMMARY.md** from the overview

Write the PRD first. Everything else follows.

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

## SYSTEM/DECISIONS.md — The Decision Log

When you make architectural choices, log them so future sessions (and future you) understand *why*:

```markdown
# Decisions

## DEC-001: Use Convex over PostgreSQL
**Date:** 2026-03-15
**Context:** Need real-time data for dashboard
**Decision:** Convex — built-in real-time, typed queries, no server management
**Trade-off:** Vendor dependency, but productivity gain is worth it

## DEC-002: Soft-delete only
**Date:** 2026-03-18
**Context:** Legal requires data retention
**Decision:** Never hard-delete user data — set deleted_at timestamp
```

## Path-Specific Rules (`.claude/rules/`)

Beyond RULES.md, the framework uses **path-triggered rules** — markdown files that only load when Claude Code reads matching files:

```
.claude/rules/
├── frontend.md    → loaded when reading src/components/**, src/app/**/page.*
├── backend.md     → loaded when reading src/api/**, convex/**
├── database.md    → loaded when reading schema files
├── testing.md     → loaded when reading test files
└── agents.md      → loaded when reading .agents/ files
```

Each file has a glob pattern in its frontmatter:
```markdown
---
description: Frontend coding standards
globs: src/components/**, src/app/**/page.*
---
# Frontend Rules
- Server Components by default, 'use client' only when needed
```

This saves context — you only load the rules relevant to what you're working on, not every rule in the project.

## How It All Fits Together

```
/start (beginning of session)
    → Reads SUMMARY.md (where are we?)
    → Reads INBOX.md (what's next?)
    → Reads ENTITIES.md (if schema work today)
    → Creates a new session log
    → Presents: "Here's the project state, here's what I suggest we work on"

... you work ...

/sync (before committing)
    → Validates version consistency across docs
    → Checks structural integrity (files exist, references valid)
    → Flags any drift between docs

/end (end of session)
    → Updates INBOX.md (checks off completed tasks)
    → Updates SUMMARY.md (what changed this session)
    → Updates DECISIONS.md (if architectural choices were made)
    → Updates ENTITIES.md (if schema changed)
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

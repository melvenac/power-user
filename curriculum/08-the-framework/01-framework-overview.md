# Lesson 01: The Framework Overview

## What You've Learned vs. What You'll Practice

Modules 00-07 taught you the pieces:
- Tools, commands, context (Modules 00-01)
- CLAUDE.md, settings, .agents/ structure (Module 02)
- MCP servers (Module 03)
- Memory and knowledge (Module 04)
- Multi-agent work (Module 05)
- Skills, hooks, automation (Module 06)
- Stack selection (Module 07)

This module ties them all together into one **living system** — the Self-Improving Agent framework.

## The Self-Improving Agent

The name says it: this framework improves itself over time. Here's how:

```
Session 1: You and Claude Code start fresh
Session 5: Claude Code knows your project's state, patterns, gotchas
Session 10: Skills have emerged from repeated patterns
Session 20: The framework is deeply customized to your project
Session 50: Claude Code is genuinely expert in your codebase
```

This happens because:
1. **Every session starts informed** — `/start` loads state, tasks, and relevant experiences
2. **Every session ends preserved** — `/end` captures what happened, what was learned
3. **Knowledge accumulates** — experiences are stored, recalled, and feedback-rated
4. **Skills emerge** — repeated patterns become formalized skills
5. **Bad knowledge is pruned** — unhelpful entries get demoted and removed

## The Framework Components

### Documents (your project's brain)

| Document | Purpose | Updated |
|---|---|---|
| **PRD.md** | What you're building and why | Rarely — the foundation |
| **SUMMARY.md** | Where the project is RIGHT NOW | Every session |
| **ENTITIES.md** | Your data models | When schema changes |
| **DECISIONS.md** | Why you made key choices | When decisions are made |
| **RULES.md** | Coding standards | As conventions evolve |
| **TESTING.md** | Testing strategy | After first feature ships |
| **RUNBOOK.md** | How to deploy and operate | Before production |
| **SECURITY.md** | Security checklist | Before production |

### Commands (your workflow)

| Command | When | What It Does |
|---|---|---|
| `/bootstrap` | Once, at project creation | Scaffolds everything |
| `/start` | Beginning of every session | Loads state, recalls knowledge, creates session log |
| `/task` | When you need direction | Picks the next priority from INBOX |
| `/test` | After feature work | Zero-token E2E testing |
| `/sync` | Before every commit | Validates doc consistency |
| `/end` | End of every session | Saves state, captures learnings |

### Path Rules (context-efficient guardrails)

```
.claude/rules/
├── frontend.md    → only loaded when touching frontend code
├── backend.md     → only loaded when touching backend code
├── database.md    → only loaded when touching schema
├── testing.md     → only loaded when touching tests
└── agents.md      → only loaded when touching .agents/
```

### Skills (accumulated expertise)

Skills emerge over time. You don't create them upfront:

```
Session 1-3:   Just code. Notice patterns.
Session 4-8:   Create 1-2 skills from repeated patterns
Session 8+:    Add testing skill, deployment skill
Session 15+:   Your skill library is genuinely useful
```

## The Daily Rhythm

```
Morning:
  claude                     # Open Claude Code
  /start                     # Load state, get oriented

Work:
  /task                      # Pick up next task
  ... code, test, iterate ...
  /task                      # Next task when done

Before commit:
  /sync                      # Validate everything is consistent
  git add . && git commit    # Commit with confidence

End of day:
  /end                       # Save state, capture learnings
```

That's it. Five commands across your entire workflow.

## Why This Matters

Without the framework:
- Session 1: "What does this project do again?"
- Session 5: "Didn't we already solve this?"
- Session 10: "I keep making the same mistake..."

With the framework:
- Session 1: Clear state, prioritized tasks
- Session 5: Past experiences recalled, patterns emerging
- Session 10: Skills prevent repeated mistakes, knowledge is deep

The difference compounds. After a month, a framework-driven project is dramatically more productive than one without.

## What You Need for the Next Lessons

1. **A project idea** — something you want to build. Doesn't need to be complex. Examples:
   - Personal dashboard
   - Task tracker
   - API for a hobby project
   - CLI tool for something you do manually

2. **Your tech stack chosen** — refer back to Module 07 if needed

3. **45-60 minutes per "session" lesson** — each lesson is a guided session

## Key Takeaway

The framework is the system that makes everything from Modules 00-07 work together automatically. You've learned the pieces — now you'll see them in action as a complete, self-improving workflow.

---

**Next:** [Session 1: Setup & PRD](02-session-1-setup.md)

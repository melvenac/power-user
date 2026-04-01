# Lesson 01: How Memory Works

## The Problem With Forgetting

Every time you start a new Claude Code session, it starts fresh. No memory of yesterday's work, no knowledge of your preferences, no context about the bug you were chasing.

Unless you set up memory.

## Two Types of Memory

### 1. Session Memory (within a conversation)
This is the context window — everything said and done in the current session. It's automatic but temporary. When you close the session, it's gone.

**This is what we covered in Module 01, Lesson 05.**

### 2. Persistent Memory (across conversations)
This is information that survives between sessions. It lives in files and databases, and Claude Code loads it at the start of each session.

**This is what this module is about.**

## How Persistent Memory Works

```
Session 1: You work on auth → /end saves what happened
Session 2: /start loads what happened → You continue seamlessly
```

The mechanism is straightforward:

1. **CLAUDE.md** is loaded automatically every session (your project instructions)
2. **.agents/SUMMARY.md** captures project state (updated by /end)
3. **Auto-memory** files in `.claude/` store user preferences and learned patterns
4. **External knowledge** (MCP servers like Open Brain) stores experiences and skills

None of this requires you to do anything special — the `/start` and `/end` workflow handles it.

## What Gets Remembered

| What | Where | How |
|------|-------|-----|
| Project instructions | CLAUDE.md | You write it, loaded every session |
| Project state | .agents/SUMMARY.md | Updated by /end, read by /start |
| Task progress | .agents/TASKS/INBOX.md | Updated as you work |
| Your preferences | .claude/memory/ | Auto-saved when Claude learns something |
| Session handoffs | .agents/SESSIONS/next-session.md | Written by /end for next /start |
| Experiences & skills | Knowledge MCP (Open Brain) | Accumulated over time |

## The Memory Hierarchy

Not all memory is equal. Here's how Claude Code prioritizes:

```
CLAUDE.md                    ← Always loaded, highest priority
.agents/ state files         ← Loaded by /start
Auto-memory                  ← Loaded automatically, lower priority
Knowledge MCP recalls        ← Loaded by /start if relevant
Session context              ← Everything in current conversation
```

Higher priority memories override lower ones. If CLAUDE.md says "use pnpm" but a recalled experience mentions npm, CLAUDE.md wins.

## Exercise: See Your Memory

Ask Claude Code these questions:

```
"What do you know about me without reading any files?"
```
(Answer: nothing — it starts fresh)

```
"Now read CLAUDE.md and .agents/SUMMARY.md. What do you know?"
```
(Answer: project context, conventions, state)

```
"Check if there are any memory files in .claude/memory/"
```
(Answer: your auto-saved preferences and patterns)

The difference between the first and second answer is the value of memory.

## Key Takeaway

Memory is the bridge between sessions. Without it, every session starts from zero. With it, Claude Code picks up where you left off, knows your preferences, and understands your project's history. The cost is near zero — `/start` and `/end` handle the heavy lifting.

---

**Next:** [The Memory Layers](02-memory-layers.md)

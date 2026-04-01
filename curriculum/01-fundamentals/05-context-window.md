# Lesson 05: The Context Window

## The Most Important Concept You'll Learn

The context window is the single biggest constraint — and opportunity — in Claude Code. Understanding it separates beginners from power users.

## What Is It?

The context window is Claude's working memory. Everything in your conversation — your messages, Claude's responses, tool outputs, file contents — lives in this window. It has a fixed size measured in tokens (roughly 4 characters = 1 token).

Think of it like a desk:
- **Small desk** = you can only have a few papers out at once
- **Big desk** = you can spread out, cross-reference, hold more in mind

Claude Code currently has a large context window (200K tokens on most plans), but it fills up faster than you'd think.

## What Eats Context?

| Source | Impact | Example |
|--------|--------|---------|
| Reading large files | High | A 2000-line file = ~8K tokens |
| Bash output | High | `npm install` output can be 1000+ lines |
| Long conversations | Medium | Each back-and-forth adds up |
| Tool call results | Medium | Every Grep/Glob result costs tokens |
| Your prompts | Low | Usually small relative to outputs |

## Why It Matters

When context fills up:
1. **Claude loses earlier context** — old messages get compressed or dropped
2. **Quality degrades** — less room to think means worse reasoning
3. **You get weird behavior** — Claude "forgets" what you discussed earlier

## Power User Strategies

### 1. Be specific in file reads
Bad: "Read the entire src directory"
Good: "Read the handleAuth function in src/auth/middleware.ts"

### 2. Use /compact strategically
When conversation gets long, run `/compact` with a focus:
```
/compact keep the database schema and current task
```
This compresses everything except what you specify.

### 3. Break large tasks into sessions
Instead of one marathon session that fills context:
- Session 1: Research and plan
- Session 2: Implement
- Session 3: Test and refine

### 4. Use agents for deep exploration
When you need to search a large codebase, use the Agent tool. Sub-agents get their own context window — they explore without filling yours.

### 5. Watch the context indicator
Claude Code shows context usage. When you're past 50%, start being more conservative. Past 75%, consider starting fresh.

## The 50% Rule

A good rule of thumb: if you're past 50% context and starting new work, it's often better to `/compact` or start a new session than to keep going. Your results will be better with fresh context.

## Deep Dive: How /compact Works

`/compact` is your most important context management tool. Understanding how it works makes you a better power user.

### What It Does

When you run `/compact`, Claude Code:
1. Reads your entire conversation history
2. Summarizes it into a compressed version
3. Replaces the full history with that summary
4. You continue with a clean context window + the summary

It typically saves 60-80% of your context. A conversation using 80% context might drop to 20% after compacting.

### The Focus Prompt

You can tell `/compact` what to prioritize:

```
/compact keep the database schema and the API design decisions
```

```
/compact focus on the authentication flow — drop everything about styling
```

```
/compact keep the error we found and the fix approach
```

Without a focus prompt, `/compact` tries to keep everything important — but "important" is a judgment call. The focus prompt is your way of saying "THIS is what matters."

### What Survives vs. What's Lost

| Survives | Lost |
|----------|------|
| Core decisions and requirements | Verbose explanations |
| File paths and structure | Debugging dead ends |
| Architecture and design choices | Exact error messages |
| Current task context | Intermediate reasoning |
| What you told it to keep | "Nice to know" details |

### Compact Instructions in CLAUDE.md

If there's context that should **always** survive compaction, put it in your CLAUDE.md:

```markdown
## Compact Instructions
- Always preserve: current task, data model, API patterns
- Always preserve: auth flow uses Clerk + Convex integration
- Drop: debugging history, exploration output, file listings
```

This way, even if you forget to add a focus prompt, the critical context is preserved.

### When to Compact

| Situation | Action |
|-----------|--------|
| Finishing subtask A, starting subtask B | `/compact keep findings from A` |
| Past 50% context, new work ahead | `/compact` with focus |
| Long session, quality dropping | `/compact` immediately |
| About to read a large file or codebase | `/compact` first to make room |
| Mid-task, everything is relevant | **Don't compact** — you'll lose the thread |

### When NOT to Compact

- **In the middle of a complex task** — the details you'd lose are the ones you need
- **Right after starting** — nothing to compact yet
- **Short sessions** — not worth it, just finish and start fresh next time

## Example: A Real /compact in Action

Here's what actually happens during a working session. This is from a real session building this curriculum:

### The Situation
We'd been working for a while — exploring files, editing lessons, discussing design decisions, configuring permissions. Context was getting heavy. We wanted to keep going but shift to a new subtask.

### The Command
```
/compact keep: power-user project structure, curriculum decisions, 
Aaron's permission config. Drop: file exploration output, debugging.
```

### What Happened
1. Claude Code read the entire conversation (dozens of exchanges, file reads, tool outputs)
2. Compressed it into a structured summary — key decisions, files modified, current state
3. Replaced the full history with that summary
4. Context dropped from ~75% to ~20%

### What Survived
- The project structure (9 modules, 42 lessons)
- Design decisions ("keep /bootstrap lightweight, graduate to full framework in Module 08")
- File paths we'd been editing
- The permission configuration we'd just set up

### What Was Lost
- The exact output of every file read
- Back-and-forth debugging of setup scripts
- Intermediate reasoning ("should we put this in Module 02 or 03?")
- Verbose tool call results

### The Lesson
The focus prompt is doing the heavy lifting. Without it, Claude Code guesses what's important. With it, you're in control. The things we told it to keep survived cleanly. The things we didn't mention were compressed or dropped.

## Exercise: Context Awareness

This is a hands-on exercise. Do it in Claude Code right now — it takes about 10 minutes and teaches you something you can't learn by reading.

### Part 1: Fill up some context
1. Open Claude Code in any project folder (or create a temp one: `mkdir ~/compact-test && cd ~/compact-test`)
2. Have a real conversation — ask Claude Code to:
   - Explore the project structure
   - Read a few files
   - Explain what it found
   - Suggest an improvement
3. Do 5-6 back-and-forth exchanges. Don't rush — have a real conversation.
4. Ask: **"How much context have we used?"**
5. Note the percentage. (If you have a status line configured, you can see it there too.)

### Part 2: Compact with a focus prompt
6. Think about what you care about from the conversation. Pick one or two things.
7. Run `/compact` with a focus prompt:
   ```
   /compact keep the key findings about project structure
   ```
8. Ask: **"How much context are we using now?"**
9. Compare — you should see a significant drop (typically 60-80% savings).

### Part 3: Test what survived
10. Ask: **"What did we learn about the project structure?"**
    - Claude Code should know — that's what you told it to keep.
11. Now ask about something you DIDN'T tell it to keep — maybe the exact wording of a suggestion, or which specific files it read.
    - It might be fuzzy, summarized, or gone entirely.
12. That gap between "kept" and "lost" — that's the trade-off you're managing.

### Part 4: Compare with no focus
13. Start a **new session** (type `exit`, then `claude`)
14. Have another short conversation (3-4 exchanges)
15. This time, run `/compact` with **no focus prompt** — just `/compact`
16. Ask what it remembers
17. Compare — without a focus prompt, Claude Code decides what's important. Sometimes it guesses right. Sometimes it drops the thing you needed.

### What You Learned
- Context fills up faster than you think (Part 1)
- `/compact` with a focus prompt gives you control over what survives (Part 2)
- The focus prompt is the difference between "I chose what to keep" and "I hope it kept the right stuff" (Part 3 vs Part 4)
- This is a skill you'll use in every long session going forward

## Key Takeaway

Context is your most precious resource. Every file read, every command output, every long response costs tokens. Power users are deliberate about what goes into context and use `/compact` strategically — with focus prompts to keep what matters, Compact Instructions in CLAUDE.md for permanent priorities, and good judgment about when to compress vs. when to keep everything.

---

**Next Module:** [Configuration & CLAUDE.md](../02-configuration/)

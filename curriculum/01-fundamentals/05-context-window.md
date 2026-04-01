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

## Exercise: Context Awareness

### Part 1: See the cost
1. Start a session and ask Claude Code to explore a medium-sized project
2. After several exchanges, ask: "How much context have we used?"
3. Note the percentage

### Part 2: Compact with focus
4. Run `/compact keep the key findings about project structure`
5. Ask: "How much context are we using now?"
6. Compare — you should see a significant drop

### Part 3: Test what survived
7. Ask: "What did we learn about the project structure?"
8. Claude Code should know — that's what you told it to keep
9. Ask about something you DIDN'T tell it to keep — it might be fuzzy or gone

This exercise teaches you what compaction preserves and what it drops. That awareness is how you decide when and how to compact.

## Key Takeaway

Context is your most precious resource. Every file read, every command output, every long response costs tokens. Power users are deliberate about what goes into context and use `/compact` strategically — with focus prompts to keep what matters, Compact Instructions in CLAUDE.md for permanent priorities, and good judgment about when to compress vs. when to keep everything.

---

**Next Module:** [Configuration & CLAUDE.md](../02-configuration/)

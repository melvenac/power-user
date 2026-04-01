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

## Exercise: Context Awareness

1. Start a session and ask Claude Code to explore a medium-sized project
2. After several exchanges, ask: "How much context have we used?"
3. Run `/compact keep the key findings`
4. Notice how much space freed up
5. Continue working — notice if response quality improves

## Key Takeaway

Context is your most precious resource. Every file read, every command output, every long response costs tokens. Power users are deliberate about what goes into context and aggressive about compacting when it gets full.

---

**Next Module:** [Configuration & CLAUDE.md](../02-configuration/)

# Lesson 01: What Is Claude Code?

## The Misconception

Most people think Claude Code is "Claude but in your terminal" — a chatbot that can see your files. That's like saying a car is "a couch with wheels." Technically not wrong, but you're missing everything that makes it useful.

## What It Actually Is

Claude Code is an **agent runtime**. Here's what that means in plain English:

- **Agent** — it can take actions, not just answer questions. It reads files, writes code, runs commands, searches your codebase, and makes decisions about what to do next.
- **Runtime** — it's a full application with its own tool system, memory, permissions, and architecture. It's not just an API wrapper.

Think of it this way:

| What you might think | What it actually is |
|---------------------|-------------------|
| Chatbot in terminal | Agent runtime with 20+ built-in tools |
| Answers questions about code | Reads, writes, searches, runs, and tests code |
| Stateless conversations | Persistent memory across sessions |
| Single-threaded | Can coordinate multiple agents in parallel |
| Just Claude | Claude + tools + permissions + memory + MCP |

## Why This Matters

When you understand that Claude Code is an agent runtime, you stop using it like a search engine and start using it like a teammate:

- Instead of "what does this function do?" → "refactor this function to handle the edge case in issue #42"
- Instead of "write me a function that..." → "add error handling to the payment flow — check the existing patterns first"
- Instead of one massive prompt → break work into pieces and let it decompose the task

## The Architecture (Simplified)

```
┌─────────────────────────────────────┐
│           Claude Code               │
├─────────────────────────────────────┤
│  Tools      │ Read, Write, Edit,    │
│             │ Bash, Grep, Glob,     │
│             │ Agent, Search...      │
├─────────────────────────────────────┤
│  Memory     │ CLAUDE.md, auto-memory│
│             │ session context       │
├─────────────────────────────────────┤
│  Permissions│ Allow/deny/ask per    │
│             │ action type           │
├─────────────────────────────────────┤
│  MCP        │ Connect external tools│
│             │ databases, APIs       │
├─────────────────────────────────────┤
│  Multi-Agent│ Coordinate parallel   │
│             │ work across agents    │
└─────────────────────────────────────┘
```

You don't need to understand all of these yet. We'll cover each one in later modules. For now, just know they exist.

## Exercise: See It In Action

Open Claude Code in any project directory and try these:

```
# Ask it to explore (uses tools: Glob, Grep, Read)
"What's the structure of this project?"

# Ask it to act (uses tools: Edit, Write, Bash)
"Add a .gitignore if there isn't one"

# Ask it to reason about tools
"What tools do you have available?"
```

Watch the tool calls in the output. You'll see it's not just "thinking" — it's **doing**.

## Key Takeaway

Claude Code is a programmable agent that happens to live in your terminal. The faster you stop treating it like a chatbot, the faster you'll become a power user.

---

**Next:** [Installation & First Run](02-installation.md)

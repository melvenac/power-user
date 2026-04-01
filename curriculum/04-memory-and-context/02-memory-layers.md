# Lesson 02: The Memory Layers

## Five Layers, Each With a Job

Claude Code's memory isn't one system — it's five layers working together. Understanding each one helps you know where to put information and where to find it.

## Layer 1: CLAUDE.md (Instructions)

**What it stores:** How to work in this project
**Lifespan:** Permanent until you change it
**Who writes it:** You (or /bootstrap)

```
"Use TypeScript strict mode"
"All tests use vitest"
"Never push directly to main"
```

This is your project constitution. It rarely changes and always loads.

**When to use it:** Conventions, commands, tech stack, team rules — things that are true for the life of the project.

## Layer 2: .agents/ State (Project Memory)

**What it stores:** Where the project is right now
**Lifespan:** Updated every session
**Who writes it:** Claude Code (via /end) + you

```
SUMMARY.md  → "Auth module complete, working on payments"
INBOX.md    → "[ ] Add Stripe integration"
ENTITIES.md → "User, Order, Payment models"
```

This is your project's working memory. It changes frequently and keeps Claude Code oriented.

**When to use it:** Project status, task tracking, data models, session handoffs.

## Layer 3: Auto-Memory (Learned Preferences)

**What it stores:** Things Claude Code learned about you
**Lifespan:** Persists until outdated
**Who writes it:** Claude Code automatically

These live in `.claude/memory/` or `~/.claude/projects/<project>/memory/`:

```
user_aaron.md     → "Senior developer, prefers concise responses"
feedback_testing.md → "Always run tests after code changes"
project_notes.md  → "API redesign driven by compliance, not tech debt"
```

Claude Code saves these when it learns something worth remembering. You can also explicitly say "remember that we decided to use Stripe for payments" and it'll create a memory file.

**When to use it:** Personal preferences, team context, decisions that aren't in the code.

### Memory Types

| Type | What | Example |
|------|------|---------|
| **user** | About you | "Aaron is a senior dev, prefers directness" |
| **feedback** | How to work | "Don't add trailing summaries" |
| **project** | Project context | "Merge freeze starts March 5" |
| **reference** | Where to find things | "Bugs tracked in Linear project INGEST" |

## Layer 4: Knowledge Base (Experiences)

**What it stores:** Past experiences, patterns, and skills
**Lifespan:** Long-term, with feedback-driven pruning
**Who writes it:** Accumulated automatically via session hooks

This is the most sophisticated layer. It uses an MCP server (like Open Brain) to store:

- **Experiences:** "When we added Stripe, we had to lazy-init the client because Convex actions re-run"
- **Skills:** "Pattern for adding a new API endpoint with auth middleware"
- **Session summaries:** Compressed records of past work sessions

When you start a session, `/start` recalls relevant experiences based on what you're working on today.

**When to use it:** Pattern recognition, avoiding past mistakes, building on past solutions.

### The Feedback Loop

Knowledge entries have a maturity lifecycle:

```
New → Progenitor (just created)
    → Proven (recalled 3+ times, helpful)
    → Mature (recalled 7+ times, consistently helpful)
    → Pruned (below 0.3 success rate after 5 ratings)
```

Good knowledge rises to the top. Bad knowledge gets cleaned out. The system improves itself.

## Layer 5: Session Context (Working Memory)

**What it stores:** Everything in the current conversation
**Lifespan:** This session only
**Who writes it:** Automatic (your messages + tool outputs)

This is the context window from Module 01, Lesson 05. It's the most immediate but most ephemeral layer.

## How They Work Together

```
/start triggers:
  Layer 1: CLAUDE.md loads automatically (instructions)
  Layer 2: .agents/ files read (project state)
  Layer 3: Auto-memory loaded (preferences)
  Layer 4: Knowledge recalled (relevant experiences)
  Layer 5: All of the above enters session context

During work:
  Layer 5: Grows as you work (tool outputs, decisions)
  Layer 3: New preferences saved as learned
  Layer 2: Tasks updated as completed

/end triggers:
  Layer 2: SUMMARY.md and INBOX.md updated
  Layer 4: Session indexed for future recall
  Layer 5: Gone (but persisted in Layers 2 and 4)
```

## Exercise: Audit Your Memory

1. **Check Layer 1:** `"Read our CLAUDE.md — is it up to date?"`
2. **Check Layer 2:** `"Read .agents/SUMMARY.md — is this accurate?"`
3. **Check Layer 3:** `"What memory files exist in .claude/memory?"`
4. **Check Layer 4:** If you have a knowledge MCP: `"Recall knowledge related to this project"`
5. **Fix anything stale:** Update whatever's outdated

Stale memory is worse than no memory — it leads Claude Code astray.

## Key Takeaway

Memory isn't one thing — it's five layers from permanent instructions to ephemeral context. Each layer has its own lifespan and purpose. Together, they give Claude Code continuity that survives across sessions, projects, and even machines.

---

**Next:** [Context Management](03-context-management.md)

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

## Real-World Example: Aaron's Memory in Action

Here's what a real memory system looks like after months of use. This is from the `power-user` project you're reading right now.

**Layer 1 (CLAUDE.md):**
```markdown
## Conventions
- Lessons are markdown with embedded exercise blocks
- Keep language accessible — this is for people learning, not experts
- Explain the *why* behind every recommendation
```
Loaded every session. Never changes unless the project changes.

**Layer 2 (.agents/ state):**
```markdown
# SUMMARY.md
Public v1.0.0 — full curriculum complete. Iterating on exercises and real-user feedback.
```
Updated every `/end`. Tells the next session where things stand.

**Layer 3 (Auto-memory):**
```markdown
# user_aaron.md
Aaron — owner of Tarrant County Makerspace, prefers concise responses,
deep Go experience, new to React frontend work.

# feedback_testing.md
Always run tests after code changes. Don't add trailing summaries.

# project_power_user.md
/bootstrap stays lightweight. Full framework graduates in Module 08.
```
These were saved when Claude Code learned something worth remembering. Some were explicit ("remember that we decided..."), some were automatic.

**Layer 4 (Knowledge base):**
Previous sessions indexed — "when we built the setup scripts, winget worked better than chocolatey on Windows", "VS Code orientation lesson came from Bill and Brian's real confusion navigating the IDE."

**Layer 5 (Session context):**
Right now — this conversation, the files we've read, the edits we've made. Gone when the session ends, but the important parts flow into Layers 2-4.

## Exercise: Audit Your Memory Layers

This exercise takes you through each layer of your own memory system. Do it in a real project — the power-user repo works fine.

### Part 1: Check each layer
Run these one at a time and note what you find:

1. **Layer 1:** `"Read our CLAUDE.md — is it up to date?"`
2. **Layer 2:** `"Read .agents/SYSTEM/SUMMARY.md — is this accurate?"`
3. **Layer 3:** `"What memory files exist in .claude/memory/ or ~/.claude/projects/*/memory/?"`
4. **Layer 4 (if you have a knowledge MCP):** `"Recall knowledge related to this project"`
5. **Layer 5:** `"How much context have we used in this session?"`

### Part 2: Find stale memory
Ask Claude Code:
```
"Read all my memory files for this project. Flag anything that's 
outdated or no longer accurate."
```
Stale memory is worse than no memory — it leads Claude Code astray. Fix or delete anything outdated.

### Part 3: Write a new memory
Tell Claude Code something worth remembering:
```
"Remember that I prefer [your preference here]"
```
Then check: `"What memory files exist now?"` — you should see a new one.

Start a **new session** and ask:
```
"What do you know about my preferences?"
```
If it recalls what you told it — the memory system is working. If not, check that the memory file was saved to the right location.

### Part 4: See the layers merge
Ask:
```
"What instructions and context are you working with right now? 
Show me what came from CLAUDE.md vs memory vs the current session."
```
This shows you the full picture — all five layers merged into one working context.

## Key Takeaway

Memory isn't one thing — it's five layers from permanent instructions to ephemeral context. Each layer has its own lifespan and purpose. Together, they give Claude Code continuity that survives across sessions, projects, and even machines.

---

**Next:** [Context Management](03-context-management.md)

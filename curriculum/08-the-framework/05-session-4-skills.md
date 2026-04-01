# Lesson 05: Session 4 — Skills & Continuous Improvement

## The Framework Starts Working For You

Sessions 1-3 were about setting up the framework and learning the workflow. Session 4 is where the self-improving part kicks in — knowledge accumulates, skills emerge, and the system starts compounding.

## Step 1: /start (Notice the Difference)

```
/start
```

Compare this /start to Session 1. Notice:
- **SUMMARY.md** has real history now — three sessions of progress
- **INBOX.md** has completed tasks and remaining priorities
- **Knowledge recall** may surface experiences from your previous sessions
- **Session handoff** from Session 3 tells you exactly where to pick up

The framework is doing its job. Each /start gets richer.

## Step 2: Review What's Accumulated

Before diving into work, take stock:

```
"Let's do a framework health check:
1. Read SUMMARY.md — is it accurate?
2. Read INBOX.md — are priorities still right?
3. Read ENTITIES.md — does it match the actual code?
4. Read DECISIONS.md — are we missing any decisions?
5. Check .agents/skills/ — do we have any skills yet?"
```

Fix anything that's drifted. This maintenance takes 5 minutes and prevents compounding errors.

## Step 3: Identify Skill Candidates

By Session 4, you've likely repeated some patterns. Think about:

- **Did you explain the same thing to Claude Code more than once?** → Skill candidate
- **Did you correct the same mistake?** → Skill candidate
- **Is there a multi-step workflow you do regularly?** → Skill candidate
- **Does your tech stack have gotchas you keep hitting?** → Skill candidate

Ask Claude Code:
```
"Based on our four sessions, what patterns have we repeated 
that would make good skills?"
```

## Step 4: Create Your First Project Skill

Pick the most impactful pattern and formalize it:

```
"Create a skill for [pattern]. Put it in .agents/skills/[name]/SKILL.md.
Include:
- When to apply this skill
- The pattern to follow
- Common mistakes to avoid
- A concrete example"
```

### Example: A Database Schema Skill

If you keep working with your data model:

```markdown
# Skill: Schema Changes

## When to Apply
When modifying the database schema, adding new entities, 
or changing field types.

## Pattern
1. Update the schema in code first
2. Immediately update ENTITIES.md to match
3. Run validation to confirm they're in sync
4. If adding a new entity, update the PRD data model section
5. Log the change in DECISIONS.md if it's a significant design choice

## Common Mistakes
- Changing schema without updating ENTITIES.md (causes drift)
- Adding nullable fields when they should be required
- Forgetting to update related entities when adding relationships

## Example
Adding a "projects" table:
1. Add to schema: projects with id, name, owner_id, created_at
2. Add to ENTITIES.md: Projects entity with fields and relationships
3. Add to DECISIONS.md: "DEC-005: Projects belong to users (1:many)"
```

### Update the Skills Index

```
"Add our new skill to .agents/skills/INDEX.md"
```

## Step 5: The Knowledge Feedback Loop

If you have a knowledge MCP (Open Brain), check what's been stored:

```
"Recall any knowledge stored from our previous sessions on this project"
```

For each recalled entry, ask yourself:
- **Was this helpful?** → The system promotes it
- **Was this wrong or outdated?** → Flag it for removal
- **Is it missing important context?** → Update it

This feedback loop is what makes the knowledge base self-improving. Good knowledge rises, bad knowledge falls.

## Step 6: The Anti-Patterns Check

Four sessions in, check for framework anti-patterns:

| Anti-Pattern | Check | Fix |
|---|---|---|
| SUMMARY.md is getting long | Is it over 50 lines? | Archive old milestones, keep it focused on NOW |
| INBOX.md has stale tasks | Any tasks that will never get done? | Remove or move to a "someday" section |
| DECISIONS.md is empty | Did you make decisions but not log them? | Backfill the important ones |
| No skills created | Have you repeated patterns? | Create at least one skill |
| Skipping /end | Did you ever just close the terminal? | Commit to always running /end |

## Step 7: Build a Feature Using Your Skill

Now test the skill in practice:

1. Pick a task that triggers the skill you just created
2. Work on it normally
3. Watch — does Claude Code apply the skill automatically?
4. If not, reference it: "Use our [skill-name] skill for this"

The skill should make the work smoother. If it doesn't, refine it.

## Step 8: /end with Reflection

```
/end
```

After /end completes, reflect:

### The Four-Session Retrospective

Ask yourself:
1. **What's faster now than Session 1?** (context loading, task orientation)
2. **What knowledge has accumulated?** (SUMMARY, skills, experiences)
3. **What patterns have emerged?** (skills you've created or should create)
4. **What friction remains?** (things that still feel manual or slow)

That remaining friction is your roadmap. Each piece can become:
- A command (if it's a workflow)
- A skill (if it's a knowledge pattern)
- A hook (if it should happen automatically)
- An MCP server (if it's an external integration)

## The Compound Curve

```
Session 1:  Setup overhead, minimal productivity gain
Session 2:  First continuity benefit (no re-explaining)
Session 3:  Testing adds quality layer
Session 4:  Skills emerge, knowledge compounds
Session 10: Framework is deeply customized to your project
Session 20: Claude Code is genuinely expert in your codebase
```

You're at Session 4. The hardest part is behind you. From here, the framework gets more valuable with every session — not because you're doing extra work, but because the work you're already doing accumulates.

## What's Next

You've completed the guided sessions. From here:
- **Keep using the cycle:** `/start → work → /sync → /end`
- **Create skills as patterns emerge** — don't force it
- **Review your framework monthly** — prune stale docs, update priorities
- **Share with others** — the framework is portable. Help Brian, Bill, or Sam set it up

## Congratulations

You've gone from "what is Claude Code?" to running a self-improving agent framework with persistent memory, automated testing, accumulated skills, and a feedback loop that makes it better every session.

That's not just power user territory. That's building a system that works for you.

Now go build something great.

---

**Back to:** [Module 08 Overview](README.md) | [Full Curriculum](../README.md)

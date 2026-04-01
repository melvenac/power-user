# Lesson 04: Building Your Automation Layer

## The System, Not the Parts

You've now learned three types of automation:
- **Commands** — workflows you trigger manually
- **Hooks** — scripts that run on events
- **Skills** — knowledge applied automatically

Individually, each one saves time. Together, they form an automation layer that transforms how you work.

## The Automation Stack

```
Layer 4: Skills          ← Domain knowledge, auto-applied
Layer 3: Commands        ← Repeatable workflows, on-demand
Layer 2: Hooks           ← Event-driven guardrails and context
Layer 1: CLAUDE.md       ← Foundation instructions
Layer 0: Claude Code     ← The runtime
```

Each layer builds on the one below. CLAUDE.md sets the rules. Hooks enforce them. Commands encode workflows. Skills add expertise.

## A Real Automation Setup

Here's what a mature Claude Code automation layer looks like:

### CLAUDE.md (Foundation)
```
Tech stack, conventions, commands, structure
```

### Hooks (Automatic)
```json
{
  "SessionStart": ["node scripts/load-context.js"],
  "SessionEnd": ["node scripts/save-session.js"],
  "PreToolUse": ["node scripts/safety-guard.js"]
}
```
- Session start loads project state and relevant knowledge
- Session end saves learnings and updates project state
- Safety guard prevents dangerous operations

### Commands (On-Demand)
```
/start     → Load project state, recall knowledge
/end       → Save state, index session
/status    → Project overview
/ship      → Pre-deploy checklist
/bootstrap → Set up a new project
```

### Skills (Auto-Applied)
```
convex-patterns.md  → Applied when working on Convex code
error-handling.md   → Applied when writing API handlers
git-workflow.md     → Applied when committing/branching
testing-patterns.md → Applied when writing tests
```

## Building Your Layer Incrementally

Don't try to build all of this in a week. Build it like this:

### Week 1: Foundation
- Write a good CLAUDE.md
- Run `/bootstrap` to set up .agents/
- Use `/start` and `/end`

### Week 2-3: Commands
- Notice workflows you repeat
- Turn the top 3 into commands
- Test and refine

### Month 1: Hooks
- Add session start/end hooks for automatic context
- Add a safety guard for dangerous operations
- Add logging for audit trail

### Month 2+: Skills
- Notice patterns in your corrections
- Write skills for the most common ones
- Build the feedback loop

## The Compound Effect

Each automation investment pays dividends:

```
Week 1:  Save 5 minutes/day (CLAUDE.md + /start)
Week 3:  Save 15 minutes/day (+ commands)
Month 1: Save 30 minutes/day (+ hooks)
Month 2: Save 45+ minutes/day (+ skills)
```

And it's not just time. The quality improves too — skills prevent mistakes, hooks enforce standards, and commands ensure consistency.

## Sharing With Your Team

This is where it gets powerful for teams:

### What to commit to git (shared)
- `.claude/CLAUDE.md` — project instructions
- `.claude/commands/` — project workflows
- `.claude/skills/` — project knowledge
- `.agents/` — project state

### What stays personal (gitignored)
- `.claude/CLAUDE.local.md` — your overrides
- `~/.claude/` — your global setup

When a new team member clones the repo, they get the project's automation layer for free. They don't need to build it from scratch.

## Exercise: Map Your Automation

Draw your current automation layer:

1. **What do you have?** (CLAUDE.md, commands, hooks, skills)
2. **What are you repeating?** (workflows you do manually more than twice)
3. **What are you correcting?** (things you tell Claude Code repeatedly)
4. **What should happen automatically?** (context loading, safety checks, logging)

Pick the top item from list 2 and turn it into a command. Pick the top item from list 3 and turn it into a skill. That's your next step.

## Key Takeaway

The automation layer isn't a destination — it's a practice. Start small, build incrementally, and let your daily friction guide what to automate next. In three months, your Claude Code setup will be unrecognizably more productive than where you started.

---

**Next Module:** [Building Your Stack](../07-building-your-stack/)

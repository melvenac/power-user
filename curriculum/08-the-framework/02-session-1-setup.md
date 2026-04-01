# Lesson 02: Session 1 — Setup & PRD

## This Is a Guided Session

This lesson isn't something you read — it's something you **do**. Set aside 45-60 minutes and follow along with Claude Code open.

## Step 1: Create Your Project

```bash
mkdir ~/Projects/my-project
cd ~/Projects/my-project
```

Replace `my-project` with your actual project name.

## Step 2: Bootstrap

Open Claude Code in this directory and run:

```
/bootstrap
```

Watch what happens:
- Claude Code scans for existing files (finds nothing — it's empty)
- Generates a CLAUDE.md
- Scaffolds the `.agents/` framework
- Asks about git initialization

**Review the generated CLAUDE.md.** Is it accurate? If not, tell Claude Code what to fix. This file is the foundation — get it right.

## Step 3: Write Your PRD

This is the most important step. The PRD drives everything else.

Tell Claude Code:

```
"Let's write the PRD for this project. I'll describe what I'm building 
and you'll help me structure it into .agents/SYSTEM/PRD.md"
```

Then describe your project. Claude Code will ask clarifying questions and help you structure it. The PRD should cover:

1. **What are we building?** (one paragraph)
2. **Who is it for?** (target users)
3. **Core features** (numbered list — be specific)
4. **Tech stack** (what you're building with and why)
5. **User roles** (who uses it and what can they do)
6. **Pages/Routes** (if it's a web app)
7. **Data model** (main entities and their relationships)
8. **Third-party integrations** (external services)

### PRD Tips

- **Be specific about features.** "User management" is vague. "Users can sign up, log in, reset passwords, and update their profile" is actionable.
- **Include the why.** "We use Convex because we need real-time data for the dashboard" helps future sessions make consistent choices.
- **Don't over-plan.** The PRD is a starting point, not a contract. It'll evolve.

## Step 4: Derive the SYSTEM Documents

Once the PRD is written, derive the other documents from it:

```
"Now let's create the SYSTEM documents from the PRD:
1. ENTITIES.md from the data model section
2. RULES.md from the tech stack — what are our coding conventions?
3. SUMMARY.md — initial project state
4. Empty DECISIONS.md for future architectural decisions
5. INBOX.md — initial task backlog from the core features"
```

Claude Code will create all five. Review each one:

- **ENTITIES.md** — does the data model match your vision?
- **RULES.md** — are these conventions you'd actually follow?
- **SUMMARY.md** — does it accurately describe "just bootstrapped"?
- **INBOX.md** — are the tasks in the right priority order?

## Step 5: Set Up Path Rules

```
"Create .claude/rules/ files for this project:
- frontend.md with our frontend conventions
- backend.md with our backend conventions  
- database.md with our database conventions
- testing.md with our testing approach
- agents.md with the framework rules"
```

These are the context-efficient guardrails from Module 02. They load automatically when Claude Code reads matching files.

## Step 6: Run /start

Now experience the framework for the first time:

```
/start
```

Claude Code will:
- Read your SUMMARY.md
- Read your INBOX.md
- Create Session 1 log
- Present the project state and propose an objective

**This is the moment.** See how it reads your documents, understands the state, and suggests what to work on? That's the framework in action.

## Step 7: Do a Small Piece of Work

Don't try to build the whole project. Pick the smallest useful task from INBOX.md:

```
"Let's work on [the first task]. Keep it simple — 
I want to test the framework workflow, not ship a feature."
```

Work for 15-20 minutes. Just enough to have something to save.

## Step 8: Run /end

```
/end
```

Watch what happens:
- Session log gets filled in (what you did, decisions, gotchas)
- SUMMARY.md updates (new current state)
- INBOX.md updates (task checked off)
- Handoff notes written for next session

**Read the handoff notes.** This is what the next session will see. Is it accurate? Does it capture the important context?

## Step 9: Verify Continuity

Close Claude Code. Reopen it. Run:

```
/start
```

Claude Code should:
- Know what you did in Session 1
- Know what's next
- Pick up right where you left off

**That's the framework working.** Session 1 built the foundation. Session 2 will build on it.

## What You Should Have Now

```
my-project/
├── .agents/
│   ├── FRAMEWORK.md
│   ├── SYSTEM/
│   │   ├── PRD.md            ✓ Written
│   │   ├── SUMMARY.md        ✓ Updated by /end
│   │   ├── ENTITIES.md       ✓ Derived from PRD
│   │   ├── DECISIONS.md      ✓ Created (may be empty)
│   │   └── RULES.md          ✓ Tech-stack conventions
│   ├── TASKS/
│   │   ├── INBOX.md          ✓ Features from PRD
│   │   └── task.md           ✓ Current focus
│   └── SESSIONS/
│       └── Session_1.md      ✓ First session log
├── .claude/
│   ├── commands/             ✓ Framework commands
│   └── rules/                ✓ Path-specific rules
├── CLAUDE.md                 ✓ Project instructions
└── [your initial code]       ✓ Whatever you built
```

## Reflection

Before moving on, ask yourself:
- How did it feel to have Claude Code understand the project state?
- Was the /start → work → /end flow natural?
- What would you change about the PRD?

## Key Takeaway

Session 1 is the most setup — PRD, SYSTEM docs, rules. After this, every session is just `/start → work → /end`. The investment pays off starting Session 2.

---

**Next:** [Session 2: Your First Dev Cycle](03-session-2-dev-cycle.md)

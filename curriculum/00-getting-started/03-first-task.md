# Lesson 03: Your First Real Task

## Stop Asking Questions, Start Giving Tasks

The single biggest shift from chatbot thinking to agent thinking:

- **Chatbot:** "Can you explain how to add a .gitignore?"
- **Agent:** "Add a .gitignore for a Node.js project"

Claude Code doesn't just explain — it **does**. Let it.

## A Real Example

Let's say you have a new project folder with some code but no documentation. Here's how a power user would approach it:

### Beginner approach (works, but slow)
```
"What should I put in a README?"
"Can you write a README for this project?"
"Actually, can you also add a license?"
"And a .gitignore?"
```

Four prompts. Four wait cycles.

### Power user approach (one prompt)
```
"Set up this project: add a README based on the code you find, 
a MIT license, and a .gitignore for Node.js. 
Initialize git and make an initial commit."
```

One prompt. Claude Code reads the codebase, creates the files, initializes git, and commits. Done.

## The Pattern: Context → Action → Scope

Good prompts follow this pattern:

1. **Context** — what's the situation (often implicit from the project)
2. **Action** — what you want done
3. **Scope** — how far should it go

Examples:

| Prompt | Context | Action | Scope |
|--------|---------|--------|-------|
| "Fix the failing test in auth.test.ts" | auth tests | fix | single file |
| "Add input validation to all API routes" | API layer | add validation | all routes |
| "Refactor the database queries to use the new ORM" | DB layer | refactor | all queries |

## What To Watch For

As Claude Code works, pay attention to:

1. **Tool calls** — you'll see it using Read, Edit, Grep, Bash, etc. This shows you it's actually working, not just generating text.
2. **Decisions** — it will sometimes tell you about choices it's making. This is where you can redirect.
3. **Permission prompts** — it will ask before doing anything risky (deleting files, running commands). This is the permission engine at work.

## Exercise: Ship Something

Pick one of these based on what you have available:

### Option A: You have a project with code
```
"Review this project's structure and suggest 3 improvements. 
Then implement the easiest one."
```

### Option B: Fresh start
```
"Create a simple Express API with one endpoint that returns 
the current time. Include a README, .gitignore, and package.json. 
Initialize git."
```

### Option C: Fix something real
```
"Find any TODO or FIXME comments in this project and list them. 
Pick one and fix it."
```

### What to observe:
- How many tools did it use?
- Did it ask permission for anything?
- Did it make any decisions you wouldn't have made?
- How long did the whole thing take vs. doing it manually?

## The Trust Gradient

You'll develop trust with Claude Code over time:

1. **Supervised** — read every tool call, approve every action (you are here)
2. **Guided** — give direction, spot-check results
3. **Autonomous** — set permissions, let it work, review the output

There's no rush to get to level 3. Level 1 is where you learn the most about how the tool works.

## Key Takeaway

Claude Code is most powerful when you give it **tasks**, not **questions**. Be specific about what you want, let it figure out the how, and watch what it does. That observation is how you learn to direct it better next time.

---

**Next Module:** [Fundamentals](../01-fundamentals/)

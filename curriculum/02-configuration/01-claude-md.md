# Lesson 01: CLAUDE.md — Your Project's Brain

## The Most Important File You'll Create

If you only take one thing from this entire curriculum, let it be this: **write a good CLAUDE.md.**

Every time Claude Code starts a session, it reads `CLAUDE.md`. It's the first thing loaded into context. It shapes every decision Claude makes for the rest of the session.

## What Goes In CLAUDE.md

Think of it as a briefing document for a new team member on day one. Not the entire company handbook — just the stuff they need to be productive immediately.

### The Template

```markdown
# [Project Name] — Project Instructions

## About
[One line: what this project is]

## Tech Stack
[What you're building with — languages, frameworks, key dependencies]

## Commands
- Build: `npm run build`
- Test: `npm test`
- Dev: `npm run dev`
- Lint: `npm run lint`

## Conventions
- [Decision rules, not descriptions]
- [e.g., "Use TypeScript strict mode. Always."]
- [e.g., "Tests go next to source files, not in a separate folder"]
- [e.g., "Use pnpm, not npm"]

## Structure
- `src/` — Application code
- `src/api/` — API routes
- `src/components/` — React components
- `tests/` — Test files
```

### What Makes It Good

| Do | Don't |
|----|-------|
| Decision rules: "Use pnpm, not npm" | History: "We switched from npm in March" |
| Constraints: "Never modify DB schema without migrations" | Explanations: "Migrations are important because..." |
| Commands: `npm test` | Tutorials: "To run tests, open the terminal and..." |
| Short, opinionated statements | Long paragraphs |

The goal is **operational**, not **educational**. Claude Code doesn't need to understand *why* you chose TypeScript — it needs to know *to use TypeScript*.

## Layers of CLAUDE.md

Claude Code reads multiple CLAUDE.md files, merged in priority order:

```
~/.claude/CLAUDE.md              ← Global (all projects)
~/Projects/my-app/CLAUDE.md      ← Project (shared with team, committed to git)
~/Projects/my-app/CLAUDE.local.md ← Personal (gitignored, your overrides)
```

### Global (~/.claude/CLAUDE.md)
Things true across all your work:
- Your identity preferences ("My name is Aaron, call me by name")
- Universal conventions ("Always use conventional commits")
- Tool preferences ("Use gh for GitHub operations")

### Project (CLAUDE.md in repo root)
Things specific to this project, shared with the team:
- Tech stack and commands
- Coding conventions
- Project structure

### Personal (CLAUDE.local.md)
Your personal overrides for this project:
- Your specific dev environment quirks
- Personal preferences that differ from team conventions

## Exercise: Write Your First CLAUDE.md

### Part 1: Audit what you have
If you used `/bootstrap` in Module 00, you already have one. Let's see how good it is.

Ask Claude Code:
```
"Read our CLAUDE.md and tell me: what would a new developer 
need to know that's NOT in here?"
```
Claude Code will read the file and identify gaps. Make note of what's missing.

### Part 2: The 5-question test
A good CLAUDE.md answers these questions without reading any other file. Ask each one:

1. `"What tech stack does this project use?"`
2. `"How do I run the dev server?"`
3. `"How do I run tests?"`
4. `"What are the coding conventions?"`
5. `"What's the project structure?"`

Score: if Claude Code answers all 5 correctly from the CLAUDE.md alone, it's solid. If it has to read other files or guess, the CLAUDE.md needs work.

### Part 3: Improve it
Add what's missing. Three rules:
- **Add conventions:** Think of 3 rules you'd tell a new team member on day one
- **Add commands:** Make sure build, test, dev, and lint are all listed
- **Cut the fluff:** Remove anything that's obvious from the code itself

Tell Claude Code:
```
"Update our CLAUDE.md with: [your conventions]. 
Keep it under 30 lines — short and opinionated."
```

### Part 4: The before/after test
Run the 5-question test again. Compare the answers. Better? That improvement applies to every future session — Claude Code reads this file first, every time.

### Part 5 (Bonus): Try all three layers
If you want to see the layer system in action:
1. Check your global CLAUDE.md: `"Read ~/.claude/CLAUDE.md"`
2. Check your project CLAUDE.md: `"Read CLAUDE.md"`
3. Ask: `"What instructions are you working with right now?"`

Claude Code will show you the merged result — global + project + personal, all combined.

## Real-World Example

Here's a simplified version of a CLAUDE.md from a production project:

```markdown
# Tarrant County Makerspace — Project Instructions

## About
Community makerspace website — member management, equipment booking, events.

## Tech Stack
Next.js 14 (App Router), Convex (backend + database), Bun (runtime), 
Tailwind CSS, shadcn/ui, deployed on Vercel.

## Commands
- Dev: `bun run dev` (starts Next.js + Convex)
- Build: `bun run build`
- Test: `bun test`
- DB: `npx convex dev` (Convex dev server)

## Conventions
- Use Convex for all data — no other database
- Server components by default, 'use client' only when needed
- Use shadcn/ui components, don't build custom UI primitives
- All API logic in Convex functions (queries/mutations/actions)
- Use Bun, not npm or pnpm
```

Notice: no history, no explanations, just rules and facts. 30 seconds to read. That's the goal.

## Key Takeaway

CLAUDE.md is the highest-leverage input in Claude Code. Keep it short, opinionated, and operational. Every minute you spend writing good CLAUDE.md saves hours of re-explaining context across sessions.

---

**Next:** [Settings & Permissions](02-settings-permissions.md)

# Lesson 01: Choosing a Stack for AI-Assisted Dev

## The Stack Question

"What tech stack should I use?" is the most common question from new developers. The honest answer: it depends on what you're building. But there are principles that help you choose well — especially when AI is part of your workflow.

## Principles for Stack Selection

### 1. Choose What Claude Code Knows Well

Claude Code's training data includes massive amounts of code. Some technologies are better represented than others:

**Well-represented (Claude Code excels):**
- JavaScript / TypeScript
- Python
- React, Next.js, Vue
- Node.js, Express, Fastify
- PostgreSQL, SQLite, MongoDB
- Common frameworks and libraries

**Less represented (Claude Code can help but may need more guidance):**
- Niche languages or frameworks
- Very new tools (released after training cutoff)
- Internal/proprietary tools

This doesn't mean you can't use niche tools — it means you'll write more CLAUDE.md and skills to fill the knowledge gap.

### 2. Choose Declarative Over Imperative

AI assistants work better with declarative patterns:

```
Declarative: "Here's what I want" → AI figures out how
Imperative:  "Do step 1, then step 2, then..." → AI follows steps
```

Frameworks that let you describe *what* rather than *how* give Claude Code more room to be useful:
- **React** (declarative UI) > manual DOM manipulation
- **ORMs / query builders** > raw SQL strings
- **Convex / Firebase** (declarative backend) > custom server setup
- **Tailwind** (utility classes) > custom CSS from scratch

### 3. Choose Type-Safe

TypeScript > JavaScript for AI-assisted work. Why?

- Types give Claude Code more context about your code's intent
- Errors are caught at compile time, not runtime
- Autocomplete and tooling are better
- Claude Code can infer what functions expect and return

The investment in TypeScript pays for itself in AI-assisted development.

### 4. Choose Convention Over Configuration

Frameworks with strong opinions reduce decision fatigue for both you and Claude Code:

- **Next.js** (file-based routing, conventions) > custom Express + React setup
- **Convex** (schema-driven, typed queries) > custom REST + ORM
- **Bun** (built-in test runner, bundler) > piecing together separate tools

When the framework has conventions, Claude Code follows them automatically. When everything is custom, you need more CLAUDE.md to explain your patterns.

### 5. Choose Integrated Over Assembled

A cohesive stack beats a collection of "best-in-class" individual tools:

```
Integrated: Next.js + Convex + Vercel
  → Everything works together out of the box
  → One set of conventions to learn
  → Claude Code understands the connections

Assembled: React + Express + PostgreSQL + Prisma + Redis + Docker
  → Each piece is great individually
  → Glue code everywhere
  → More surface area for bugs
  → More CLAUDE.md needed to explain interactions
```

## The Decision Framework

Ask these questions:

1. **What am I building?** (web app, CLI tool, API, mobile, etc.)
2. **What do I already know?** (leverage existing skills)
3. **How well does Claude Code support it?** (check by trying)
4. **Does it have strong conventions?** (less config = more productivity)
5. **Is it type-safe?** (TypeScript or equivalent)

## Web Development → Next.js + Convex (Aaron's recommendation)
## CLI / Local Work → Python or Bun
## Mobile → React Native or Flutter
## API-Only → Fastify or Hono on Bun

These aren't the only options — they're starting points based on the principles above.

## Exercise: Evaluate Your Current Stack

If you have an existing project:
1. Score it on the 5 principles (1-5 each)
2. Where does it lose points?
3. Could you improve those areas without switching stacks? (e.g., add TypeScript to a JS project)

If you're starting fresh:
1. What are you building?
2. Apply the decision framework
3. Pick a stack and explain *why* to Claude Code — this becomes your CLAUDE.md

## Key Takeaway

The best stack for AI-assisted development is type-safe, declarative, convention-driven, and well-integrated. You don't have to use Aaron's stack — but whatever you choose, optimize for how well Claude Code can work with it.

---

**Next:** [Aaron's Stack: The Full Walkthrough](02-aarons-stack.md)

# Lesson 03: Other Paths

## Your Stack, Your Choice

Aaron's stack is optimized for web applications with real-time data. But that's one path. Here are other valid paths depending on what you're building.

## Path: Python CLI / Automation

**Best for:** Scripting, data processing, automation, machine learning, backend services

| Layer | Choice | Why |
|-------|--------|-----|
| Language | Python 3.12+ | Most versatile language, massive ecosystem |
| Package Manager | uv or pip | uv is fast, pip is universal |
| CLI Framework | Click or Typer | Typer for type-safe, Click for flexibility |
| Testing | pytest | Industry standard |
| Type Checking | mypy or pyright | Add type safety to Python |

**CLAUDE.md for Python projects:**
```markdown
## Tech Stack
Python 3.12, uv for packages, pytest for tests, 
mypy for type checking.

## Commands
- Run: `python main.py`
- Test: `pytest`
- Lint: `ruff check .`
- Type check: `mypy .`

## Conventions
- Type hints on all function signatures
- Tests in tests/ directory, mirroring src/ structure
- Use pathlib for file paths, not os.path
- Use dataclasses or pydantic for data models
```

**Claude Code works great with Python** — it's one of the most well-represented languages in training data.

## Path: Full-Stack with PostgreSQL

**Best for:** Applications needing relational data, complex queries, or self-hosted infrastructure

| Layer | Choice | Why |
|-------|--------|-----|
| Frontend | Next.js or SvelteKit | Both excellent, Claude Code knows both |
| Backend | Fastify or Hono | Lightweight, fast, TypeScript-native |
| Database | PostgreSQL | Rock-solid, full SQL power |
| ORM | Drizzle or Prisma | Drizzle for SQL-close, Prisma for ease |
| Deployment | Docker + VPS or Railway | Full control or managed |

**Trade-off vs. Convex:**
- More control and flexibility
- More infrastructure to manage
- No built-in real-time (need WebSockets separately)
- More CLAUDE.md needed (more moving parts)

## Path: Static Sites / Content

**Best for:** Blogs, documentation, marketing sites, portfolios

| Layer | Choice | Why |
|-------|--------|-----|
| Framework | Astro or Next.js | Astro for content-heavy, Next.js for interactive |
| Content | MDX or Markdown | Write content as code |
| Styling | Tailwind | Same as the web path |
| Deployment | Vercel or Netlify | Free tier for most use cases |

**Claude Code excels here** — generating content, styling, and components is its sweet spot.

## Path: Mobile

**Best for:** iOS/Android apps

| Layer | Choice | Why |
|-------|--------|-----|
| Framework | React Native + Expo | JavaScript devs → mobile, largest ecosystem |
| Alternative | Flutter | Better performance, Dart language |
| Backend | Convex or Supabase | Real-time, auth, serverless |

**Note:** Mobile development with Claude Code works, but you'll need device/simulator access to test. Claude Code can write the code but can't see the screen.

## Path: API / Microservices

**Best for:** Backend services, webhooks, integrations

| Layer | Choice | Why |
|-------|--------|-----|
| Runtime | Bun or Node.js | Bun for speed, Node for compatibility |
| Framework | Hono | Ultra-lightweight, works everywhere |
| Validation | Zod | Schema validation, TypeScript-native |
| Deployment | Docker | Portable, reproducible |

## Choosing Your Path

The decision tree:

```
What are you building?
├── Web app with real-time data → Aaron's Stack (Next.js + Convex)
├── Web app with complex SQL needs → Next.js + PostgreSQL
├── Static site or blog → Astro or Next.js
├── CLI tool or automation → Python
├── API service → Hono + Bun
├── Mobile app → React Native + Expo
└── Not sure yet → Start with Next.js (most flexible)
```

## Applying Power User Principles to Any Stack

Regardless of which path you choose, the fundamentals apply:

1. **Write a good CLAUDE.md** — every stack needs one
2. **Use /bootstrap** — .agents/ works for any project
3. **Manage context** — large codebases eat context in any language
4. **Build automation** — commands, hooks, and skills work everywhere
5. **Use MCP servers** — connect your specific tools
6. **Decompose work** — agents help regardless of tech stack

The stack changes. The power user principles don't.

## Exercise: Define Your Path

1. What are you building (or want to build)?
2. Which path above fits best?
3. Write the CLAUDE.md for your chosen stack
4. Run `/bootstrap` in a new project
5. Ask Claude Code to scaffold the initial setup

## Key Takeaway

There's no single "right" stack. The right stack is the one that fits what you're building, what you know, and how well Claude Code can assist with it. Apply the principles from Lesson 01 to any choice, and you'll be productive.

---

**Next:** [Your Power User Journey](04-your-journey.md)

# Stack Guide: Web Development (Next.js + Convex)

This guide complements [Module 07, Lesson 02](../../curriculum/07-building-your-stack/02-aarons-stack.md) with hands-on setup instructions.

## The Stack

| Layer | Tool | Purpose |
|-------|------|---------|
| Runtime | Bun | Fast JS runtime, package manager, test runner |
| Language | TypeScript | Type safety, better AI assistance |
| Frontend | Next.js 14 (App Router) | Full-stack React framework |
| Backend | Convex | Real-time database + serverless functions |
| UI | Tailwind CSS + shadcn/ui | Utility classes + pre-built components |
| Deployment | Vercel | Zero-config deploys for Next.js |

## Quick Start

```bash
# Create project
bunx create-next-app my-app --typescript --tailwind --app
cd my-app

# Add Convex
bun add convex
npx convex init

# Add shadcn/ui
bunx shadcn@latest init

# Bootstrap for Claude Code
claude
/bootstrap
```

## Key Resources

- [Next.js Docs](https://nextjs.org/docs)
- [Convex Docs](https://docs.convex.dev)
- [shadcn/ui Components](https://ui.shadcn.com)
- [Tailwind CSS](https://tailwindcss.com/docs)
- [Bun Docs](https://bun.sh/docs)

## CLAUDE.md Template

See [Module 07, Lesson 02](../../curriculum/07-building-your-stack/02-aarons-stack.md#the-claudemd-for-this-stack) for a production-ready CLAUDE.md template for this stack.

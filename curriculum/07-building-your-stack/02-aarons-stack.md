# Lesson 02: Aaron's Stack — The Full Walkthrough

## Why This Stack

This isn't "the best stack." It's the stack that Aaron uses to ship production apps at Tarrant County Makerspace — and the reasoning behind each choice. Understanding the *why* helps you decide if these choices fit your situation.

## The Stack

| Layer | Choice | Why |
|-------|--------|-----|
| **Runtime** | Bun | Fast, built-in tools (test, bundle), replaces Node + npm + Jest |
| **Language** | TypeScript | Type safety, better AI assistance, catches bugs at compile time |
| **Frontend** | Next.js (App Router) | File-based routing, server components, React ecosystem |
| **Backend** | Convex | Real-time database + serverless functions, no server to manage |
| **UI** | Tailwind CSS + shadcn/ui | Utility classes (AI-friendly) + pre-built components |
| **Deployment** | Vercel | Zero-config for Next.js, automatic previews |
| **AI Tools** | Claude Code + MCP | Agent runtime, connected to everything |

## Layer by Layer

### Bun — The Runtime

**What it replaces:** Node.js + npm + Jest + webpack

Bun is a JavaScript runtime that does everything:
- Runs your code (like Node.js, but faster)
- Manages packages (like npm, but faster)
- Runs tests (built-in, like Jest)
- Bundles code (built-in, like webpack)

**Why Aaron chose it:**
- One tool instead of four
- Dramatically faster package installs
- Native TypeScript support (no build step)
- The simplicity means less CLAUDE.md explaining your toolchain

**Getting started:**
```bash
# Install
curl -fsSL https://bun.sh/install | bash

# Create a project
bun init

# Install dependencies
bun install

# Run a script
bun run dev

# Run tests
bun test
```

### Next.js — The Framework

**What it does:** Full-stack React framework with routing, server rendering, and API routes.

**Why Aaron chose it:**
- File-based routing (create a file, get a route — convention over config)
- Server Components by default (better performance, less client JS)
- Huge ecosystem and community
- Claude Code knows it extremely well
- Vercel deployment is push-to-deploy

**Key conventions:**
```
app/
  page.tsx           → / (home page)
  about/page.tsx     → /about
  api/endpoint/route.ts → /api/endpoint
  layout.tsx         → Shared layout wrapping all pages
```

### Convex — The Backend

**What it replaces:** Express + PostgreSQL + Prisma + REST APIs + WebSocket server

This is the most opinionated choice in the stack, and the most valuable.

**Why Aaron chose it:**
- **Real-time by default** — data updates push to clients automatically
- **Schema-driven** — define your data model, get typed queries for free
- **Serverless functions** — no server to manage, scale, or deploy
- **Built-in auth** — integrates with Clerk, Auth0, etc.
- **TypeScript end-to-end** — schema types flow from database to frontend

**What it looks like:**
```typescript
// convex/schema.ts — define your data
export default defineSchema({
  users: defineTable({
    name: v.string(),
    email: v.string(),
    role: v.union(v.literal("admin"), v.literal("member")),
  }),
});

// convex/users.ts — query your data
export const list = query({
  handler: async (ctx) => {
    return await ctx.db.query("users").collect();
  },
});

// Frontend — use it reactively
const users = useQuery(api.users.list);
// Automatically re-renders when data changes
```

**The trade-off:** Convex is a managed service. You're depending on their infrastructure. For Aaron's use cases (makerspace site, internal tools), this trade-off is worth it — the productivity gain is massive.

### Tailwind + shadcn/ui — The UI

**Why Tailwind:**
- Utility classes are incredibly AI-friendly (Claude Code generates them fluently)
- No context-switching between CSS files and components
- Consistent design system without building one from scratch

**Why shadcn/ui:**
- Pre-built, accessible components (buttons, modals, forms, tables)
- Not a dependency — components are copied into your project, fully customizable
- Tailwind-based, so it integrates perfectly
- Claude Code can read and modify them easily

```tsx
// This is how fast you ship UI with this stack
import { Button } from "@/components/ui/button"
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card"

export function UserCard({ user }) {
  return (
    <Card>
      <CardHeader>
        <CardTitle>{user.name}</CardTitle>
      </CardHeader>
      <CardContent>
        <p className="text-muted-foreground">{user.email}</p>
        <Button variant="outline" size="sm">View Profile</Button>
      </CardContent>
    </Card>
  )
}
```

### Vercel — The Deployment

**Why:**
- Push to git → automatic deployment
- Preview URLs for every PR
- Zero configuration for Next.js
- Built by the Next.js team

```bash
# That's it. Seriously.
git push origin main
# → Vercel builds and deploys automatically
```

## The CLAUDE.md for This Stack

Here's what a real CLAUDE.md looks like with this stack:

```markdown
# My App — Project Instructions

## Tech Stack
Next.js 14 (App Router), Convex, Bun, TypeScript strict, 
Tailwind CSS, shadcn/ui, deployed on Vercel.

## Commands
- Dev: `bun run dev` (starts Next.js + Convex)
- Build: `bun run build`
- Test: `bun test`
- Convex: `npx convex dev`

## Conventions
- Server components by default, 'use client' only when needed
- All data access through Convex (queries/mutations/actions)
- Use shadcn/ui components — don't build custom UI primitives
- Tailwind for all styling — no CSS files
- Use Bun, not npm
- Convex schema is the source of truth for data types
```

## Exercise: Try the Stack

If you want to try this stack:

```bash
# Create a new Next.js + Convex project
bunx create-next-app my-app --typescript --tailwind --app
cd my-app
bun add convex
npx convex init

# Bootstrap for Claude Code
claude
/bootstrap
```

Then tell Claude Code:
```
"Set up shadcn/ui and create a simple dashboard page 
with a card component showing some placeholder data"
```

Watch how fast you go from zero to working UI.

## Key Takeaway

Aaron's stack optimizes for: type safety, conventions, real-time data, and AI-friendliness. Every choice reduces friction between "I want this feature" and "it's deployed." You don't have to use this exact stack — but understand why each piece was chosen, and apply that reasoning to your own choices.

---

**Next:** [Other Paths](03-other-paths.md)

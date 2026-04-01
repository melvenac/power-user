# Power User — Product Requirements Document

> First draft. Living document — update as decisions are made.

## Vision

Teach people to build real software with AI — without becoming traditional developers. The curriculum exists. The product is making it accessible to people who don't yet know they need it.

## Problem

Claude Code is the most powerful AI coding tool available, but:
- Its content targets people **already using it** — docs, changelogs, power-user tips
- The "I didn't know I needed this" crowd has no on-ramp
- People using ChatGPT, Lovable, Bolt, and Cursor hit ceilings they can't see until they hit them
- Small business owners pay developers for things they could ship themselves
- The gap between "I can prompt ChatGPT" and "I can build and ship software" feels enormous — but it's not

## Target Avatar

**Primary: The Capable Non-Developer**
- Small business owners, solopreneurs, makers, creators
- Technically curious — can think in systems, just hasn't crossed into code
- Currently using no-code tools or paying developers
- Wants control over their own products
- Doesn't identify as a "developer" (yet)

**Secondary: The ChatGPT Ceiling-Hitter**
- Already using AI for code (ChatGPT, Copilot, Cursor, Lovable, Bolt)
- Copy-pasting code into files, struggling with project-level work
- Knows something better exists but doesn't know what
- Wants to go from "AI helps me write code" to "AI helps me build products"

**Tertiary: The Junior Developer**
- Early-career or self-taught
- Comfortable with basics but not productive yet
- Wants to 10x their output using AI-native workflows

## Product Tiers

### Tier 1: Free (GitHub Repo) — The Funnel
- Full curriculum: 9 modules, 42 lessons, exercises
- Self-guided, read-at-your-own-pace markdown
- `/feedback` command sends GitHub issues
- Setup scripts for zero-friction install
- Glossary for non-developers
- **Purpose:** Builds trust, generates feedback, proves the content works

### Tier 2: Paid Course (Website) — The Product
- Same curriculum, better delivery
- Structured learning path with progress tracking
- Video walkthroughs of hardest exercises (setup, first task, /compact, permissions, MCP)
- Written guides with screenshots and annotated examples
- Community access (Discord or similar)
- Email support / office hours
- Certificate of completion (optional, low priority)
- **Price range:** $97–$297 one-time

### Tier 3: Cohort / Workshop (In-Person or Live) — Premium
- 4-week cohort with live sessions
- Small groups (10-15 people)
- Aaron teaches directly
- Real project: students build something real during the cohort
- In-person option at Tarrant County Makerspace
- Remote option via video call
- **Price range:** $497–$997

## Website Requirements

### Landing Page
- **Hero:** "Build real software with AI. No CS degree required."
- **Problem/solution framing:** You're using AI wrong. Here's what changes.
- **Social proof:** What Aaron has built with Claude Code (Makerspace site, Open Brain, this curriculum)
- **Honest comparisons:** Not "Claude Code is better than everything" — "here's when to use what"
- **Curriculum preview:** Module list with descriptions (already in README)
- **CTA:** Start free (GitHub link) or buy the course
- **Testimonials:** From Bill, Brian, Sam after they go through it

### Course Delivery
Options (decide later):
1. **Gated markdown** — simplest. Static site with auth, content is the repo rendered nicely
2. **Platform** — Teachable, Podia, or similar. Handles payments, progress, certificates
3. **Custom build** — Next.js + Convex + Clerk + Stripe (Aaron's stack, dogfooding the curriculum)

**Recommendation:** Option 3. Dogfooding is the best marketing — "this course was built with the same stack you'll learn." Plus Aaron already knows the stack.

### Payment
- Stripe (already integrated in Makerspace project, skill exists)
- One-time purchase for Tier 2
- Application/waitlist for Tier 3 cohorts

### Content Delivery
- Markdown rendered as web pages (curriculum is already written)
- Video embeds for key lessons (record as supplementary, not replacement)
- Progress tracking (which lessons completed)
- Exercise completion (self-reported or verified)

## MVP Scope (v1)

**Build:**
- [ ] Landing page with hero, problem/solution, curriculum preview, CTA
- [ ] Stripe checkout for Tier 2
- [ ] Gated content area (authenticated users see full curriculum)
- [ ] Free preview: Module 00 (Getting Started) accessible without purchase
- [ ] Video walkthroughs for 3-5 critical lessons
- [ ] Basic progress tracking

**Don't build yet:**
- Cohort management (Tier 3) — do this manually first
- Community platform — use Discord initially
- Certificate system — low priority
- Mobile app — responsive web is enough
- AI-powered tutoring — the curriculum IS the product

## Content Plan

### Videos to Record (Priority Order)
1. **Setup walkthrough** — running the setup script, configuring VS Code, first `claude` command
2. **First real task** — the "stop asking questions, start giving tasks" moment
3. **The /compact demo** — showing context fill up, compacting with focus, testing what survived
4. **Permissions configuration** — the trust gradient in practice
5. **Building a custom command** — the `/hello` exercise end-to-end

### Written Supplements
- "Why Claude Code?" comparison page (expand the AI tools lesson)
- "What can I build?" showcase of real projects
- FAQ targeting the avatar's objections ("I'm not technical enough", "I tried Copilot and it didn't help", "Why not just use ChatGPT?")

## Marketing / Distribution

### Channels
- **Makerspace community** — built-in audience, in-person workshops
- **YouTube** — video walkthroughs double as marketing content
- **Twitter/X** — Claude Code community is active and engaged
- **Anthropic community** — Claude Code forums, Discord
- **Reddit** — r/ClaudeAI, r/ChatGPTPro, r/learnprogramming
- **SEO** — "learn claude code", "claude code tutorial", "ai coding for beginners"

### The Self-Improving Marketing Loop
```
Free repo → students learn → /feedback creates issues → 
curriculum improves → better product → more students → 
more feedback → repeat
```

Students are also the best marketers. If someone goes from "I can't code" to "I just shipped a real app," they'll tell everyone.

## Tech Stack (if custom-built)

| Layer | Technology | Why |
|-------|-----------|-----|
| Frontend | Next.js (App Router) | Aaron's stack, dogfooding |
| Backend | Convex | Real-time, same as curriculum teaches |
| Auth | Clerk | Same as Makerspace project |
| Payments | Stripe | Embedded checkout, skill exists |
| Hosting | Vercel | Standard for Next.js |
| Content | Markdown → MDX | Curriculum is already markdown |
| Video | YouTube embeds or Mux | Don't self-host video |
| Analytics | Vercel Analytics or Plausible | Privacy-friendly |
| Community | Discord | Free, familiar, low-maintenance |

## Success Metrics

| Metric | Target (6 months) |
|--------|-------------------|
| Free repo stars | 500+ |
| GitHub feedback issues | 50+ |
| Paid course sales | 100 units |
| Cohort participants | 2 cohorts of 10-15 |
| Course completion rate | 60%+ |
| Student projects shipped | 20+ |

## Open Questions

1. **Price point:** $97, $197, or $297? Need to test.
2. **Cohort timing:** Evening workshops at Makerspace? Weekend intensives? Fully remote?
3. **Platform vs. custom:** Dogfooding is great marketing, but a platform ships faster. Which first?
4. **Video production:** Screen recordings with voiceover? Face-on-camera? Both?
5. **Co-instructor:** Does Bill or Brian want to help teach once they've completed it?
6. **Anthropic partnership:** Would Anthropic promote a high-quality community curriculum?

## Timeline (Rough)

| Phase | What | When |
|-------|------|------|
| **Phase 1** | Curriculum polish (current — exercises, examples, feedback loop) | Now |
| **Phase 2** | Landing page + Stripe + gated content | 2-3 weeks |
| **Phase 3** | Record 3-5 video walkthroughs | 1-2 weeks |
| **Phase 4** | Soft launch to Makerspace community | After Phase 3 |
| **Phase 5** | First paid cohort (in-person at Makerspace) | 1 month after soft launch |
| **Phase 6** | Public launch + marketing push | After first cohort feedback |

## Risks

| Risk | Mitigation |
|------|-----------|
| Claude Code changes rapidly | Curriculum is principle-based, not version-specific. Update when needed. |
| Small initial audience | Free tier builds audience. Makerspace provides local base. |
| "Why pay when it's free on GitHub?" | Paid = video, support, community, structure. Free = DIY. |
| Competition from Anthropic's own training | Community perspective is different from vendor perspective. Both can exist. |
| Aaron's time | Tier 2 scales without Aaron. Tier 3 requires his time — limit cohort size. |

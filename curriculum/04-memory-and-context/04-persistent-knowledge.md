# Lesson 04: Building Persistent Knowledge

## From Sessions to Wisdom

Every session you work with Claude Code, you solve problems, make decisions, and discover patterns. Without persistent knowledge, each session is an island. With it, every session builds on the last.

## The Knowledge Lifecycle

```
Session work → Experience captured → Recalled in future sessions → Feedback loop
```

1. **You work** — solve a bug, build a feature, make a design decision
2. **Experience is captured** — at session end, key learnings are stored
3. **Experience is recalled** — next time you face a similar problem, it's surfaced
4. **Feedback refines** — helpful knowledge gets promoted, unhelpful gets pruned

Over time, your Claude Code setup accumulates genuine expertise about your projects and patterns.

## What's Worth Storing

### Store These
- **Gotchas:** "Convex actions re-run, so Stripe clients must be lazy-initialized"
- **Patterns:** "Our API endpoints follow this auth → validate → execute → respond pattern"
- **Decisions:** "We chose cursor-based pagination over offset because of real-time sync"
- **Environment quirks:** "On Windows, bun spawn fails — need to copy bun.exe to PATH"

### Don't Store These
- Things obvious from the code (function signatures, file structure)
- Git history (use `git log` instead)
- Temporary debugging state
- Anything already in CLAUDE.md

The test: **would a future session benefit from knowing this?** If yes, store it. If not, let it go.

## How to Store Knowledge

### Automatic (via /end)
When you run `/end`, the session hooks capture key learnings and store them. You don't have to do anything.

### Explicit (tell Claude Code)
```
"Remember that we decided to use Stripe for payments 
because of their Convex integration"
```

Claude Code creates a memory file or stores it in the knowledge base.

### Direct (via MCP)
If you have a knowledge MCP like Open Brain:
```
"Store this in the knowledge base: when deploying Docker on our VPS, 
always check volume mounts before restarting — config files get 
overwritten if the mount is wrong"
```

## Recalling Knowledge

### Automatic (via /start)
When you run `/start`, it queries the knowledge base for experiences relevant to today's work. Matching experiences are surfaced as context.

### On-demand
```
"What do we know about handling file uploads in this project?"
"Recall any past experiences with database migrations"
```

### Cross-project
Good knowledge is globally available. A pattern learned in Project A can help in Project B:
```
"Recall any experiences with Stripe integration, 
even from other projects"
```

## The Feedback Loop

Not all stored knowledge is equally useful. Feedback helps the system learn:

- **Helpful:** Knowledge that was recalled and actually used → gets promoted
- **Neutral:** Recalled but not relevant → stays as-is
- **Harmful:** Recalled and was wrong or misleading → gets demoted

Over time, your knowledge base becomes more accurate and more relevant. Bad entries get pruned automatically.

### Maturity Levels

| Level | Criteria | Recall Boost |
|-------|----------|-------------|
| Progenitor | Just created | None |
| Proven | 3+ helpful ratings, ≥50% success | 1.2x |
| Mature | 7+ helpful ratings, consistently useful | 1.5x |
| Pruned | Below 30% success after 5+ ratings | Removed |

## Building Your Knowledge Base

### Week 1-2: Foundation
- Run `/end` after every session (this seeds experiences)
- Explicitly store 2-3 important decisions per day
- Don't worry about organization — just capture

### Month 1: Growth
- Notice when recalled knowledge helps → acknowledge it
- Notice when recalled knowledge is wrong → correct it
- Start seeing patterns in what gets recalled

### Month 2+: Maturity
- Your knowledge base has 50-100+ entries
- Good entries have been promoted through feedback
- Bad entries have been pruned
- New sessions start with genuinely useful context

## Exercise: Seed Your Knowledge Base

1. Think of 3 things you've learned about your current project that aren't obvious from the code
2. Tell Claude Code to store each one:
   ```
   "Store in the knowledge base: [your insight]. 
   Tag it with [relevant tags]."
   ```
3. Start a new session and run `/start`
4. See if any of your stored knowledge gets recalled

## Key Takeaway

Persistent knowledge turns every session into an investment in future sessions. The system is self-improving: good knowledge rises, bad knowledge falls, and your Claude Code setup gets smarter over time. All you need to do is work naturally and run `/start` and `/end`.

---

**Next Module:** [Multi-Agent Work](../05-multi-agent/)

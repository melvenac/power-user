# Lesson 03: Skills — Reusable Capabilities

## Workflows That Teach Claude Code

Commands tell Claude Code what to do step by step. Skills go further — they give Claude Code domain knowledge and decision-making frameworks.

## Commands vs. Skills

| | Commands | Skills |
|---|---|---|
| **Structure** | Step-by-step instructions | Knowledge + patterns + decision logic |
| **Trigger** | Manual: `/command-name` | Automatic or manual — Claude detects when relevant |
| **Scope** | Single workflow | Domain expertise |
| **Example** | "/deploy: run tests, build, push" | "Convex development patterns: validators, actions, schema management" |

Think of commands as **recipes** and skills as **cooking knowledge**. A recipe tells you how to make pasta. Cooking knowledge tells you how to adjust when you don't have the right ingredient.

## How Skills Work

Skills are markdown files with structured knowledge that Claude Code can apply contextually:

```markdown
# Skill: Convex Development Patterns

## When to Apply
When writing Convex functions (queries, mutations, actions), 
deploying to Convex, or managing schema.

## Patterns

### Validators
Always define validators for function arguments:
- Use `v.string()`, `v.number()`, `v.id("tableName")` etc.
- Never use `v.any()` in production code

### Actions vs. Mutations
- Mutations: deterministic, touch the database
- Actions: can call external APIs, non-deterministic
- Never call external APIs from mutations

### Common Gotchas
- Actions re-run on failure — make external calls idempotent
- Stripe client must be lazy-initialized in actions
- Schema changes require `npx convex dev` restart
```

## Auto-Triggering Skills

The power of skills is automatic activation. Claude Code reads the skill's trigger conditions and applies the knowledge when relevant:

```markdown
## When to Apply
TRIGGER when: code imports from "convex", schema.ts is open, 
or user mentions Convex functions.
DO NOT TRIGGER when: working on frontend-only code.
```

You don't type `/convex-patterns`. You just work on Convex code, and the knowledge is there.

## Building a Skill

### Step 1: Identify recurring patterns
What knowledge do you share with Claude Code repeatedly? What corrections do you make often?

### Step 2: Structure the knowledge

```markdown
# Skill: [Name]

## When to Apply
[Trigger conditions — when should this knowledge activate?]

## Patterns
[The core knowledge — patterns, rules, examples]

## Common Mistakes
[What goes wrong and how to fix it]

## Examples
[Before/after examples of the pattern applied correctly]
```

### Step 3: Place the file
- Global skills: `~/.claude/skills/`
- Project skills: `.claude/skills/` or `.agents/skills/`

### Step 4: Test it
Work on something that should trigger the skill. Does Claude Code apply the knowledge? If not, refine the trigger conditions.

## Skill Examples

### Error Handling Skill
```markdown
# Skill: API Error Handling

## When to Apply
When writing or modifying API endpoint handlers.

## Pattern
All API endpoints must:
1. Wrap handler in try/catch
2. Return structured errors: { error: string, code: number }
3. Log errors with context: endpoint, userId, timestamp
4. Never expose internal errors to clients

## Example
// Good:
try {
  const result = await processOrder(input);
  return { success: true, data: result };
} catch (error) {
  logger.error({ endpoint: '/orders', userId, error });
  return { error: 'Failed to process order', code: 500 };
}
```

### Git Workflow Skill
```markdown
# Skill: Git Workflow

## When to Apply
When committing, branching, or preparing PRs.

## Rules
- Branch names: feature/, fix/, chore/ prefix
- Commits: conventional commit format (feat:, fix:, chore:)
- Never push directly to main
- PRs require description with ## Summary and ## Test Plan
- Squash merge to main
```

## The Skill Lifecycle

Skills aren't static. They evolve:

1. **Observation:** You notice you keep correcting the same thing
2. **Proposal:** You (or Claude Code) proposes a skill
3. **Draft:** Write the initial skill file
4. **Testing:** Use it for a week, refine based on experience
5. **Maturity:** The skill reliably applies the right knowledge

In advanced setups, skills can even be proposed automatically when patterns emerge from your stored experiences. But that's an advanced topic — for now, create them manually when you notice repeated patterns.

## Real-World Skills: What Aaron Actually Uses

These are real skills from daily development, not hypothetical examples:

### The `/transcript` Skill
```markdown
# YouTube Transcript
Transcribe a YouTube video, index it in the sandbox, and offer to save.

## Instructions
1. Extract the video ID from the URL
2. Fetch the transcript via python youtube_transcript_api
3. Summarize: key topics, speakers, main takeaways
4. Ask "Worth saving?" — offer to persist to knowledge base
```
**Why it exists:** Aaron watches dev content and wants key takeaways indexed automatically. This skill turns a 30-minute video into a 30-second summary.

### The `/bootstrap` Skill
```markdown
# Bootstrap a new project
1. Scan the project and generate CLAUDE.md
2. Scaffold .agents/ directory (TASKS/, SYSTEM/, SESSIONS/)
3. Create lightweight session commands (/start, /end, /task, /sync)
4. Report what was created
```
**Why it exists:** Every new project needs the same scaffolding. Instead of doing it manually each time, one command sets everything up.

### The Pattern
Both skills came from the same process:
1. Aaron did the task manually several times
2. The steps were consistent enough to codify
3. A skill file was created and tested
4. Now it runs in seconds instead of minutes

## Exercise: Create Your First Skill

### Part 1: Find your pattern
Think about your last few Claude Code sessions. What did you repeat? Common candidates:
- Code review checklist you always follow
- Setup steps for a new feature
- Testing patterns you always apply
- Commit message format you correct every time

### Part 2: Write it
Ask Claude Code:
```
"Help me create a skill file. I want to codify this pattern:
[describe what you do repeatedly]

Create it as .claude/skills/[name].md with:
- When to Apply section (trigger conditions)
- Patterns section (the rules)
- Common Mistakes section
- Examples section (before/after)"
```

### Part 3: Test it
Work on something that should trigger the skill. Ask Claude Code:
```
"What skills are available? Does any apply to what we're doing?"
```

### Part 4: Refine
If it didn't trigger when it should have, tighten the trigger conditions. If it triggered when it shouldn't have, loosen them. Skills get better with iteration — your first draft won't be perfect, and that's fine.

## Key Takeaway

Skills are reusable domain knowledge that Claude Code applies automatically. Build them from patterns you notice repeating — every skill you create is a correction you never have to make again.

---

**Next:** [Building Your Automation Layer](04-automation-layer.md)

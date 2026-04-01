# Lesson 04: Writing Better Prompts

## It's Not Prompt Engineering

Forget everything you've read about "prompt engineering." Claude Code isn't a text generator you need to trick into good output. It's an agent you need to **work with** — sometimes as a thought partner, sometimes as an executor.

The key insight: **power users shift between two gears.**

## The Two Gears

### Gear 1: Thinking (Open-Ended)
You're exploring, validating, deciding. You want Claude Code's reasoning, not just its output.

```
"What do you think about using Convex vs Supabase for this project?"
"I'm considering adding WebSocket support — what are the trade-offs?"
"We need to handle file uploads. What approaches make sense for our stack?"
```

### Gear 2: Doing (Command)
You've made a decision. Now you want execution.

```
"Set up Convex with our user schema"
"Add WebSocket support using the approach we discussed"
"Implement file uploads with the S3 presigned URL pattern"
```

**The mistake beginners make** isn't asking too many questions or giving too many commands. It's being stuck in one gear:

- **Always commanding** → you miss edge cases Claude Code would have caught
- **Always asking** → you never ship anything

Power users toggle deliberately.

## The Thinking-Doing Cycle

The natural rhythm of productive work:

```
1. THINK  — "What are the trade-offs of X vs Y?"
2. DECIDE — (you pick, based on Claude's reasoning)
3. DO     — "Implement X"
4. CHECK  — "What do you think about that approach? Anything we missed?"
5. REPEAT
```

### Why Thinking Gear Matters

When you ask Claude Code an open-ended question, it:
- **Surfaces things you haven't considered** — edge cases, security implications, performance gotchas
- **Validates your intuition** — confirms good ideas, flags risky ones
- **Explores alternatives** — you might discover a better approach
- **Builds shared context** — when you DO switch to command gear, Claude Code understands the *why*

### Real Example

**Without thinking gear:**
```
"Add authentication to the app using JWT"
```
Claude Code implements JWT. But maybe JWT isn't the best choice for your stack. You won't know until you hit problems.

**With thinking gear first:**
```
"We need authentication. We're using Next.js and Convex. 
What do you think about our options — JWT, session-based, 
or a managed service like Clerk?"
```

Claude Code explains the trade-offs. You learn that Convex has built-in Clerk integration. You decide:

```
"Good call on Clerk — set it up with Convex auth"
```

Better decision. Better implementation. Two prompts instead of one, but the result is dramatically better.

## The Briefing Pattern (Command Gear)

When you're in doing mode, brief clearly:

### Bad: Vague
```
"Fix the auth"
```
Fix what? Where? What's broken?

### Better: Specific
```
"The login endpoint returns 500 when the email has a plus sign. 
Fix the email validation in src/auth/login.ts"
```

### Best: Contextual
```
"Users with emails like john+test@gmail.com get a 500 on login. 
The issue is probably in the email validation. Fix it and add a 
test case for emails with special characters."
```

The best version gives Claude Code enough context to make smart decisions (add a test) without over-prescribing how to do it.

## Seven Patterns That Work

### Thinking Gear Patterns

#### 1. Trade-Off Analysis
```
"What are the trade-offs between cursor-based and offset-based 
pagination for our use case?"
```
You get reasoning. You make the decision. Then you command the implementation.

#### 2. Idea Validation
```
"I'm thinking about splitting our monorepo into separate packages. 
What do you think — is our codebase at that point yet?"
```
Claude Code looks at the actual code and gives a grounded opinion, not a generic answer.

#### 3. Architecture Review
```
"Before we add this feature, look at how our API is structured. 
Do you see any issues with adding real-time notifications 
to the current architecture?"
```
Catches problems before you're committed to an approach.

### Command Gear Patterns

#### 4. Scoped Execution
```
"Refactor the database queries in src/db/ to use prepared statements. 
Don't touch the API routes — just the DB layer."
```

#### 5. Pattern Matching
```
"Add a new API endpoint for /projects following the same pattern 
as the /users endpoint. Same auth, same error handling."
```

#### 6. Checkpoint Requests
```
"I need to migrate from REST to GraphQL. Before writing any code, 
read the current API and give me a migration plan. 
I'll approve before you start implementing."
```

#### 7. Decomposition
```
"Add user roles to the app. Break this into steps: 
schema changes first, then API middleware, then UI. 
Do them one at a time and check in between."
```

## Knowing When to Shift

| Situation | Gear | Why |
|-----------|------|-----|
| Starting a new feature | Thinking | Explore approaches before committing |
| Choosing between options | Thinking | Leverage Claude's analysis |
| Implementing a decided approach | Doing | Execute efficiently |
| Hitting an unexpected problem | Thinking | Diagnose before fixing |
| Fixing a known bug | Doing | You know what's wrong, just fix it |
| Reviewing completed work | Thinking | "What did you think about that? Anything we missed?" |
| Routine tasks (commit, test, deploy) | Doing | No exploration needed |

**The pattern:** Think at the boundaries (starting, pivoting, reviewing). Do in the middle (implementing, fixing, shipping).

## Anti-Patterns

### Don't over-specify the "how"
```
# Too prescriptive:
"Open src/utils.ts, go to line 47, change the function name 
from processData to handleData, then open every file that imports 
it and update the import"

# Better:
"Rename processData to handleData in src/utils.ts and update 
all imports"
```
Claude Code knows how to rename things. Let it.

### Don't stack unrelated tasks
```
# Bad:
"Fix the login bug, add dark mode, update the README, 
and deploy to staging"

# Good: (four separate prompts)
"Fix the login bug where plus-sign emails cause 500s"
```
Each task gets full attention and clean context.

### Don't explain Claude Code to Claude Code
```
# Unnecessary:
"Use the Grep tool to search for all files containing the word 
'deprecated', then use the Read tool to read each one..."

# Just say:
"Find all deprecated code and tell me what can be removed safely"
```

### Don't skip thinking gear for big decisions
```
# Risky:
"Rewrite the backend in Go"

# Better:
"I'm frustrated with Node.js performance. What do you think — 
is the bottleneck actually the runtime, or something else? 
Should we really rewrite, or are there faster fixes?"
```

## Exercise: Two-Gear Practice

Try both gears on the same problem:

**Round 1 (Thinking):**
```
"I want to add search to our app. What are our options 
given our current stack? What would you recommend?"
```

Read Claude Code's reasoning. Pick an approach.

**Round 2 (Doing):**
```
"Let's go with [chosen approach]. Implement it for the 
[specific feature], following our existing patterns."
```

Notice the difference: Round 1 gave you confidence in the decision. Round 2 gave you clean execution. Together, they're more effective than either alone.

## Key Takeaway

Power users work in two gears — thinking and doing. Open-ended prompts leverage Claude Code's reasoning to validate ideas, surface edge cases, and make better decisions. Command prompts get those decisions implemented efficiently. The skill is knowing when to shift. Think at the boundaries, do in the middle.

---

**Next:** [The Context Window](05-context-window.md)

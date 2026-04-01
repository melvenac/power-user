# Lesson 01: Why Multi-Agent?

## The Single-Thread Problem

You've learned about the context window. You know it's finite. Now consider a task like:

> "Refactor our API from REST to GraphQL. Update the schema, resolvers, client calls, and tests."

In a single thread, this means:
1. Read every REST endpoint (fills context)
2. Design GraphQL schema (more context)
3. Implement resolvers (even more)
4. Update client code (context is groaning)
5. Fix tests (context is full, quality drops)

By step 4, Claude Code has forgotten details from step 1. The context window can't hold it all.

## The Multi-Agent Solution

What if instead:

```
Main Agent (coordinator):
  ├── Agent A: "Analyze all REST endpoints, output a GraphQL schema"
  ├── Agent B: "Implement resolvers based on this schema"
  ├── Agent C: "Update client code to use GraphQL"
  └── Agent D: "Update tests for the new GraphQL endpoints"
```

Each agent gets its own context window. They can work in parallel. The coordinator combines the results.

## When to Use Multiple Agents

### Use agents when:
- **The task has independent parts** that don't need shared context
- **You need deep exploration** — searching a large codebase
- **Context is precious** — offload research to keep your main context clean
- **Tasks can run in parallel** — research A and research B at the same time

### Don't use agents when:
- **The task is sequential** — step 2 depends on step 1's output
- **You need shared state** — agents editing the same file will conflict
- **The task is simple** — overhead of spawning isn't worth it
- **You're still learning** — understand single-agent first

## The Mental Model

Think of it like delegation at work:

| Situation | Approach |
|-----------|----------|
| Quick question | Ask yourself (single agent) |
| Deep research | Send a colleague to investigate (spawn agent) |
| Big project | Assemble a team, divide the work (agent teams) |
| Same-file edits | One person at a time (sequential, not parallel) |

## The Context Benefit

Even for tasks you could do in one thread, agents help with context:

```
# Without agent: result fills your context
"Search the entire codebase for deprecated patterns"

# With agent: only the summary enters your context
"Spawn an agent to search for deprecated patterns 
and summarize what it finds"
```

The agent does the heavy lifting in its own context window. You get just the results.

## Exercise: Agent vs. No Agent

Try the same task both ways:

### Without agent:
```
"Find all TODO comments in this project and categorize them 
by urgency"
```
Watch how many tool calls and how much context it consumes.

### With agent:
```
"Spawn an agent to find all TODO comments in this project. 
Have it categorize them by urgency and return a summary."
```
Notice that only the summary enters your context.

Compare: same result, different context cost.

## Key Takeaway

Multi-agent isn't about doing things you couldn't do before — it's about doing them without filling your context window. Each agent is an independent worker with its own workspace. Use them for exploration, research, and parallelizable tasks.

---

**Next:** [The Agent Tool](02-agent-tool.md)

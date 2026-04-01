# Lesson 02: The Agent Tool

## Spawning Your First Agent

The Agent tool is how you create sub-agents in Claude Code. You don't need to configure anything — it's built in.

## How to Trigger an Agent

You don't call the Agent tool directly. You describe what you want, and Claude Code decides to spawn one. But you can nudge it:

### Implicit (Claude decides)
```
"Research how authentication works in this codebase"
```
For complex exploration, Claude Code may spawn an agent on its own.

### Explicit (you request)
```
"Spawn an agent to analyze our test coverage and report back"
```

```
"Use a sub-agent to search for all database queries 
and check if they use prepared statements"
```

## Agent Types

Claude Code has specialized agent types:

| Type | Good For | Tools Available |
|------|----------|----------------|
| **general-purpose** | Multi-step tasks, research | All tools |
| **Explore** | Codebase search, finding files | Read-only tools (no editing) |
| **Plan** | Architecture, implementation planning | Read-only tools |

### Explore Agents (Fast Research)
```
"Use an Explore agent to find how error handling works 
in the API layer"
```
These are lightweight — optimized for searching and reading, not modifying.

### Plan Agents (Architecture)
```
"Use a Plan agent to design the implementation strategy 
for adding real-time notifications"
```
These analyze and recommend but don't write code.

### General-Purpose Agents (Full Power)
```
"Spawn an agent to implement input validation on all 
API endpoints following our existing pattern"
```
These can read, write, edit, and execute — they do real work.

## How Agents Report Back

When an agent finishes, its result comes back to you as a summary. You see:
- What the agent found or did
- Key decisions it made
- Files it created or modified (if applicable)

The raw details (every file it read, every search it ran) stay in the agent's context. Only the distilled result enters yours.

## Running Agents in Parallel

Claude Code can spawn multiple agents simultaneously:

```
"I need three things researched in parallel:
1. How our auth middleware works
2. What database migrations exist
3. What our test coverage looks like

Spawn agents for each and report back."
```

Three agents run at once. You get three summaries. Your context stays clean.

## Running Agents in Background

For long-running tasks:

```
"Spawn a background agent to run our full test suite 
and analyze any failures. I'll keep working on other things."
```

The agent works while you continue. You're notified when it finishes.

## Agent Isolation

By default, agents share your working directory. For safety, you can request isolation:

```
"Spawn an agent in an isolated worktree to experiment with 
refactoring the auth module. If it works, we'll merge the changes."
```

The agent gets a copy of the repo. Your working directory is untouched until you decide to incorporate the changes.

## Practical Patterns

### Pattern 1: Research Before Action
```
"Spawn an Explore agent to find all places where we format dates.
Once I have the list, I'll decide how to standardize them."
```

### Pattern 2: Parallel Investigation
```
"Something's wrong with the API response times. Spawn agents to:
1. Check the database query performance
2. Check the middleware chain
3. Check the external API calls"
```

### Pattern 3: Safe Experimentation
```
"Spawn an isolated agent to try converting this module to async/await.
Don't touch my working directory."
```

### Pattern 4: Code Review
```
"Spawn an agent to review the changes in this PR 
for security issues and report back."
```

## Exercise: Agent Delegation

1. Think of a research task in your project (something that requires reading many files)
2. First, do it yourself in Claude Code — watch the context cost
3. Now do the same task by spawning an agent
4. Compare: same result, but how much context did each approach use?

Then try parallel agents:
```
"Spawn two agents in parallel:
1. Find all our API endpoints and list them
2. Find all our database models and list them
Report both when done."
```

## Key Takeaway

The Agent tool gives you delegation superpowers. Use Explore agents for research, Plan agents for architecture, and general-purpose agents for real work. Run them in parallel when tasks are independent. Run them in background for long operations. Each one protects your main context window.

---

**Next:** [Task Decomposition](03-task-decomposition.md)

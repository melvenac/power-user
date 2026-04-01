# Lesson 03: Reading the Output

## Learn to Read, Not Just Watch

Most people glance at Claude Code's output and wait for the final answer. Power users read the *process* — the tool calls, the decisions, the moments where Claude chose path A over path B.

## Anatomy of a Response

When Claude Code works on a task, you'll see several types of output:

### 1. Tool Calls
```
⏺ Reading file: src/auth/middleware.ts
```
This tells you which tool is being used and on what. Each tool call is a concrete action — Claude isn't guessing, it's looking.

### 2. Reasoning
Between tool calls, Claude explains what it found and what it's going to do next. This is where you can intervene:
- "Actually, check the other auth file instead"
- "Don't modify that, just tell me what you found"

### 3. Permission Prompts
```
Allow Edit to src/auth/middleware.ts? (y/n/always)
```
This is Claude asking before acting. You'll see these for writes, edits, and command execution. Your options:
- **y** — allow this once
- **n** — deny (Claude will adjust its approach)
- **always** — auto-approve this type of action going forward

### 4. Final Output
The summary, explanation, or confirmation that the work is done.

## What to Watch For

### Tool Selection
When Claude picks a tool, ask yourself: is that the right one?

- Using **Bash** to read a file? That works, but **Read** is more efficient.
- Using **Grep** to find a specific file? **Glob** would be faster.
- Spawning an **Agent** for a simple search? Overkill — Grep would do.

If you notice suboptimal tool choices, you can redirect: "Use Grep for that, not Bash."

### Decision Points
Watch for moments where Claude makes a choice:
- "I see two possible approaches..."
- "This function is called in 5 places, I'll start with..."
- "The test is failing because..."

These are your opportunities to steer. If the decision doesn't match your intent, speak up early — it's cheaper than fixing it later.

### Error Recovery
When something fails (a command errors, a file doesn't exist), watch how Claude handles it:
- **Good:** reads the error, adjusts approach, tries something different
- **Bad:** retries the same thing, ignores the error, or asks you what to do without trying first

If you see bad recovery patterns, you can coach: "Read the error message — what does it say?"

## The Scroll-Back Habit

Get in the habit of scrolling back through tool calls after a complex task. You'll often find:
- Files Claude read that you didn't know about (expand your knowledge)
- Decisions that explain why the solution looks the way it does
- Patterns you can reference in future prompts ("do it the same way you did the auth refactor")

## Exercise: Deliberate Observation

Give Claude Code a medium-complexity task:

```
"Find all the API endpoints in this project, list them with their 
HTTP methods, and identify any that don't have error handling."
```

Don't just wait for the answer. Instead:

1. **Count the tool calls** — how many did it take?
2. **Track the flow** — what did it search for first? How did it narrow down?
3. **Spot the decisions** — did it check every file, or make smart assumptions?
4. **Evaluate the result** — did it miss anything? Did it find things you didn't know about?

Write down your observations. This deliberate practice builds the intuition you need for advanced usage.

## Key Takeaway

The output isn't just the answer — it's a window into how the agent thinks and works. Reading it carefully teaches you how to direct it better, catch mistakes early, and build a mental model of what Claude Code can do.

---

**Next:** [Writing Better Prompts](04-better-prompts.md)

# Lesson 03: Context Management

## Your Scarcest Resource

If memory is about persistence across sessions, context management is about performance within a session. The context window has a hard limit, and how you manage it determines how good Claude Code's output stays throughout your work.

## The Context Budget

Think of your context window as a budget:

| Budget | Behavior |
|--------|----------|
| 0-25% used | Full capacity, best quality |
| 25-50% used | Still good, start being mindful |
| 50-75% used | Quality may dip, consider compacting |
| 75%+ used | Degradation likely, compact or start fresh |

## What Consumes Context

From most expensive to least:

1. **Large file reads** — reading a 2000-line file dumps ~8K tokens
2. **Command output** — `npm install`, test suites, build logs
3. **Multiple tool calls** — each search/read result adds up
4. **Conversation history** — your messages + Claude's responses
5. **System context** — CLAUDE.md, memory, MCP tool definitions

## Strategies for Staying Lean

### 1. Targeted Reads
```
# Expensive:
"Read the entire auth module"

# Cheap:
"Read the handleLogin function in src/auth/login.ts, lines 45-80"
```

Tell Claude Code exactly what you need. Don't read files "just in case."

### 2. Use Agents for Exploration

When you need to search broadly:
```
"Spawn an agent to find all places where we handle user sessions 
and summarize what you find"
```

The agent gets its own context window. Only the summary comes back to yours.

### 3. Sandbox Large Outputs

If you have context-mode (MCP server), use it:
```
"Run the test suite using context-mode and tell me what failed"
```

The raw output stays in the sandbox. Only the summary enters your context.

Without context-mode, be explicit:
```
"Run the tests but only show me failures, not the full output"
```

### 4. Strategic Compaction

`/compact` compresses your conversation history. Use it:
- After finishing a subtask and starting a new one
- When you notice Claude Code forgetting earlier context
- Before starting a context-heavy operation (large refactor, etc.)

With a focus prompt:
```
/compact keep the database schema changes and the migration plan
```

### 5. Session Boundaries

Don't try to do everything in one session. Natural break points:
- Research done → compact → implement
- Feature complete → new session → testing
- Bug found → new session focused on the fix

## The Anti-Patterns

### Reading everything "just to be safe"
```
# Don't:
"Read all the files in src/ so you understand the project"

# Do:
"Read CLAUDE.md and .agents/SUMMARY.md for context, 
then look at only what you need for this task"
```

### Ignoring large outputs
```
# Don't:
"Run npm install" (dumps 500 lines into context)

# Do:
"Run npm install and just tell me if it succeeded"
```

### Never compacting
If your session has been going for 30+ exchanges, you've probably accumulated a lot of context that's no longer relevant. Compact it.

## Monitoring Context Usage

Some setups show context usage as a percentage. If yours does, use the 50% rule:

- **Under 50%:** Work freely
- **At 50%:** Finish current task, then compact
- **Over 75%:** Compact immediately or start a new session

If you don't have a visible indicator, count your exchanges. Roughly:
- 20 simple exchanges ≈ 25% context
- 40 exchanges with file reads ≈ 50%+

These are estimates — actual usage depends on file sizes and output lengths.

## Exercise: Context Diet

1. Start a new session
2. Work on a real task for 15-20 minutes
3. Ask: `"Estimate how much context we've used and what consumed the most"`
4. Run `/compact` with a focus on what you're working on next
5. Continue working — notice if responses feel sharper

## Key Takeaway

Context management is about discipline, not deprivation. Be intentional about what enters your context window. Use agents and sandboxes for heavy exploration. Compact regularly. Your reward is consistently high-quality output throughout the session.

---

**Next:** [Building Persistent Knowledge](04-persistent-knowledge.md)

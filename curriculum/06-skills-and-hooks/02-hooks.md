# Lesson 02: Hooks — Event-Driven Automation

## Things That Happen Automatically

Commands require you to type `/something`. Hooks run automatically in response to events — no manual trigger needed.

## What Are Hooks?

Hooks are shell scripts that execute when specific events occur in Claude Code:

| Event | When It Fires |
|-------|--------------|
| **SessionStart** | Claude Code session begins |
| **SessionEnd** | Claude Code session closes |
| **PreToolUse** | Before a tool is called |
| **PostToolUse** | After a tool finishes |
| **TaskCompleted** | When an agent finishes a task |
| **TeammateIdle** | When a team member has nothing to do |

## How Hooks Work

Hooks are configured in `settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "command": "node scripts/session-start.js",
        "timeout": 10000
      }
    ],
    "PreToolUse": [
      {
        "command": "node scripts/check-tool.js $TOOL_NAME",
        "timeout": 5000
      }
    ]
  }
}
```

When the event fires:
1. The hook command runs in your shell
2. It can output text (fed back to Claude Code as context)
3. It can exit with code 2 to block the action (PreToolUse/PostToolUse)

## Practical Hook Examples

### Session Start: Load Context
```json
{
  "SessionStart": [
    {
      "command": "echo \"Current date: $(date). Git branch: $(git branch --show-current)\"",
      "timeout": 5000
    }
  ]
}
```
Every session starts with the current date and git branch.

### Pre-Tool Use: Safety Guard
```json
{
  "PreToolUse": [
    {
      "command": "node scripts/guard.js $TOOL_NAME",
      "timeout": 3000
    }
  ]
}
```

The guard script could:
- Block `rm -rf` commands
- Warn before modifying production config files
- Log all tool calls for audit

### Post-Tool Use: Auto-feedback
```json
{
  "PostToolUse": [
    {
      "command": "node scripts/log-tool.js $TOOL_NAME",
      "timeout": 3000
    }
  ]
}
```

### Session End: Save State
```json
{
  "SessionEnd": [
    {
      "command": "node scripts/session-end.js",
      "timeout": 30000
    }
  ]
}
```
Automatically captures session learnings and writes them to your knowledge base.

## The Hook Exit Code Protocol

Hooks communicate through exit codes:

| Exit Code | Meaning |
|-----------|---------|
| 0 | Success — continue normally |
| 1 | Error — log it but continue |
| 2 | Block — prevent the action (PreToolUse/PostToolUse only) |

Exit code 2 is powerful. You can create guardrails that physically prevent dangerous operations:

```javascript
// guard.js — block dangerous bash commands
const toolName = process.argv[2];
const input = process.env.TOOL_INPUT || '';

if (toolName === 'Bash' && input.includes('rm -rf')) {
  console.log("BLOCKED: rm -rf is not allowed");
  process.exit(2);  // Blocks the tool call
}

process.exit(0);  // Allow everything else
```

## Hook vs. Command: When to Use Which

| | Commands | Hooks |
|---|---|---|
| **Trigger** | Manual (`/command`) | Automatic (event) |
| **Good for** | Workflows you choose to run | Guardrails, logging, auto-context |
| **User aware?** | Yes — you typed it | May not notice it running |
| **Examples** | `/deploy`, `/status` | Safety guards, session logging |

## Building a Hook

### Step 1: Decide the event
What should trigger your automation?

### Step 2: Write the script
Keep it fast. Hooks run synchronously — slow hooks slow down Claude Code.

### Step 3: Add to settings.json
```json
{
  "hooks": {
    "EventName": [
      {
        "command": "your-command-here",
        "timeout": 5000
      }
    ]
  }
}
```

### Step 4: Test it
Trigger the event and check the output. Use `echo` statements for debugging.

## Exercise: Create a Safety Hook

Create a PreToolUse hook that:
1. Logs every Bash command to a file (`~/.claude-tool-log.txt`)
2. Blocks any Bash command containing `--force` or `--hard`
3. Allows everything else

This gives you an audit trail and a safety net.

## Key Takeaway

Hooks are invisible automation — guardrails that protect you, context that enriches your sessions, and logging that tracks what happened. Use commands for workflows you trigger. Use hooks for things that should happen every time, without thinking.

---

**Next:** [Skills — Reusable Capabilities](03-skills.md)

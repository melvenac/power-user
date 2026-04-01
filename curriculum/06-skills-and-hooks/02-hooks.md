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

## Real-World Example: Aaron's Hook Setup

Here's what a production hook configuration actually looks like. These aren't hypothetical — they run in every session:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash|Read|Grep|Agent|Task",
        "hooks": [{ "type": "command", "command": "node .../pretooluse.mjs" }]
      },
      {
        "matcher": "Bash",
        "hooks": [{ "type": "command", "command": "node .../log-git-ops.mjs", "if": "Bash(git *)" }]
      }
    ],
    "SessionEnd": [
      { "hooks": [{ "type": "command", "command": "node .../session-end.mjs" }] },
      { "hooks": [{ "type": "command", "command": "node .../skill-scan.mjs" }] }
    ],
    "Stop": [
      { "hooks": [{ "type": "command", "command": "powershell .../play-random.ps1" }] }
    ]
  }
}
```

What each one does:
- **PreToolUse (context-mode):** Intercepts tool calls and suggests sandbox alternatives to protect context window
- **PreToolUse (log-git-ops):** Logs every git command for session tracking — uses `"if": "Bash(git *)"` to filter
- **SessionEnd (session-end):** Writes session data to a knowledge database automatically
- **SessionEnd (skill-scan):** Scans the session for repeatable patterns that could become skills
- **Stop (play-random):** Plays a random sound when Claude Code finishes — a small quality-of-life touch

Notice the layering: some hooks use `matcher` to filter which tools trigger them. Some use `"if"` for pattern matching. This gives you fine-grained control.

## Exercise: Build a Notification Sound Hook

This is a fun, quick hook that teaches you the full hook lifecycle. You'll build the same "finished" notification that Aaron uses — a random sound effect that plays every time Claude Code completes a response.

### Step 1: Get some sounds
Go to [myinstants.com](https://www.myinstants.com/) and download a few mp3 sound effects. Pick ones that'll make you smile — meme sounds, classic effects, whatever you want. Save them to `~/.claude/sound/`.

Aaron's collection includes gems like `taco-bell-bong-sfx.mp3`, `rizz-sound-effect.mp3`, and `dry-fart.mp3`. The randomness is half the fun.

### Step 2: Create the player script
Ask Claude Code to create the script. Here's what Aaron's looks like (Windows/PowerShell):

```powershell
# ~/.claude/sound/play-random.ps1
Add-Type -AssemblyName PresentationCore
$dir = "C:\Users\YourName\.claude\sound"
$files = Get-ChildItem $dir -Filter *.mp3
$pick = $files | Get-Random
$player = New-Object System.Windows.Media.MediaPlayer
$player.Open([Uri]::new($pick.FullName))
$player.Play()
# MediaPlayer is async — wait for it to finish (max 10s)
Start-Sleep -Milliseconds 500
$duration = $player.NaturalDuration
if ($duration.HasTimeSpan) {
    $ms = [int]$duration.TimeSpan.TotalMilliseconds
    if ($ms -gt 0 -and $ms -lt 10000) { Start-Sleep -Milliseconds $ms }
    else { Start-Sleep -Seconds 3 }
} else {
    Start-Sleep -Seconds 3
}
$player.Close()
```

Or ask Claude Code to write a cross-platform version:
```
"Create a script that picks a random mp3 from ~/.claude/sound/ 
and plays it. Make it work on my OS."
```

### Step 3: Wire it up
Ask Claude Code:
```
"Add a Stop hook to my settings.json that runs my play-random 
script with a 15 second timeout"
```

The hook config looks like:
```json
{
  "Stop": [{
    "hooks": [{
      "type": "command",
      "command": "powershell -NoProfile -ExecutionPolicy Bypass -File \"C:\\Users\\YourName\\.claude\\sound\\play-random.ps1\"",
      "timeout": 15
    }]
  }]
}
```

### Step 4: Test it
Give Claude Code any task — even just `"hello"`. When it finishes, you should hear a random sound from your collection. Add more mp3s anytime — the script picks randomly from whatever's in the folder.

### Step 5: Graduate to a safety hook
Now build the real thing. Ask Claude Code:
```
"Create a PreToolUse hook script at ~/.claude/hooks/guard.mjs that:
1. Logs every Bash command to ~/.claude/tool-log.txt with a timestamp
2. Blocks any Bash command containing --force or --hard (exit code 2)
3. Allows everything else (exit code 0)
Then wire it into my settings.json"
```

Test it by asking Claude Code to run `git push --force` — the hook should block it and explain why.

## Key Takeaway

Hooks are invisible automation — guardrails that protect you, context that enriches your sessions, and logging that tracks what happened. Use commands for workflows you trigger. Use hooks for things that should happen every time, without thinking.

---

**Next:** [Skills — Reusable Capabilities](03-skills.md)

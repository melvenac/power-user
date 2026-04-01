# Lesson 02: Settings & Permissions

## Controlling the Agent

Claude Code has a permission engine that governs what it can and can't do. By default, it asks you before doing anything potentially impactful. As you build trust, you can open up permissions to let it work more autonomously.

## The Permission Model

Every tool call goes through a check:

```
Tool call → Permission check → Allow / Deny / Ask
```

There are three modes:

| Mode | Behavior | Good For |
|------|----------|----------|
| **Ask** | Prompts you every time | Learning, sensitive projects |
| **Allow** | Auto-approves | Trusted, repetitive operations |
| **Deny** | Auto-rejects | Tools you never want used |

## Settings File

Claude Code settings live in `.claude/settings.json` (per project) and `~/.claude/settings.json` (global).

```json
{
  "permissions": {
    "allow": [
      "Read",
      "Glob",
      "Grep"
    ],
    "deny": [
      "WebFetch"
    ]
  }
}
```

### What to allow early on
- **Read, Glob, Grep** — these only look, never modify. Safe to auto-approve.
- **Agent** — spawns sub-agents for research. Read-only by nature.

### What to keep on "ask" until you're comfortable
- **Edit, Write** — modifies your code
- **Bash** — runs shell commands (powerful but broad)

### What you might deny
- Tools you don't want used in a specific context
- Network tools if you're working on sensitive code

## Permission Prompts in Practice

When Claude Code needs permission, you'll see:

```
Allow Bash: npm test? (y/n/a)
```

Your options:
- **y** — yes, this once
- **n** — no, don't do this
- **a** — always allow this specific pattern

The "always" option remembers the pattern. So "always allow `npm test`" won't auto-approve `rm -rf /`.

## The Trust Gradient (Revisited)

Remember from Module 00:

1. **Supervised** — ask for everything (default, safe)
2. **Guided** — allow reads, ask for writes
3. **Autonomous** — allow most things, deny the dangerous ones

Here's a practical progression:

### Week 1: Supervised
```json
{
  "permissions": {
    "allow": ["Read", "Glob", "Grep"]
  }
}
```

### Week 2-3: Guided
```json
{
  "permissions": {
    "allow": ["Read", "Glob", "Grep", "Edit", "Write", "Agent"]
  }
}
```

### Month 2+: Autonomous
```json
{
  "permissions": {
    "allow": ["Read", "Glob", "Grep", "Edit", "Write", "Agent", "Bash"],
    "deny": ["WebFetch"]
  }
}
```

There's no rush. Move at whatever speed feels right.

## The settings.json Deep Dive

Beyond permissions, settings.json controls:

```json
{
  "permissions": { ... },
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  },
  "hooks": {
    "PreToolUse": [...],
    "PostToolUse": [...],
    "SessionStart": [...],
    "SessionEnd": [...]
  }
}
```

- **env** — environment variables that enable experimental features
- **hooks** — scripts that run in response to events (covered in Module 06)

For now, just know these exist. We'll configure them in later modules.

## Exercise: Set Your Permissions

1. Find your settings file:
   - Global: `~/.claude/settings.json`
   - Project: `.claude/settings.json`

2. Ask Claude Code:
   ```
   "Show me my current permission settings"
   ```

3. If you're comfortable, add read tools to auto-allow:
   ```
   "Update my project settings to auto-allow Read, Glob, and Grep"
   ```

4. Test it — run a search and notice you don't get prompted anymore.

## Key Takeaway

Permissions are your safety net and your productivity lever. Start restrictive, open up gradually, and configure per-project when different projects need different trust levels.

---

**Next:** [The .agents/ Framework](03-agents-framework.md)

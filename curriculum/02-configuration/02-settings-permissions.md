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

### Month 2+: Autonomous (with guardrails)

The key insight at this level: **don't allow all of Bash — allow specific Bash patterns.** This gives Claude Code freedom for common operations while still catching anything unexpected.

```json
{
  "permissions": {
    "allow": [
      "Read", "Glob", "Grep", "WebSearch",
      "Edit", "Write", "Agent",
      "Bash(git *)", "Bash(gh *)",
      "Bash(npm *)", "Bash(npx *)",
      "Bash(bun *)", "Bash(bunx *)",
      "Bash(node *)",
      "Bash(mkdir *)", "Bash(ls *)",
      "Bash(cat *)", "Bash(head *)",
      "Bash(tail *)", "Bash(wc *)",
      "Bash(echo *)", "Bash(cd *)",
      "mcp__open-brain-knowledge__*",
      "mcp__plugin_context-mode_context-mode__*",
      "mcp__smart-connections__*",
      "mcp__ide__*"
    ],
    "deny": ["WebFetch"]
  }
}
```

Notice the pattern: `Bash(git *)` allows any git command, but a general `Bash` call (like `rm`, `curl`, or an arbitrary script) still prompts you. This is the sweet spot — Claude Code works fluidly for 95% of operations, but you're still in the loop for anything unusual.

Also notice the MCP wildcards (`mcp__open-brain-knowledge__*`). If you trust an MCP server, allow all its tools at once.

There's no rush. Move at whatever speed feels right.

## Global vs. Project Permissions

Permissions live in two places, and understanding when to use each matters.

### Global (`~/.claude/settings.json`)
Your personal baseline. Set it once, applies to every project. This is where the Tier 1-3 configuration we discussed goes. It represents **your** trust level with Claude Code.

### Project (`.claude/settings.json`)
Overrides for specific repos. Project settings layer on top of global — a project `deny` overrides a global `allow`.

### When to use project permissions

| Scenario | What to configure |
|----------|------------------|
| **Production / infra repo** | Tighten: deny `Bash(git push *)`, deny `Bash(rm *)` — extra guardrails |
| **Shared team repo** | Define the team's baseline — committed to git, everyone gets it |
| **Experimental / sandbox** | Loosen: allow general `Bash` — nothing to break |
| **Client work** | Deny `WebSearch`, deny network tools — keep code off the wire |
| **Sensitive data** | Deny MCP tools that could send data externally |

### Example: Locking down a production repo

```json
{
  "permissions": {
    "deny": [
      "Bash(git push --force*)",
      "Bash(git reset --hard*)",
      "Bash(rm -rf*)",
      "Bash(drop *)",
      "Bash(docker rm*)"
    ]
  }
}
```

Your global allows `Bash(git *)`, but this project specifically blocks the dangerous git operations. The safe ones (status, log, diff, add, commit) still work.

### The rule of thumb

- **Global:** your permissive, productive baseline (set once)
- **Project:** only when a repo has different risk than your default
- **Most repos:** global is enough — don't over-configure

## Real-World Example: Aaron's Actual Config

Here's a real `~/.claude/settings.json` from daily use. This isn't a tutorial example — it's a working configuration that evolved over months. Let's walk through every section.

### The Full File

```json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  },
  "permissions": {
    "allow": [
      "Read", "Glob", "Grep", "WebSearch",
      "Edit", "Write", "Agent",
      "Bash(git *)", "Bash(gh *)",
      "Bash(npm *)", "Bash(npx *)",
      "Bash(bun *)", "Bash(bunx *)",
      "Bash(node *)",
      "Bash(mkdir *)", "Bash(ls *)",
      "Bash(cat *)", "Bash(head *)",
      "Bash(tail *)", "Bash(wc *)",
      "Bash(echo *)", "Bash(cd *)",
      "mcp__open-brain-knowledge__*",
      "mcp__plugin_context-mode_context-mode__*",
      "mcp__smart-connections__*",
      "mcp__ide__*"
    ],
    "deny": ["WebFetch"]
  },
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash|WebFetch|Read|Grep|Agent|Task|...",
        "hooks": [{ "type": "command", "command": "node .../pretooluse.mjs" }]
      },
      {
        "matcher": "Bash",
        "hooks": [{ "type": "command", "command": "node .../log-git-ops.mjs", "if": "Bash(git *)" }]
      }
    ],
    "SessionStart": [
      { "hooks": [{ "type": "command", "command": "node .../sessionstart.mjs" }] },
      { "hooks": [{ "type": "command", "command": "node .../session-bootstrap.mjs" }] }
    ],
    "SessionEnd": [
      { "hooks": [{ "type": "command", "command": "node .../session-end.mjs" }] },
      { "hooks": [{ "type": "command", "command": "node .../skill-scan.mjs" }] }
    ],
    "Stop": [
      { "hooks": [{ "type": "command", "command": "powershell .../play-random.ps1" }] }
    ]
  },
  "statusLine": {
    "type": "command",
    "command": "bash statusline-command.sh"
  },
  "enabledPlugins": {
    "document-skills@anthropic-agent-skills": true,
    "feature-dev@claude-plugins-official": true,
    "code-review@claude-plugins-official": true,
    "context-mode@context-mode": true,
    "cli-anything@cli-anything": true
  }
}
```

*(Paths shortened for readability — the real ones point to `~/.claude/...`)*

### Section by Section

**`env`** — Environment variables that enable experimental features. `AGENT_TEAMS` lets Claude Code spin up multiple coordinated instances. You won't need this on day one, but it's here to show that settings.json controls more than just permissions.

**`permissions`** — This is the Tier 1-2-3 model from the exercise above, in practice:
- **Tier 1 (read-only):** Read, Glob, Grep, WebSearch — no risk
- **Tier 2 (productive):** Edit, Write, Agent, plus Bash patterns for daily tools (git, npm, bun, node, gh) and all trusted MCP servers
- **Tier 3 (catch-all):** General `Bash` with no pattern still prompts — that's the safety net
- **Denied:** `WebFetch` — blocked because a plugin (`context-mode`) handles web fetching better

**`hooks`** — Scripts that fire on events. Don't worry about writing these yet (that's Module 06). But notice the pattern:
- **PreToolUse** hooks intercept tool calls *before* they run — useful for logging, redirecting, or adding context
- **SessionStart/SessionEnd** hooks run bookkeeping — loading memory at start, saving it at end
- **Stop** hook plays a sound when Claude Code finishes — a small quality-of-life touch

**`statusLine`** — A custom command that runs continuously and displays in the terminal. This one shows context window usage percentage — so you always know when you're approaching the 50% rule.

**`enabledPlugins`** — Plugins from the marketplace that add skills and capabilities. These layer on top of Claude Code's built-in tools.

### What to Take Away

You don't need to build this on day one. This config evolved over months of daily use:
1. Started with just `Read, Glob, Grep` in allow
2. Added `Edit, Write` after a week of trust
3. Added Bash patterns as permission prompts got annoying for safe commands
4. Added MCP wildcards when those servers were installed
5. Hooks came last, as automation needs became clear

**Your config will look different** — and that's the point. There's no "correct" settings.json. There's only the one that matches your workflow and trust level right now.

## Exercise: Set Your Permissions

### Step 1: See what you have
Ask Claude Code:
```
"Show me my current permission settings"
```

### Step 2: Think in three tiers

**Tier 1 — Obviously safe (read-only tools):**
Read, Glob, Grep, WebSearch — these only look, never modify.

**Tier 2 — Productive (modify, but you trust the workflow):**
Edit, Write, Agent, plus Bash patterns for your daily tools (git, npm, bun, gh). Also your MCP servers — if you installed and configured them, you trust them.

**Tier 3 — Needs your attention:**
General Bash (catch-all for anything not matching a pattern), and any tool you've explicitly denied.

### Step 3: Configure
Tell Claude Code:
```
"Update my global settings to auto-allow Tier 1 and Tier 2. 
Keep general Bash on ask. Keep WebFetch denied."
```

Or do it manually in `~/.claude/settings.json` — see the Autonomous example above.

### Step 4: Test the difference
Run a few normal tasks. Notice how many fewer permission prompts you get. If anything feels too loose, tighten it. If you're still getting prompted for something safe, add the pattern.

### Real example: Bash patterns

The `Bash(pattern)` syntax is powerful. Some useful patterns:

| Pattern | What it allows |
|---------|---------------|
| `Bash(git *)` | All git commands |
| `Bash(npm test*)` | Only npm test (not npm install) |
| `Bash(bun *)` | All bun commands |
| `Bash(mkdir *)` | Creating directories |
| `Bash(gh pr *)` | Only GitHub PR operations |

Start broad (`Bash(git *)`), tighten if you need to (`Bash(git status)`, `Bash(git log *)`).

## Key Takeaway

Permissions are your safety net and your productivity lever. Start restrictive, open up gradually, and configure per-project when different projects need different trust levels.

---

**Next:** [The .agents/ Framework](03-agents-framework.md)

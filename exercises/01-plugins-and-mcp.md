# Exercise: Installing Plugins & MCP Servers

## Overview

This exercise walks you through installing the plugins and MCP servers that make Claude Code dramatically more capable. By the end, you'll have a production-ready setup.

**Time:** 20-30 minutes
**Prerequisites:** Claude Code installed and running (Module 00 complete)

---

## Part 1: Understanding Plugins vs. MCP Servers

| | Plugins | MCP Servers |
|---|---|---|
| **What** | Skills and workflows from marketplaces | External tool connections |
| **Install** | Via settings.json marketplace config | Via settings.json mcpServers config |
| **Examples** | code-review, document-skills | Open Brain, database connectors |
| **Think of it as** | Teaching Claude new skills | Giving Claude new tools |

## Part 2: Install Essential Plugins

Plugins come from **marketplaces** — GitHub repos that publish skills. Let's add the two official marketplaces and one community one.

### Step 1: Add marketplaces

Ask Claude Code:
```
"Add these plugin marketplaces to my global settings:
1. anthropics/skills (anthropic-agent-skills)
2. anthropics/claude-plugins-official (claude-plugins-official)  
3. mksglu/context-mode (context-mode)"
```

Or manually add to `~/.claude/settings.json`:
```json
{
  "extraKnownMarketplaces": {
    "anthropic-agent-skills": {
      "source": { "source": "github", "repo": "anthropics/skills" },
      "autoUpdate": true
    },
    "claude-plugins-official": {
      "source": { "source": "github", "repo": "anthropics/claude-plugins-official" }
    },
    "context-mode": {
      "source": { "source": "github", "repo": "mksglu/context-mode" }
    }
  }
}
```

### Step 2: Enable plugins

Add to the same settings.json:
```json
{
  "enabledPlugins": {
    "context-mode@context-mode": true,
    "code-review@claude-plugins-official": true,
    "code-simplifier@claude-plugins-official": true,
    "document-skills@anthropic-agent-skills": true,
    "frontend-design@claude-plugins-official": true,
    "feature-dev@claude-plugins-official": true,
    "superpowers@claude-plugins-official": true
  }
}
```

### Step 3: Restart Claude Code

Plugins load at startup. Close and reopen Claude Code.

### Step 4: Verify

```
"What plugins and skills are available in this session?"
```

---

## Part 3: The Essential Plugins Explained

### Tier 1: Everyone Should Have These

#### context-mode
**What:** Sandboxed execution that keeps large outputs out of your context window.
**Why:** The #1 context saver. When Claude Code runs a command with lots of output (test suites, build logs, git history), context-mode captures it in a sandbox. Only a summary enters your context.
**How it helps:** Instead of losing 20% of your context window to `npm install` output, you lose 1%.

```
"Run the test suite using context-mode and tell me what failed"
```

#### code-review
**What:** Structured code review workflow.
**Why:** Instead of "look at my code," you get a systematic review covering bugs, security, performance, and style.

```
/review
```

#### code-simplifier
**What:** Reviews code for reuse, quality, and efficiency.
**Why:** After writing code, run this to catch over-engineering, duplication, and unnecessary complexity.

```
/simplify
```

### Tier 2: Web Developers

#### document-skills
**What:** Suite of skills for creating PDFs, Word docs, spreadsheets, presentations, and visual designs.
**Why:** When you need to generate documents, reports, or visual artifacts alongside your code.

#### frontend-design
**What:** Production-grade frontend interface generation.
**Why:** Generates distinctive, high-quality UI components — not generic Bootstrap-looking output.

#### feature-dev
**What:** Feature development workflow.
**Why:** Structured approach to planning and implementing new features.

### Tier 3: Specific Use Cases

#### superpowers
**What:** Enhanced Claude Code capabilities.
**Why:** Unlocks additional power-user features.

#### stripe (if doing payments)
**What:** Stripe integration patterns.
**Why:** Knows Stripe's API, handles webhook patterns, subscription flows.

#### telegram (if building bots)
**What:** Telegram bot integration.
**Why:** Telegram bot API patterns, message handling, channel management.

---

## Part 4: Install Your First MCP Server

MCP servers connect Claude Code to external systems. The most impactful first server depends on what you need:

### Option A: Knowledge Base (Open Brain)

If you want persistent memory across sessions:

```json
{
  "mcpServers": {
    "open-brain-knowledge": {
      "command": "node",
      "args": ["path/to/knowledge-mcp/build/server.js"]
    }
  }
}
```

This gives Claude Code tools to store, recall, and rate knowledge entries. It's what powers the Self-Improving Agent's memory.

### Option B: Smart Connections (Obsidian integration)

If you use Obsidian for notes:

```json
{
  "mcpServers": {
    "smart-connections": {
      "command": "node",
      "args": ["path/to/smart-connections-mcp/index.js"]
    }
  }
}
```

This lets Claude Code semantically search your notes — find related content by meaning, not just keywords.

### Option C: Start Simple

If you're just getting started, skip MCP servers for now. The plugins alone are a huge upgrade. Come back to MCP servers when you feel the friction of copying data between systems.

---

## Part 5: Verify Your Setup

After installing everything, restart Claude Code and run this verification:

```
"Give me a status report:
1. What plugins are active?
2. What MCP servers are connected?
3. What custom commands are available?
4. What skills can you use?"
```

You should see your plugins listed, any MCP servers connected, and the skills they provide.

---

## Part 6: The Setup Checklist

After completing this exercise, you should have:

- [ ] Plugin marketplaces configured (anthropic-agent-skills, claude-plugins-official, context-mode)
- [ ] context-mode plugin enabled (essential for context savings)
- [ ] code-review plugin enabled (structured reviews)
- [ ] code-simplifier plugin enabled (quality checks)
- [ ] At least one Tier 2 plugin for your use case
- [ ] Optionally: an MCP server connected
- [ ] Verified everything loads on restart

## What's Next

With plugins and MCP servers installed, you're working with a significantly more capable Claude Code. The plugins add skills automatically — you don't need to do anything special to use them. They activate when relevant.

Continue with the curriculum — these tools will enhance every lesson from here on.

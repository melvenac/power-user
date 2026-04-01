# Lesson 03: Practical MCP Servers

## MCP Servers Worth Installing

Here are MCP servers that provide real, daily value. Organized by what you're trying to do.

## For Web Developers

### GitHub MCP Server
**What:** Full GitHub integration — issues, PRs, repos, code search
**Why:** Stop switching to the browser for GitHub tasks

```json
{
  "github": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-github"],
    "env": {
      "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_your_token"
    }
  }
}
```

**Use cases:**
```
"Create an issue for the pagination bug"
"What PRs are open right now?"
"Review the latest PR and leave comments"
```

**Pro tip:** If you have `gh` (GitHub CLI) installed and authenticated, you already get most of this through Bash. The MCP server gives Claude Code native tool access without shelling out.

### Database Servers
**What:** Query your database directly
**Why:** No more copy-pasting SQL results

For **SQLite**:
```json
{
  "sqlite": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-sqlite", "./data/app.db"]
  }
}
```

For **PostgreSQL**:
```json
{
  "postgres": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-postgres"],
    "env": {
      "DATABASE_URL": "postgresql://user:pass@localhost:5432/mydb"
    }
  }
}
```

**Use cases:**
```
"Show me users who signed up in the last week"
"What's the most common error in the logs table?"
"Find all orders where the total doesn't match the line items"
```

## For Knowledge Management

### Obsidian / Notes Server
**What:** Access your notes and knowledge base
**Why:** Claude Code can reference your notes while working

**Use cases:**
```
"Check my project notes for the API design decisions we made"
"Find the meeting notes where we discussed the auth approach"
```

### Smart Connections
**What:** Semantic search across your notes
**Why:** Find related content by meaning, not just keywords

## For DevOps / Infrastructure

### Docker MCP
**What:** Manage Docker containers and images
**Why:** Container ops without leaving your session

**Use cases:**
```
"What containers are running right now?"
"Restart the API container"
"Show me the logs from the worker container"
```

## Aaron's Stack: What We Use

Here's a real-world MCP setup for the tech stack we teach in this curriculum:

```json
{
  "mcpServers": {
    "open-brain": {
      "command": "node",
      "args": ["path/to/knowledge-mcp/index.js"],
      "env": {
        "DB_PATH": "path/to/knowledge.db"
      }
    },
    "context-mode": {
      "command": "node",
      "args": ["path/to/context-mode/index.js"]
    },
    "smart-connections": {
      "command": "node",
      "args": ["path/to/smart-connections-mcp/index.js"]
    }
  }
}
```

This gives Claude Code:
- **Open Brain** — persistent knowledge base across sessions (recall, store, feedback)
- **Context-mode** — sandboxed execution that saves context window space
- **Smart Connections** — semantic search across Obsidian vault

The combination means Claude Code can remember past work, process large outputs efficiently, and search your notes — all without you doing anything manual.

## How to Evaluate an MCP Server

Before installing, ask:

| Question | Why It Matters |
|----------|---------------|
| Is it from a trusted source? | Security — it runs with your permissions |
| Does it solve a daily friction? | Don't install what you won't use |
| Does it overlap with something you have? | Avoid redundant tools |
| Is it actively maintained? | Abandoned servers break |
| Does it need API keys? | Know what you're giving access to |

## Exercise: Plan Your Setup

Don't install everything at once. Instead:

1. **List your top 3 daily frictions** with Claude Code
   - What do you copy-paste most often?
   - What makes you switch windows?
   - What data do you wish Claude Code could see?

2. **Find MCP servers** that solve those frictions
   - Check [the MCP server directory](https://github.com/modelcontextprotocol/servers)
   - Ask Claude Code: `"What MCP servers exist for [your use case]?"`

3. **Install one** — the one that solves your biggest friction
4. **Use it for a week** before adding another

## Key Takeaway

Don't collect MCP servers — curate them. Each one should solve a real, recurring friction. A focused set of 3-5 servers that you use daily beats 20 that you forget about.

---

**Next:** [Building Your Tool Ecosystem](04-tool-ecosystem.md)

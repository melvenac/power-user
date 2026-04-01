# Lesson 01: What Is MCP?

## The Problem MCP Solves

Out of the box, Claude Code can read files, write code, and run commands. That's powerful, but it's limited to your local machine. What about:

- Your database?
- Your project management tool?
- Your deployment pipeline?
- Your documentation system?
- Your team's internal APIs?

Without MCP, you'd have to copy-paste data between these systems and Claude Code. With MCP, Claude Code can talk to them directly.

## MCP in Plain English

**Model Context Protocol (MCP)** is a standard way for AI tools to connect to external systems. Think of it like USB for AI:

- USB lets you plug any device into any computer
- MCP lets you plug any tool into any AI agent

An MCP server is a small program that exposes tools to Claude Code. When you connect one, Claude Code gets new capabilities — new tools show up that it can use just like the built-in ones.

## How It Works

```
You: "What's the status of our latest deployment?"

Claude Code → MCP Server (deployment tool) → Your CI/CD system
                                            ← Status info
Claude Code ← Formatted response
You: "Deployed 2 hours ago, all green, 3 services updated"
```

Claude Code doesn't need to know how your deployment system works. The MCP server handles that translation.

## The Two Roles

Claude Code can be both:

### 1. MCP Client (most common)
Claude Code connects TO external MCP servers to gain new tools.

```
Claude Code → connects to → Database MCP server
Claude Code → connects to → GitHub MCP server
Claude Code → connects to → Slack MCP server
```

### 2. MCP Server (advanced)
Other tools connect TO Claude Code. This lets external systems trigger Claude Code to do work.

For now, we'll focus on the client role — connecting tools to Claude Code.

## What MCP Servers Look Like

An MCP server is configured in your settings. Here's a simple example:

```json
{
  "mcpServers": {
    "my-database": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sqlite", "path/to/db.sqlite"]
    }
  }
}
```

This tells Claude Code: "There's an MCP server called 'my-database'. Start it with this command. It'll give you tools to query a SQLite database."

Once connected, Claude Code can:
```
"Show me all users who signed up this week"
→ Uses the MCP database tool to run a query
→ Returns the results
```

No copy-pasting. No switching windows. No SQL in your chat.

## The MCP Ecosystem

There are MCP servers for nearly everything:

| Category | Examples |
|----------|---------|
| **Databases** | SQLite, PostgreSQL, MongoDB |
| **Dev Tools** | GitHub, Linear, Jira |
| **Communication** | Slack, email |
| **Cloud** | AWS, GCP, Vercel |
| **Knowledge** | Obsidian, Notion, Google Drive |
| **Custom** | Anything with an API |

And if one doesn't exist for your use case, you can build one. We'll cover that in Lesson 04.

## Why This Is a Game-Changer

Without MCP:
1. Open Claude Code
2. Switch to browser, check deployment status
3. Copy the info
4. Paste into Claude Code
5. Ask your question

With MCP:
1. Open Claude Code
2. "What's our deployment status and are there any issues?"

The friction reduction compounds. Every context switch you eliminate is time and focus saved. And the more systems Claude Code can access, the more it can do autonomously.

## Exercise: Discover Available Tools

Ask Claude Code:
```
"What MCP servers are currently connected? What tools do I have 
beyond the built-in ones?"
```

If you don't have any MCP servers yet, that's fine — we'll connect one in the next lesson.

If you do have some (maybe from a plugin or extension), explore them:
```
"Show me all the MCP tools available and what each one does"
```

## Key Takeaway

MCP is how Claude Code connects to the outside world. Each MCP server you add gives Claude Code new tools — new capabilities to work with your specific systems. The more you connect, the more autonomous and useful it becomes.

---

**Next:** [Connecting Your First MCP Server](02-first-mcp-server.md)

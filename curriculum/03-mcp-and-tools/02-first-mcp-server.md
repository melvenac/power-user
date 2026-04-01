# Lesson 02: Connecting Your First MCP Server

## Hands-On: Your First Connection

Let's connect an MCP server to Claude Code. We'll start with something simple and useful: a filesystem server that gives Claude Code enhanced file management tools.

## Where MCP Servers Are Configured

MCP servers go in your settings file:

- **Global** (all projects): `~/.claude/settings.json`
- **Project** (this project only): `.claude/settings.json`

The structure:

```json
{
  "mcpServers": {
    "server-name": {
      "command": "the command to start the server",
      "args": ["argument1", "argument2"],
      "env": {
        "API_KEY": "your-key-here"
      }
    }
  }
}
```

## Example: Connect a Memory Server

Let's connect a practical MCP server — one that gives Claude Code a persistent knowledge base.

### Step 1: Add to settings

Ask Claude Code:
```
"Add an MCP server to my global settings for the filesystem server. 
Use npx with @modelcontextprotocol/server-filesystem and scope it 
to my home directory."
```

Or manually add to `~/.claude/settings.json`:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/home/youruser"
      ]
    }
  }
}
```

### Step 2: Restart Claude Code

MCP servers are loaded at startup. After adding one, restart your session:
- Close Claude Code
- Reopen it

### Step 3: Verify it's connected

```
"What MCP tools are available? Show me the ones from the 
filesystem server."
```

You should see new tools like `read_file`, `write_file`, `list_directory`, etc.

### Step 4: Use it

```
"Using the filesystem tools, list what's in my Documents folder"
```

## Understanding the Config

Let's break down what each field does:

```json
{
  "server-name": {          // Your name for this server
    "command": "npx",       // How to start it (npx, node, python, etc.)
    "args": [               // Arguments passed to the command
      "-y",                 // npx: auto-confirm install
      "package-name",       // The MCP server package
      "path/or/config"      // Server-specific args
    ],
    "env": {                // Environment variables (optional)
      "API_KEY": "sk-..."   // Often used for authentication
    }
  }
}
```

## Common Patterns

### NPM-based servers (most common)
```json
{
  "my-server": {
    "command": "npx",
    "args": ["-y", "@scope/server-name"]
  }
}
```

### Python-based servers
```json
{
  "my-server": {
    "command": "python",
    "args": ["-m", "mcp_server_package"]
  }
}
```

### Local server (your own)
```json
{
  "my-server": {
    "command": "node",
    "args": ["path/to/your/server.js"]
  }
}
```

## Troubleshooting

### "MCP server failed to start"
- Check that the command works in your terminal: `npx -y @scope/server-name`
- Check permissions and paths
- Look at Claude Code's output for error messages

### "Tool not found"
- Server might have started but the tool name differs from what you expect
- Ask: `"List all available MCP tools"` to see exact names

### "Authentication error"
- Check your `env` section for the right API keys
- Make sure keys haven't expired

## Security Note

MCP servers run on your machine with your permissions. Be thoughtful about:
- **What you connect** — only install servers you trust
- **What data they access** — scope to specific directories/databases
- **API keys** — keep them in env vars, not hardcoded in args
- **Network access** — some servers make external API calls

This isn't paranoia — it's good practice. You wouldn't install random npm packages without checking them, and MCP servers deserve the same scrutiny.

## Exercise: Install Your First MCP Server (End to End)

This exercise walks you through the full lifecycle: install, configure, restart, verify, use. We'll install a real server you'll actually keep.

### Option A: Context Mode (recommended for this curriculum)
Context Mode keeps large tool outputs in a sandbox instead of flooding your context window. It's a plugin, not a traditional MCP server, but the install process teaches the same pattern.

```
"Install the context-mode plugin from the mksglu/context-mode 
GitHub marketplace. Add it to my global settings."
```

### Option B: Filesystem Server (simplest traditional MCP)
```
"Add the @modelcontextprotocol/server-filesystem MCP server to my 
global settings, scoped to my home directory."
```

### Option C: Smart Connections (if you use Obsidian)
```
"Add the smart-connections MCP server to my global settings, 
pointed at my Obsidian vault."
```

### After installing (all options):

**Step 1: Restart**
Close Claude Code and reopen. MCP servers load at startup.

**Step 2: Verify**
```
"What MCP tools are available? List the ones from [server name]."
```
You should see new tools that weren't there before.

**Step 3: Use it**
```
"Use one of the new MCP tools to do something useful right now."
```

**Step 4: Understand what happened**
```
"Explain what just happened — which MCP tool did you use, 
what did it do, and how is it different from your built-in tools?"
```

### What you learned
- MCP servers are configured in `settings.json` (global or project)
- They load at startup — you restart to pick them up
- Each one adds new tools Claude Code can use
- The pattern is always: config → restart → verify → use

## Key Takeaway

Connecting an MCP server is: add config → restart → use new tools. Start with one, get comfortable, then layer more. Each one expands what Claude Code can do for you.

---

**Next:** [Practical MCP Servers](03-practical-servers.md)

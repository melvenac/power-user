# Lesson 01: The Tool System

## Claude Code's Hands

If Claude is the brain, tools are the hands. Without them, it can only talk. With them, it can **work**.

## The Core Tools

Every Claude Code session has these tools available by default:

### File Tools
| Tool | What It Does | Example |
|------|-------------|---------|
| **Read** | Reads file contents | Viewing your code before editing |
| **Write** | Creates new files | Writing a new component from scratch |
| **Edit** | Modifies existing files | Changing a function, fixing a bug |
| **Glob** | Finds files by pattern | "Find all *.tsx files in src/" |
| **Grep** | Searches file contents | "Find everywhere we import lodash" |

### Execution Tools
| Tool | What It Does | Example |
|------|-------------|---------|
| **Bash** | Runs shell commands | `npm install`, `git status`, `ls` |

### Research Tools
| Tool | What It Does | Example |
|------|-------------|---------|
| **Agent** | Spawns sub-agents for complex tasks | Deep codebase exploration |
| **WebSearch** | Searches the web | Looking up API docs |

### Workflow Tools
| Tool | What It Does | Example |
|------|-------------|---------|
| **TaskCreate** | Creates trackable tasks | Breaking work into steps |
| **TaskUpdate** | Updates task progress | Marking steps complete |

## How Claude Code Chooses Tools

You don't tell Claude Code which tool to use (usually). You describe what you want, and it picks the right tool. But understanding the tools helps you:

1. **Write better prompts** — "search for all usages of this function" signals Grep
2. **Understand what's happening** — when you see a Read tool call, you know it's looking at a file
3. **Redirect when needed** — "don't run that command, just show me what you'd do"

## The Tool Call Cycle

Every action Claude Code takes follows this pattern:

```
You say something
    → Claude decides which tool(s) to use
        → Permission check (allow/deny/ask)
            → Tool executes
                → Claude reads the result
                    → Decides next step or responds
```

This cycle can repeat many times in a single response. A complex task might involve 10+ tool calls.

## Exercise: Tool Spotting

Give Claude Code this prompt in any project:

```
"Find the largest file in this project, read it, 
and tell me what it does."
```

Watch the tool calls:
1. It'll use **Bash** (`ls` or `du`) or **Glob** to find files
2. It'll use **Read** to look at the contents
3. It'll use its reasoning to explain

Now try:
```
"Find every file that imports React and list them"
```

This one will use **Grep** (searching for `import.*React` or `require.*react`).

## Tool Permissions

Each tool call goes through the permission engine. You'll learn to configure this in Module 02, but for now know that:

- **Safe tools** (Read, Glob, Grep) — usually auto-approved
- **Action tools** (Edit, Write, Bash) — may prompt you for approval
- **You're always in control** — nothing happens without your permission (unless you configure it to)

## Key Takeaway

Tools are what make Claude Code an agent instead of a chatbot. Learn to recognize them in the output, and you'll understand exactly what Claude Code is doing and why.

---

**Next:** [Slash Commands](02-commands.md)

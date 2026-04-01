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

## Exercise: Tool Scavenger Hunt

This exercise teaches you to recognize tools by giving you tasks that require specific ones. Do this in the `power-user` repo (or any project with multiple files).

### Round 1: File finding (Glob)
```
"Find all markdown files in this project"
```
Watch: Claude Code uses **Glob** with a pattern like `**/*.md`. Note how many files it finds.

### Round 2: Content searching (Grep)
```
"Find every file that mentions 'exercise' in its contents"
```
Watch: Claude Code uses **Grep** to search inside files — different from Glob, which only matches file names.

### Round 3: Reading (Read)
```
"Read the first 20 lines of the README"
```
Watch: Claude Code uses **Read** with a line limit. It doesn't read the whole file — that would waste context.

### Round 4: Chaining tools
```
"Find the largest markdown file in this project, read it, 
and summarize it in 3 bullets"
```
Watch the chain: **Bash** (to check file sizes) → **Read** (to see contents) → reasoning (to summarize). Multiple tools, one prompt.

### Round 5: The wrong tool
```
"Search the web for Claude Code documentation"
```
Watch: Claude Code uses **WebSearch**, not Grep. It knows the difference between searching your files and searching the internet.

### Reflect
After each round, ask yourself:
- Which tool did it pick?
- Could you have predicted it from the prompt?
- What words in your prompt signaled which tool? ("find files" → Glob, "search contents" → Grep, "read" → Read)

## Tool Permissions

Each tool call goes through the permission engine. You'll learn to configure this in Module 02, but for now know that:

- **Safe tools** (Read, Glob, Grep) — usually auto-approved
- **Action tools** (Edit, Write, Bash) — may prompt you for approval
- **You're always in control** — nothing happens without your permission (unless you configure it to)

## Key Takeaway

Tools are what make Claude Code an agent instead of a chatbot. Learn to recognize them in the output, and you'll understand exactly what Claude Code is doing and why.

---

**Next:** [Slash Commands](02-commands.md)

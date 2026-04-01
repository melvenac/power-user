# Lesson 00: Terminal vs. Chat — Two Ways to Use Claude Code

## Same Engine, Different Interface

Claude Code runs the same AI model with the same tools whether you use it in the terminal or in VS Code's chat panel. The difference is how you see and interact with the work.

Think of it like driving a car with a manual vs. automatic transmission. Same car, same engine, same destination — different experience getting there.

## The Two Interfaces

### VS Code Chat (Sidebar)

Open VS Code, click the Claude Code icon in the sidebar (or install the extension if you haven't). You get a chat panel next to your code.

**What it looks like:**
- Chat messages on one side, your code on the other
- When Claude Code edits a file, you see the diff highlighted inline
- Conversation history is saved — you can scroll back through past sessions
- Files you have open give Claude Code visual context

### Terminal (CLI)

Open a terminal, type `claude`, and you're in a text-based conversation.

**What it looks like:**
- Full-screen terminal with your messages and Claude Code's responses
- Tool calls show as text output (file reads, searches, edits)
- Session ends when you close the terminal (unless you run `/end` to save state)
- No visual file diffs — you see the Edit tool's text output

## Side-by-Side Comparison

| Feature | VS Code Chat | Terminal |
|---------|-------------|---------|
| **See file edits** | Inline diff highlighting | Text description of changes |
| **Session history** | Saved automatically | Gone when you close (unless /end saves state) |
| **File context** | Open files give visual context | Same access, no visual indicator |
| **Multiple sessions** | One chat per workspace | Multiple terminals = multiple sessions |
| **Slash commands** | Type naturally ("start", "end") — `/` autocomplete can be inconsistent | `/start`, `/end` work reliably |
| **Multi-agent** | Works, but harder to follow | Easier to see agent coordination |
| **Keyboard flow** | Stay in the editor | Stay in the terminal |
| **Screen real estate** | Shares space with editor | Full screen |
| **SSH / remote work** | Need VS Code Remote | Works anywhere with a terminal |

## Which Should You Start With?

### Start with VS Code Chat if:
- You're new to development or Claude Code
- You like seeing changes visually (inline diffs)
- You want conversation history without extra setup
- You're already working in VS Code all day
- You learn better with a visual, chat-style interface

### Start with Terminal if:
- You're comfortable in the terminal already
- You want full screen for Claude Code's output
- You're doing multi-agent work or long sessions
- You're working over SSH or on a remote server
- You prefer keyboard-only workflows

### The honest recommendation:
**If you're brand new, start with VS Code Chat.** The visual diffs alone make it worth it — you'll always know exactly what Claude Code changed. The chat history gives you a safety net. And it feels familiar if you've used ChatGPT or similar tools.

**Graduate to terminal when you're comfortable.** Once you understand the tools, commands, and workflow, the terminal gives you more control and flexibility. Many power users end up using both depending on the task.

## Using Both

There's no rule that says you have to pick one. A common pattern:

- **Chat** for exploring code, reviewing changes, quick edits while reading files
- **Terminal** for deep work sessions, running `/start` and `/end`, multi-agent tasks, automation

Some people open VS Code with the chat panel AND a terminal running Claude Code. Different sessions, different purposes.

## What Stays the Same

No matter which interface you use:

- **Same AI model** — identical capabilities
- **Same tools** — Read, Write, Edit, Bash, Grep, Glob, Agent
- **Same CLAUDE.md** — loaded in both
- **Same .agents/ framework** — works in both
- **Same MCP servers** — available in both
- **Same permissions** — from the same settings.json

Everything in this curriculum works in both interfaces. We'll note when something is different.

## Exercise: Try Both

### Part 1: VS Code Chat

1. Open a project in VS Code
2. Open the Claude Code chat panel
3. Ask: `"What files are in this project?"`
4. Ask: `"Add a comment to the top of [any file] explaining what it does"`
5. **Watch the inline diff** — see exactly what changed, accept or reject

### Part 2: Terminal

1. Open a terminal in the same project directory
2. Type `claude` to start a session
3. Ask the same questions: `"What files are in this project?"`
4. Ask: `"Add a comment to the top of [any file] explaining what it does"`
5. **Watch the tool output** — see the Edit tool's text description of changes

### Reflect:
- Which felt more natural?
- Where did you feel more confident about what was happening?
- Did one feel faster?

There's no wrong answer. Use what works for you.

## Key Takeaway

VS Code Chat and Terminal are two doors to the same room. Chat is more visual and beginner-friendly. Terminal is more powerful and flexible. Start where you're comfortable, and don't feel locked in — you can switch anytime, or use both.

---

**Next:** [The Tool System](01-tools.md)

# Lesson 02: Installation & First Run

## Prerequisites

Before installing Claude Code, you need:

1. **Node.js 18+** — check with `node --version`
2. **A Claude subscription** — Claude Pro, Max, or an API key
3. **A terminal** — Windows Terminal, iTerm2, VS Code integrated terminal, etc.

## Install

```bash
npm install -g @anthropic-ai/claude-code
```

That's it. One command.

## First Run

Navigate to any project folder (or just your home directory) and type:

```bash
claude
```

You'll see a prompt. Claude Code is now running as an agent in that directory. Everything it does is scoped to this folder and its contents.

### What Just Happened?

When you launched `claude`, it:

1. **Started the agent runtime** — loaded tools, permissions, and the conversation engine
2. **Read your context** — checked for `CLAUDE.md`, `.claude/` settings, and any memory files
3. **Scoped to your directory** — it can see and work with files in this folder and below

You're not in a chat window. You're in a **work session**.

## The VS Code Way

If you prefer an IDE:

1. Install the Claude Code VS Code extension
2. Open a project folder
3. Claude Code runs in the sidebar, scoped to that project

Same engine, different interface. Everything in this curriculum works in both.

## Quick Orientation

Try these to get a feel for the tool:

| Type this | What happens |
|-----------|-------------|
| `hello` | Claude responds — basic conversation works |
| `/help` | Shows available commands |
| `what files are in this directory?` | Claude uses the Glob tool to look |
| `/init` | Generates a CLAUDE.md for this project |
| `/bootstrap` | Full project setup — CLAUDE.md + .agents/ framework |

## The `/bootstrap` Shortcut

For this curriculum, we recommend starting every new project with:

```
/bootstrap
```

This does two things at once:
1. **Generates CLAUDE.md** — scans your project and creates instructions for Claude
2. **Scaffolds .agents/** — sets up task tracking, session management, and project state

You don't need to understand what `.agents/` does yet — that's Module 02. Just know that `/bootstrap` sets you up right from the start.

## Exercise: Your First Bootstrap

1. Create a new empty folder: `mkdir ~/test-project && cd ~/test-project`
2. Launch Claude Code: `claude`
3. Type: `/bootstrap`
4. Watch what it creates
5. Type: `what files did you just create and why?`

This exercise teaches you to **ask Claude Code to explain itself**. That's a habit worth building early.

## Common Issues

**"command not found: claude"**
→ Make sure npm global bin is in your PATH. Run `npm bin -g` to check.

**"Authentication required"**
→ You need to log in. Claude Code will prompt you, or check [the docs](https://docs.anthropic.com/en/docs/claude-code).

**Slow startup**
→ First run downloads models and caches. Subsequent runs are faster.

---

**Next:** [Your First Real Task](03-first-task.md)

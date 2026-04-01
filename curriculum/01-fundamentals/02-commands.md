# Lesson 02: Slash Commands

## Your Shortcuts

Slash commands are built-in workflows you trigger with `/`. They're like keyboard shortcuts — you don't *need* them, but they make you faster.

## Essential Commands

### Getting Help
| Command | What It Does |
|---------|-------------|
| `/help` | Shows available commands and basic usage |
| `/status` | Shows current session state |

### Context Management
| Command | What It Does |
|---------|-------------|
| `/init` | Generates a CLAUDE.md from your project (one-time setup) |
| `/compact` | Compresses conversation to save context space |
| `/compact [focus]` | Compresses but keeps specific info: `/compact keep the API schema` |
| `/context` | Manages what files Claude Code is paying attention to |

### Code Review
| Command | What It Does |
|---------|-------------|
| `/review` | Runs a structured code review on recent changes |
| `/security` | Runs a security-focused review |

### Session
| Command | What It Does |
|---------|-------------|
| `/clear` | Clears the conversation (fresh start) |

## Custom Commands

This is where it gets interesting. You can create your own slash commands by adding markdown files to `.claude/commands/`:

```
.claude/
  commands/
    deploy.md      → /deploy
    test.md        → /test
    bootstrap.md   → /bootstrap
```

Each file is a set of instructions that Claude Code follows when you trigger the command. We'll build custom commands in Module 06.

**Pro tip:** Your team can share commands by committing them to the repo. Everyone gets the same workflows.

## Exercise: Command Discovery + Your First Custom Command

### Part 1: Discover what's built in
1. Open Claude Code and type `/help` — scan the list
2. Try `/compact` after a long conversation — notice how it frees up space
3. If you're in a git repo, try `/review` — see the structured output

Then ask:
```
"What custom commands are available in this project?"
```
Claude Code will check `.claude/commands/` and tell you.

### Part 2: Build your first custom command

Let's create a simple `/hello` command that introduces you to a project. This takes 2 minutes and teaches you the whole custom command system.

**Step 1:** Create the commands directory (if it doesn't exist):
```
"Create the directory .claude/commands/ if it doesn't exist"
```

**Step 2:** Ask Claude Code to create the command:
```
"Create a file .claude/commands/hello.md with these instructions:

Read the CLAUDE.md and README.md (if they exist). 
Then give me a 5-bullet summary:
1. What this project is
2. What tech stack it uses
3. How to run it
4. What the current status is
5. What I should work on next (check git status, recent commits, 
   and any task files)
"
```

**Step 3:** Test it:
```
/hello
```

You just built a custom onboarding command. Every time you open this project, `/hello` catches you up in 10 seconds.

### Part 3: Make it yours
Think of something you do at the start of every session. Maybe:
- Check git status + recent commits
- Read your task list
- Run tests to see what's passing

Turn it into a command. The pattern is always the same: markdown file in `.claude/commands/`, instructions inside, trigger with `/filename`.

## Key Takeaway

Slash commands are pre-built workflows. The built-in ones save time. Custom ones let you encode your team's processes into repeatable, shareable actions.

---

**Next:** [Reading the Output](03-reading-output.md)

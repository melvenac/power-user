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

## Exercise: Command Discovery

1. Open Claude Code and type `/help` — scan the list
2. Try `/compact` after a long conversation — notice how it frees up space
3. If you're in a git repo, try `/review` — see the structured output

Then ask:
```
"What custom commands are available in this project?"
```

Claude Code will check `.claude/commands/` and tell you.

## Key Takeaway

Slash commands are pre-built workflows. The built-in ones save time. Custom ones let you encode your team's processes into repeatable, shareable actions.

---

**Next:** [Reading the Output](03-reading-output.md)

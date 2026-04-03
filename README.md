# Power User: Claude Code Training

A hands-on training program for becoming a Claude Code power user — from first install to multi-agent workflows.

## Who This Is For

- **You**, if you're new to Claude Code or want to level up
- Built by Aaron (Tarrant County Makerspace) from real-world experience shipping production apps
- Teaches principles that apply across tech stacks, with guided paths for common setups

## Quick Start

### One command does everything

The setup script installs all dependencies, clones this curriculum to `~/Projects/power-user`, and opens VS Code — ready to go.

**Windows** — open PowerShell (`Win + X` -> click Terminal), then paste each command:

Download the script:
```powershell
irm https://raw.githubusercontent.com/melvenac/power-user/master/scripts/setup.ps1 -OutFile setup.ps1
```

Run it:
```powershell
powershell -ExecutionPolicy Bypass -File setup.ps1
```
> Don't know what PowerShell is? It's the command-line app built into every Windows PC. See [Lesson 00](curriculum/00-getting-started/00-setup.md) for a full walkthrough.

**Mac / Linux** (open Terminal):
```bash
curl -fsSL https://raw.githubusercontent.com/melvenac/power-user/master/scripts/setup.sh | bash
```

When VS Code opens, follow these steps carefully:

1. **Set your terminal to Git Bash** *(Windows only)*
   - Press `Ctrl+Shift+P` (opens a search bar at the top of VS Code)
   - Type `Terminal: Select Default Profile` and click it
   - Select **Git Bash** from the list

2. **Open a terminal**
   - Press `` Ctrl + ` `` (backtick -- the key above Tab, left of the 1 key)
   - A panel slides up from the bottom -- this is your terminal
   - It should say "bash" in the top-right corner. If it says "powershell", redo step 1

3. **Launch Claude Code**
   - Type `claude` and press Enter
   - **Theme:** Use arrow keys to pick Dark (or your preference), press Enter
   - **Terms:** Press Enter to accept the terms of service
   - **Login:** Your browser opens automatically -- sign in or create an Anthropic account
   - **Subscription required:** You need Claude Pro ($20/month) or Claude Max. Claude Pro is fine for learning.
   - Once subscribed, go back to VS Code -- Claude Code connects automatically

4. **Start learning**
   - Type `/exit` to close Claude Code for now
   - Open the file `curriculum/00-getting-started/00-setup.md` in VS Code and start reading

**Already have Git, Node.js, and VS Code?** Just clone and go:
```bash
git clone https://github.com/melvenac/power-user.git ~/Projects/power-user
code ~/Projects/power-user
```

**Prefer manual setup?** Follow the step-by-step guide in [Lesson 00: Setup](curriculum/00-getting-started/00-setup.md).

**Never used a terminal before?** Follow the [Visual Setup Guide](curriculum/00-getting-started/visual-setup-guide.md) -- every step has a screenshot.

## Philosophy

1. **Learn by doing** — every lesson has exercises you run inside Claude Code
2. **Two gears** — learn when to ask (thinking) vs. when to command (doing)
3. **Opinionated but open** — we teach a proven stack and explain *why*, but every concept maps to whatever you're building
4. **Progressive** — start with basics, unlock advanced patterns as they make sense

## Curriculum

| Module | Topic | Level |
|--------|-------|-------|
| 00 | [Getting Started](curriculum/00-getting-started/) | Beginner |
| 01 | [Fundamentals](curriculum/01-fundamentals/) | Beginner |
| 02 | [Configuration & CLAUDE.md](curriculum/02-configuration/) | Intermediate |
| 03 | [MCP & Tools](curriculum/03-mcp-and-tools/) | Intermediate |
| 04 | [Memory & Context](curriculum/04-memory-and-context/) | Intermediate |
| 05 | [Multi-Agent Work](curriculum/05-multi-agent/) | Advanced |
| 06 | [Skills & Hooks](curriculum/06-skills-and-hooks/) | Advanced |
| 07 | [Building Your Stack](curriculum/07-building-your-stack/) | Advanced |
| 08 | [The Framework](curriculum/08-the-framework/) | Capstone |

**New to development?** Check the [Glossary](curriculum/glossary.md) for definitions of terms like git, CLI, MCP, bash, and more.

### Module Overview

**Beginner (Modules 00-01):**
- **00 Getting Started:** Dev environment setup, VS Code orientation, understanding AI tools (Claude vs ChatGPT vs Cursor), what Claude Code is, installation & first bootstrap, your first real task
- **01 Fundamentals:** Terminal vs chat, core tools, commands, reading output, two-gear prompting, context window & /compact

**Intermediate (Modules 02-04):**
- **02 Configuration:** CLAUDE.md layers, settings & permissions (with real-world config walkthrough), the .agents/ framework, /bootstrap
- **03 MCP & Tools:** What MCP is, your first MCP server, practical servers, the tool ecosystem
- **04 Memory & Context:** How memory works, memory layers, context management, persistent knowledge

**Advanced (Modules 05-07):**
- **05 Multi-Agent:** Why multi-agent, the Agent tool, task decomposition, agent teams
- **06 Skills & Hooks:** Custom commands, hooks, skills, the automation layer
- **07 Building Your Stack:** Choosing a stack, Aaron's stack (Next.js + Convex), other paths, your journey

**Capstone (Module 08):** Four guided sessions building a real project with the Self-Improving Agent framework — /start, /end, /sync, /test, and skills that emerge from your work.

## Stack Paths

Choose your track based on what you're building:

- **Web Development** — Next.js + Convex + Vercel (Aaron's stack, covered in Module 07)
- **Local / CLI Workflows** — Python, automation, scripting

## Prerequisites

| Tool | Version | How to Get It |
|------|---------|--------------|
| Git | 2.x+ | [git-scm.com](https://git-scm.com) or run the setup script |
| Node.js | 18+ | [nodejs.org](https://nodejs.org) (LTS) or run the setup script |
| VS Code | Latest | [code.visualstudio.com](https://code.visualstudio.com) or run the setup script |
| GitHub account | — | [github.com/signup](https://github.com/signup) (free) |
| GitHub CLI | Latest | [cli.github.com](https://cli.github.com) or run the setup script |
| Claude Code | Latest | `npm install -g @anthropic-ai/claude-code` |
| Claude account | — | [claude.ai](https://claude.ai) (Pro, Max, or API key) |

**Windows users:** Set VS Code's default terminal to Git Bash (Ctrl+Shift+P -> "Terminal: Select Default Profile" -> Git Bash). Claude Code uses bash, not PowerShell.

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `'git' is not recognized` | Restart terminal. Reinstall Git with "Add to PATH" |
| `'node' is not recognized` | Restart terminal. Reinstall Node.js |
| `'claude' is not recognized` | Add npm global bin to PATH: `npm bin -g` |
| Wrong terminal (PowerShell) | Set VS Code default to Git Bash (see above) |
| Norton/McAfee blocked the script | Use the two-step install above, or [allow the script in your antivirus](curriculum/00-getting-started/00-setup.md#troubleshooting-antivirus-false-positives) |
| Setup script fails | Follow [manual install steps](curriculum/00-getting-started/00-setup.md#option-b-manual-install-step-by-step) |

## Feedback

Found something confusing? Have a suggestion? Inside Claude Code, run:

```
/feedback
```

This creates a GitHub issue directly from your session. Your feedback improves the curriculum for everyone — it's a self-improving loop.

Or [open an issue manually](https://github.com/melvenac/power-user/issues).

## Status

Public v1.0.0 — full curriculum complete. Iterating on exercises and real-user feedback.

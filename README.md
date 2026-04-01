# Power User: Claude Code Training

A hands-on training program for becoming a Claude Code power user — from first install to multi-agent workflows.

## Who This Is For

- **You**, if you're new to Claude Code or want to level up
- Built by Aaron (Tarrant County Makerspace) from real-world experience shipping production apps
- Teaches principles that apply across tech stacks, with guided paths for common setups

## Quick Start

### One command does everything

The setup script installs all dependencies, clones this curriculum to `~/Projects/power-user`, and opens VS Code — ready to go.

**Windows** (open PowerShell):
```powershell
powershell -ExecutionPolicy Bypass -c "irm https://raw.githubusercontent.com/melvenac/power-user/master/scripts/setup.ps1 | iex"
```

**Mac / Linux** (open Terminal):
```bash
curl -fsSL https://raw.githubusercontent.com/melvenac/power-user/master/scripts/setup.sh | bash
```

When VS Code opens:
1. Set default terminal to Git Bash *(Windows only: Ctrl+Shift+P → "Terminal: Select Default Profile" → Git Bash)*
2. Open a terminal (`Ctrl + ~`)
3. Type `claude` and follow the authentication prompts
4. Start reading: `curriculum/00-getting-started/00-setup.md`

**Already have Git, Node.js, and VS Code?** Just clone and go:
```bash
git clone https://github.com/melvenac/power-user.git ~/Projects/power-user
code ~/Projects/power-user
```

**Prefer manual setup?** Follow the step-by-step guide in [Lesson 00: Setup](curriculum/00-getting-started/00-setup.md).

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
| Claude Code | Latest | `npm install -g @anthropic-ai/claude-code` |
| Claude account | — | [claude.ai](https://claude.ai) (Pro, Max, or API key) |

**Windows users:** Set VS Code's default terminal to Git Bash (Ctrl+Shift+P → "Terminal: Select Default Profile" → Git Bash). Claude Code uses bash, not PowerShell.

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `'git' is not recognized` | Restart terminal. Reinstall Git with "Add to PATH" |
| `'node' is not recognized` | Restart terminal. Reinstall Node.js |
| `'claude' is not recognized` | Add npm global bin to PATH: `npm bin -g` |
| Wrong terminal (PowerShell) | Set VS Code default to Git Bash (see above) |
| Setup script fails | Follow [manual install steps](curriculum/00-getting-started/00-setup.md) |

## Feedback

Found something confusing? Have a suggestion? Inside Claude Code, run:

```
/feedback
```

This creates a GitHub issue directly from your session. Your feedback improves the curriculum for everyone — it's a self-improving loop.

Or [open an issue manually](https://github.com/melvenac/power-user/issues).

## Status

Public v1.0.0 — full curriculum complete. Iterating on exercises and real-user feedback.

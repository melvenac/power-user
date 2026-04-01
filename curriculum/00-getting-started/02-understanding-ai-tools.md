# Lesson 02: Understanding AI Tools

## What's an LLM?

LLM stands for **Large Language Model**. It's the engine behind tools like Claude, ChatGPT, and Gemini. Think of it like this: a car engine doesn't drive itself — it needs a car around it (steering, brakes, wheels). An LLM is the engine. Claude Code is the car.

An LLM is trained on massive amounts of text and code. It learns patterns — how code works, how languages are structured, how problems get solved. When you type a prompt, it predicts the most useful response based on everything it's learned. It's not searching the internet or looking things up in a database — it's reasoning from patterns.

## Claude's Model Family

Claude is made by Anthropic. There are three models in the family, each with different strengths:

| Model | Speed | Capability | Cost | Best For |
|-------|-------|-----------|------|----------|
| **Haiku** | Fastest | Good | Cheapest | Quick tasks, simple questions, high-volume work |
| **Sonnet** | Fast | Great | Moderate | Daily coding, most development work |
| **Opus** | Slower | Best | Highest | Complex reasoning, architecture, multi-step tasks |

Think of it like hiring help:
- **Haiku** is a fast intern — great for simple, repetitive tasks
- **Sonnet** is a solid mid-level developer — handles most work well
- **Opus** is a senior architect — slower but makes better decisions on hard problems

**Claude Code defaults to Opus** because coding tasks benefit from deeper reasoning. When you're asking it to refactor a module, design an architecture, or debug a subtle issue, you want the strongest reasoning available.

**Fast mode** (`/fast` in Claude Code) uses the same Opus model but optimizes for faster output. It doesn't switch to a weaker model — it's the same brain, just quicker responses.

## Why Claude Code?

There are many AI coding tools. Here's an honest comparison:

### Claude Code vs. ChatGPT

| | Claude Code | ChatGPT |
|---|---|---|
| **Interface** | Terminal + VS Code (agent in your environment) | Browser-based chat |
| **File access** | Direct — reads, writes, searches your files | Copy-paste or plugins |
| **Execution** | Runs commands on your machine | Sandboxed (can't touch your files) |
| **Memory** | CLAUDE.md + .agents/ + knowledge base | Limited conversation memory |
| **Best for** | Building and shipping real projects | Learning, research, quick questions |

ChatGPT is great for asking questions and getting explanations. Claude Code is for **doing the work**.

### Claude Code vs. Cursor / GitHub Copilot

| | Claude Code | Cursor / Copilot |
|---|---|---|
| **Approach** | Agent (takes actions, makes decisions) | Autocomplete + chat (suggests code) |
| **Scope** | Full project (files, git, commands, tests) | Current file or selection |
| **Autonomy** | Can work independently on multi-step tasks | Assists you line by line |
| **Best for** | Feature development, refactoring, debugging | Fast inline code completion |

Cursor and Copilot are great **writing assistants** — they help you type code faster. Claude Code is a **working partner** — it handles entire tasks.

You can actually use both: Copilot for fast autocompletion while you type, Claude Code for larger tasks and project-level work.

### Claude Code vs. Lovable / Bolt / Replit

| | Claude Code | Lovable / Bolt / Replit |
|---|---|---|
| **Audience** | Developers (beginner to advanced) | Non-developers and beginners |
| **Output** | Code in your project, your way | Hosted apps with generated code |
| **Control** | Full — you own every file, every decision | Limited — the platform decides |
| **Customization** | Unlimited — any stack, any pattern | Constrained to platform capabilities |
| **Learning** | You learn to code by working with an agent | You get an app without learning to code |
| **Best for** | Building skills + shipping products | Quick prototypes, no-code MVPs |

**Lovable, Bolt, and Replit are great** if you want an app without learning to code. But if you want to **become a developer** — understand what's happening, make your own decisions, build skills that compound — Claude Code is the path.

This curriculum teaches you to be a developer who uses AI as a force multiplier. The other tools build the app for you. The difference matters when you need to customize, debug, scale, or do anything the platform didn't anticipate.

### Claude Code vs. Gemini / Perplexity / Other AI

| Tool | Best For |
|------|---------|
| **Gemini** | Google ecosystem integration, long context research |
| **Perplexity** | Research with citations, finding information |
| **Manus** | Autonomous web tasks, browser-based workflows |
| **Claude (chat)** | Conversations, analysis, writing, brainstorming |
| **Claude Code** | Building software with an AI agent |

These aren't competitors — they're different tools for different jobs. You might use Perplexity to research an API, then use Claude Code to implement it. Use the right tool for the task.

## When NOT to Use Claude Code

Be honest about this:

- **Quick factual questions** → Google, Perplexity, or Claude chat
- **No-code prototype** → Lovable or Bolt
- **Learning a concept** → ChatGPT, Claude chat, or a tutorial
- **Fast inline autocomplete** → Cursor or Copilot
- **Browser automation** → Manus or specialized tools

Claude Code shines when you're **building real software** — writing code, managing projects, shipping features, maintaining codebases. That's where it has no equal.

## What Matters for This Curriculum

You don't need to understand how LLMs work internally to be a power user. What matters:

1. **Claude Code is an agent** — it uses tools, not just generates text
2. **Opus is the default** — strongest reasoning for coding tasks
3. **It works in your environment** — your files, your terminal, your project
4. **It's one tool in your toolkit** — use others where they're stronger

Now let's learn to use it.

---

**Next:** [What Is Claude Code?](03-what-is-claude-code.md)

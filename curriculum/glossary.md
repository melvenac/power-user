# Glossary

Quick definitions for terms used throughout the curriculum. If you see a word you don't recognize, check here.

---

## A

### Agent
A program that can take actions on its own — not just answer questions, but read files, write code, run commands, and make decisions about what to do next. Claude Code is an agent.

### Agent Runtime
The full system that powers an agent — its tools, memory, permissions, and decision-making engine. Think of it as the difference between a brain (the AI model) and a person (brain + hands + memory + rules).

### API (Application Programming Interface)
A way for programs to talk to each other. When Claude Code connects to GitHub or a database, it uses an API. Think of it as a menu at a restaurant — it lists what you can order (request) and what you'll get back (response).

### API Key
A password that lets a program access an API. You need one for Claude Code to connect to Anthropic's servers. Keep these secret — don't share them or commit them to git.

---

## B

### Bash
A command-line shell — the program that interprets what you type in a terminal. It's the default on Mac and Linux, and comes with Git on Windows (Git Bash). Claude Code uses bash.

**Why it matters:** All the commands in this curriculum use bash syntax. On Windows, set VS Code's terminal to Git Bash so everything works.

### Bun
A fast JavaScript runtime that replaces Node.js + npm + Jest + webpack in one tool. Optional — used in Aaron's web stack. [bun.sh](https://bun.sh)

---

## C

### CLI (Command Line Interface)
A text-based way to interact with your computer. Instead of clicking buttons, you type commands. The terminal is where you use CLIs. Claude Code is a CLI tool.

**Why it matters:** Most developer tools are CLIs. Getting comfortable with the terminal is one of the biggest productivity gains for new developers.

### Claude
The AI model made by Anthropic. Claude Code runs on Claude.

### Claude Code
An agent runtime built on Claude that runs in your terminal. It can read, write, search, and execute code — not just chat about it. This is what this entire curriculum teaches.

### CLAUDE.md
A markdown file that gives Claude Code instructions for your project. It's loaded automatically every session. Think of it as a briefing document for a new team member.

### Context Window
Claude's working memory — everything in the current conversation (your messages, responses, file contents, tool outputs). It has a fixed size. When it fills up, older information gets compressed or dropped. Managing context is a core power user skill.

### Commit
A saved snapshot of your code changes in git. Like a save point in a video game — you can always go back to it.

### Convex
A backend platform that provides a real-time database and serverless functions. Used in Aaron's web stack. No server to manage. [convex.dev](https://convex.dev)

---

## D

### Dependency
A package or library that your project needs to work. When you `npm install`, you're downloading dependencies.

### Deploy
Putting your code on a server so other people can use it. "Deploying to production" means making it live for real users.

---

## E

### Environment Variable
A value stored on your computer (not in your code) that programs can read. Used for API keys, configuration, and secrets. Example: `GITHUB_TOKEN=ghp_abc123`.

---

## F

### Framework
A structured set of tools and conventions that help you build something. React is a UI framework. The Self-Improving Agent is a development framework. This curriculum teaches both kinds.

---

## G

### Git
A version control system — it tracks every change you make to your code. You can go back to any previous version, work on multiple features at once (branches), and collaborate with others.

**Why use it:** Without git, one bad change can destroy your work. With git, you can always undo. It's also required for GitHub, which is where most open-source code lives.

### GitHub
A website that hosts git repositories (your code). It adds collaboration features: pull requests, issues, code review. Think of git as the tool and GitHub as the cloud service built on top of it. [github.com](https://github.com)

### GitHub CLI (gh)
A command-line tool for interacting with GitHub without opening a browser. Create issues, pull requests, and manage repos from your terminal.

### Glob
A pattern for matching file names. `*.js` matches all JavaScript files. `src/**/*.tsx` matches all .tsx files anywhere under src/. Claude Code uses globs to find files.

### Grep
A tool for searching inside files. "Grep for `handleLogin`" means "find every file that contains the text `handleLogin`." Claude Code uses this constantly.

---

## H

### Hook
A script that runs automatically when something happens. In Claude Code, hooks fire on events like session start, session end, or before/after a tool runs. Like a trigger in a video game — "when X happens, do Y."

---

## I

### IDE (Integrated Development Environment)
A program for writing code that includes a text editor, terminal, debugger, and other tools. VS Code is an IDE.

---

## J

### JSON (JavaScript Object Notation)
A data format that looks like this: `{ "name": "Aaron", "role": "developer" }`. Used everywhere — settings files, APIs, configuration. You'll edit `settings.json` files in Claude Code.

---

## L

### LTS (Long Term Support)
A version of software that's supported and updated for a long time. When installing Node.js, always pick the LTS version — it's the stable one.

---

## M

### Markdown
A simple formatting language. `# Heading`, `**bold**`, `- bullet point`. This curriculum, CLAUDE.md, and most documentation is written in markdown. Files end in `.md`.

### MCP (Model Context Protocol)
A standard way for AI tools to connect to external systems. Like USB for AI — plug any tool into any agent. MCP servers give Claude Code new capabilities (database access, API connections, etc.).

### MCP Server
A small program that exposes tools to Claude Code via MCP. Example: a database MCP server lets Claude Code query your database directly.

---

## N

### Node.js
A JavaScript runtime — it lets you run JavaScript outside of a web browser. Claude Code is built with Node.js, which is why you need it installed.

### npm (Node Package Manager)
The tool that installs JavaScript packages (libraries, tools, dependencies). Comes with Node.js. `npm install` downloads everything your project needs.

---

## O

### Open Source
Software whose code is publicly available. Anyone can read, use, and contribute to it. Most developer tools are open source.

---

## P

### Package
A reusable bundle of code. When you `npm install react`, you're downloading the React package. Packages have versions (1.0.0, 2.3.1, etc.).

### PATH
A list of directories your terminal searches when you type a command. If you type `git` and get "not recognized," it means the directory containing `git.exe` isn't in your PATH. This is the #1 Windows setup issue.

### Plugin
An extension that adds capabilities to Claude Code. Installed from marketplaces (GitHub repos). Plugins teach Claude Code new skills and workflows.

### PR (Pull Request)
A request to merge your code changes into a project. On GitHub, PRs are how teams review and discuss code before it goes into the main branch.

### Prompt
What you type to Claude Code. Can be a question, a command, or a description of what you want done.

---

## R

### Repository (Repo)
A folder tracked by git. Contains your code, its history, and configuration. GitHub hosts remote copies of your repos.

### Runtime
The program that executes your code. Node.js is a JavaScript runtime. Bun is a faster alternative. Claude Code runs on a runtime too.

---

## S

### Sandbox
An isolated environment where code runs without affecting your main system. Context-mode uses a sandbox to process large outputs without filling your context window.

### Settings (settings.json)
Claude Code's configuration file. Controls permissions, hooks, environment variables, plugins, and MCP servers. Lives at `~/.claude/settings.json` (global) or `.claude/settings.json` (per project).

### Slash Command
A command you type starting with `/`. Examples: `/start`, `/end`, `/help`, `/compact`. Some are built-in, others are custom (from `.claude/commands/`).

### Skill
A reusable set of knowledge and patterns that Claude Code applies automatically when relevant. More than a command — a skill includes domain expertise, decision-making rules, and examples.

---

## T

### Terminal
The application where you type commands. On Windows: Windows Terminal or the VS Code integrated terminal. On Mac: Terminal.app or iTerm2. This is where Claude Code runs.

### Token
The unit Claude uses to measure text. Roughly 4 characters = 1 token. Your context window is measured in tokens. Every file read, command output, and message costs tokens.

### TypeScript
JavaScript with type safety — you declare what types your variables and functions expect. Catches bugs at compile time instead of runtime. Used in Aaron's stack.

---

## V

### Vercel
A cloud platform for deploying web applications. Push code to GitHub, Vercel deploys it automatically. Optimized for Next.js. [vercel.com](https://vercel.com)

### VS Code (Visual Studio Code)
A free code editor by Microsoft. Lightweight but powerful — supports extensions, integrated terminal, debugging, and git. The recommended editor for this curriculum. [code.visualstudio.com](https://code.visualstudio.com)

---

## W

### winget
Windows package manager (built into Windows 10/11). Like an app store for the terminal: `winget install Git.Git`. The setup script uses it to install dependencies.

---

## Terms You'll See in This Curriculum

| Term | Short Definition |
|------|-----------------|
| `/bootstrap` | Command that sets up CLAUDE.md + .agents/ for a new project |
| `/start` | Command that loads project state at the beginning of a session |
| `/end` | Command that saves project state at the end of a session |
| `/sync` | Command that validates doc consistency before committing |
| `.agents/` | Directory containing project state, tasks, and session history |
| Context-mode | Plugin that sandboxes large outputs to save context window |
| Open Brain | Knowledge MCP server for persistent memory across sessions |
| Self-Improving Agent | The framework taught in Module 08 — persistent memory, skills, feedback loops |

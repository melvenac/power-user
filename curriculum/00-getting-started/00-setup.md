# Lesson 00: Setting Up Your Dev Environment

## Before You Start

This lesson gets your machine ready for Claude Code. If you've already got Git, Node.js, VS Code, and Claude Code installed — skip to [What Is Claude Code?](02-what-is-claude-code.md).

If not, read on. We'll get you from zero to ready in about 15 minutes.

## What You Need

| Tool | What It Does | Required? |
|------|-------------|-----------|
| **Git** | Version control — tracks your code changes | Yes |
| **Node.js 18+** | JavaScript runtime — runs Claude Code | Yes |
| **VS Code** | Code editor with integrated terminal | Yes |
| **Claude Code** | The AI agent you're learning to use | Yes |
| **Bun** | Fast JS runtime (Aaron's stack) | Optional |
| **GitHub CLI** | Git operations from the terminal | Optional |

## Option A: The Setup Script (Recommended)

We have setup scripts for all platforms that check everything and install what's missing.

### Windows

Open PowerShell (`Win + X` → Terminal):

```powershell
powershell -ExecutionPolicy Bypass -c "irm https://raw.githubusercontent.com/melvenac/power-user/master/scripts/setup.ps1 | iex"
```

### Mac / Linux

Open Terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/melvenac/power-user/master/scripts/setup.sh | bash
```

**Mac note:** The script installs [Homebrew](https://brew.sh) if you don't have it — that's Mac's package manager.

**Linux note:** Supports apt (Ubuntu/Debian), dnf (Fedora), and pacman (Arch).

### After the script runs:

1. **Restart your terminal** (loads new PATH entries)
2. **Run the script again** — everything should show `[OK]`
3. If anything failed, follow the manual steps below

---

## Option B: Manual Install (Step by Step)

If the script didn't work, or you want to understand what's being installed:

### 1. Install Git

**Download:** https://git-scm.com/download/win

During installation:
- **IMPORTANT:** Select "Add to PATH" when asked
- Accept all other defaults

**Verify:** Open a new terminal and type:
```bash
git --version
```
You should see `git version 2.x.x`. If you get "not recognized", Git isn't in your PATH — restart your terminal.

### 2. Install Node.js

**Download:** https://nodejs.org — click the **LTS** (Long Term Support) button

During installation:
- Accept all defaults
- The installer adds Node.js and npm to your PATH

**Verify:**
```bash
node --version
npm --version
```
You should see `v22.x.x` (or 18+) and `10.x.x`. If not, restart your terminal.

### 3. Install VS Code

**Download:** https://code.visualstudio.com

During installation:
- Check "Add to PATH" when offered
- Check "Add 'Open with Code' to context menu" (convenient)

**Verify:**
```bash
code --version
```

### 4. Install Claude Code

With Node.js installed, run:
```bash
npm install -g @anthropic-ai/claude-code
```

**Verify:**
```bash
claude --version
```

If you get "not recognized", npm's global bin directory isn't in your PATH. Fix it:
```bash
# Find where npm installs global packages
npm bin -g

# Add that path to your system PATH
# (Google "add to PATH windows" if you're not sure how)
```

### 5. Install Bun (Optional)

Only needed if you're following Aaron's web stack (Module 07+).

```powershell
powershell -c "irm bun.sh/install.ps1 | iex"
```

**Verify:**
```bash
bun --version
```

### 6. Install GitHub CLI (Optional)

Recommended for easier Git operations.

```bash
winget install GitHub.cli
```

After install, authenticate:
```bash
gh auth login
```

---

## Configure VS Code for Claude Code

This step is critical and often missed:

### Set Default Terminal to Git Bash

VS Code defaults to PowerShell on Windows, but Claude Code uses bash. Fix this:

1. Open VS Code
2. Press `Ctrl + Shift + P` (opens command palette)
3. Type: `Terminal: Select Default Profile`
4. Select: **Git Bash**

Now every new terminal in VS Code will be bash. This means:
- Claude Code works correctly
- All curriculum commands work as written
- You learn bash (works on Mac/Linux too)

### Install the Claude Code Extension (Optional)

1. Open VS Code
2. Press `Ctrl + Shift + X` (extensions panel)
3. Search: `Claude Code`
4. Install the Anthropic extension

This gives you Claude Code in the VS Code sidebar instead of (or in addition to) the terminal.

---

## Verify Everything

Open VS Code, open a terminal (`Ctrl + ~`), and run each command:

```bash
git --version        # Should show: git version 2.x.x
node --version       # Should show: v18.x.x or higher
npm --version        # Should show: 10.x.x or similar
claude --version     # Should show: Claude Code version
```

**All four work?** You're ready. Move to [What Is Claude Code?](02-what-is-claude-code.md)

**Something failed?** The most common issues:

| Error | Fix |
|-------|-----|
| `'git' is not recognized` | Restart terminal. If still broken, reinstall Git with "Add to PATH" checked |
| `'node' is not recognized` | Restart terminal. If still broken, reinstall Node.js |
| `'claude' is not recognized` | Run `npm bin -g` and add that directory to your system PATH |
| PowerShell instead of bash | Follow "Set Default Terminal to Git Bash" above |
| Permission errors with npm | Run PowerShell as Administrator for the npm install step |

---

## Troubleshooting: The PATH Problem

Most Windows setup issues come down to PATH — the list of directories your terminal searches for commands.

**What PATH is:** When you type `git`, your terminal looks through every directory in PATH until it finds `git.exe`. If the directory containing `git.exe` isn't in PATH, you get "not recognized."

**How to fix it:**
1. Press `Win + S`, search "Environment Variables"
2. Click "Edit the system environment variables"
3. Click "Environment Variables" button
4. Under "User variables", find `Path`, click Edit
5. Click "New" and add the missing directory
6. Click OK everywhere, restart your terminal

**Common paths to add:**
- Git: `C:\Program Files\Git\cmd`
- Node.js: `C:\Program Files\nodejs`
- npm global: `C:\Users\YourName\AppData\Roaming\npm`

---

**Next:** [Navigating VS Code](01-vscode-orientation.md)

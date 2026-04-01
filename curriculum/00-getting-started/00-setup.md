# Lesson 00: Setting Up Your Dev Environment

## Before You Start

This lesson gets your machine ready for Claude Code. If you've already got Git, Node.js, VS Code, GitHub CLI, and Claude Code installed — skip to [What Is Claude Code?](03-what-is-claude-code.md).

If not, read on. We'll get you from zero to ready in about 15 minutes.

## What You Need

| Tool | What It Does | Required? |
|------|-------------|-----------|
| **Git** | Version control — tracks your code changes | Yes |
| **Node.js 18+** | JavaScript runtime — runs Claude Code | Yes |
| **VS Code** | Code editor with integrated terminal | Yes |
| **GitHub account** | Where your code lives — signup at [github.com](https://github.com) | Yes |
| **GitHub CLI** | GitHub from the terminal — needed for feedback and git workflow | Yes |
| **Claude Code** | The AI agent you're learning to use | Yes |
| **Bun** | Fast JS runtime (Aaron's stack) | Optional |

## Option A: The Setup Script (Recommended)

We have setup scripts for all platforms that check everything and install what's missing.

### Windows

First, open **PowerShell** — this is the command-line app built into every Windows PC. It's where you type commands instead of clicking buttons. Here's how to find it:

1. Press `Win + X` (the Windows key + X at the same time)
2. Click **Terminal** or **Windows PowerShell** from the menu that appears
3. A dark window with a blinking cursor opens — that's PowerShell

> **What is this?** PowerShell is like a text-based remote control for your computer. Instead of clicking through menus, you type instructions. It looks intimidating, but you'll only need it for this one setup step — after that, you'll use VS Code's built-in terminal for everything.

Now paste these two lines, one at a time, pressing Enter after each:

```powershell
irm https://raw.githubusercontent.com/melvenac/power-user/master/scripts/setup.ps1 -OutFile setup.ps1
powershell -ExecutionPolicy Bypass -File setup.ps1
```

> **Why two steps?** Running `irm | iex` (download-and-execute in one line) triggers false positives in Norton, McAfee, and other antivirus software. Downloading first, then running locally, avoids this. See [Antivirus False Positives](#troubleshooting-antivirus-false-positives) below if you hit this.

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

### 6. Create a GitHub Account

If you don't have a GitHub account, create one now — it's free and you'll need it for:
- **Cloning the curriculum** (the setup script does this automatically)
- **Submitting feedback** (the `/feedback` command creates GitHub issues)
- **Storing your own projects** (every developer uses GitHub)

**How to sign up:**
1. Go to [github.com](https://github.com) and click **Sign up**
2. Enter your email, create a password, choose a username
3. Verify your email (check your inbox)
4. That's it — you have a GitHub account

**Pick a good username** — this becomes your developer identity. Use something professional-ish (your name, a handle you like). You can't easily change it later.

### 7. Install GitHub CLI & Authenticate

The GitHub CLI (`gh`) lets you interact with GitHub from your terminal — no browser needed. It's how the `/feedback` command works.

```bash
winget install GitHub.cli
```

After install, connect it to your account:
```bash
gh auth login
```

It will walk you through:
1. **Where to log in?** → `GitHub.com`
2. **Protocol?** → `HTTPS`
3. **Authenticate?** → `Login with a web browser`
4. It opens your browser, you confirm, done.

**Verify it worked:**
```bash
gh auth status
```
You should see your username and "Logged in to github.com."

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

**All four work?** You're ready. Move to [What Is Claude Code?](03-what-is-claude-code.md)

**Something failed?** The most common issues:

| Error | Fix |
|-------|-----|
| `'git' is not recognized` | Restart terminal. If still broken, reinstall Git with "Add to PATH" checked |
| `'node' is not recognized` | Restart terminal. If still broken, reinstall Node.js |
| `'claude' is not recognized` | Run `npm bin -g` and add that directory to your system PATH |
| PowerShell instead of bash | Follow "Set Default Terminal to Git Bash" above |
| Permission errors with npm | Run PowerShell as Administrator for the npm install step |
| Norton/McAfee blocked the script | See [Antivirus False Positives](#troubleshooting-antivirus-false-positives) below |

---

## Troubleshooting: Antivirus False Positives

Norton, McAfee, Windows Defender, and other antivirus software sometimes block the setup script. This is a **false positive** — the script just installs developer tools, but antivirus sees "PowerShell downloading code from the internet" and flags it.

**What the warnings look like:**
- Norton: "IDP.AMSI.49 — Command line detection" or "AMSI:HttpRequest-inf [Susp]"
- McAfee: "Suspicious PowerShell activity blocked"
- Windows Defender: "Potentially unwanted app" or "Script blocked by AMSI"

**How to fix it:**

1. **Use the two-step install** (recommended — avoids the trigger entirely):
   ```powershell
   irm https://raw.githubusercontent.com/melvenac/power-user/master/scripts/setup.ps1 -OutFile setup.ps1
   powershell -ExecutionPolicy Bypass -File setup.ps1
   ```

2. **If the downloaded script is still blocked**, temporarily allow it:
   - **Norton:** Open Norton → History → find the blocked item → Restore / Allow
   - **McAfee:** Open McAfee → Quarantined Items → Restore the script
   - **Windows Defender:** Windows Security → Virus & threat protection → Protection history → Allow

3. **If antivirus keeps interfering**, skip the script entirely and follow [Option B: Manual Install](#option-b-manual-install-step-by-step) instead. Every tool the script installs can be installed by hand.

**Why this happens:** Antivirus tools use AMSI (Antimalware Scan Interface) to inspect PowerShell commands. Patterns like downloading + executing scripts, or using `Invoke-Expression`, trigger heuristic detections — even when the script is harmless. This affects many legitimate developer tools, not just ours.

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


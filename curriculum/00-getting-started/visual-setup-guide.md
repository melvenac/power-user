# Visual Setup Guide: Zero to Claude Code

This guide walks you through every click, from a fresh Windows PC to your first Claude Code conversation. Follow the screenshots step by step.

> **Already comfortable with terminals and VS Code?** Skip this and go straight to [00-setup.md](00-setup.md).

---

## Part 1: Open PowerShell

PowerShell is the command-line app built into every Windows PC. You only need it for this one setup step.

**Press `Win + X`** (hold the Windows key and tap X). A menu appears in the bottom-left corner of your screen.

![Right-click the Start button or press Win+X. A menu appears with system tools. Click "Terminal" or "Windows PowerShell".](images/01-winx-menu.png)

**Click "Terminal"** (or "Windows PowerShell" on older Windows 10). A dark window with a blinking cursor opens. That's PowerShell.

![PowerShell window open with a blinking cursor, showing something like "PS C:\Users\YourName>".](images/02-powershell-open.png)

---

## Part 2: Download and Run the Setup Script

You're going to paste two commands. Each one goes on its own line.

### Download the script

Click inside the PowerShell window, **paste this command** (right-click to paste), and press **Enter**:

```powershell
irm https://raw.githubusercontent.com/melvenac/power-user/master/scripts/setup.ps1 -OutFile setup.ps1
```

![PowerShell window showing the download command pasted and executed. No output means it worked.](images/03-download-script.png)

> **Nothing happened?** That's normal. The command downloaded a file silently. If you see a red error, check your internet connection and try again.

### Run the script

Now paste this command and press **Enter**:

```powershell
powershell -ExecutionPolicy Bypass -File setup.ps1
```

![PowerShell running the setup script. You can see it checking for Git, Node.js, VS Code, and other tools, with colored status messages.](images/04-script-running.png)

The script checks your system and installs what's missing. This takes a few minutes. You'll see colored status messages as it works.

### Script results

When it finishes, you'll see a results table showing what passed, what was installed, and what needs attention.

![Setup results showing [OK], [NEW], or status for each tool: Git, Node.js, npm, VS Code, Claude Code, GitHub CLI, Curriculum.](images/05-script-results.png)

> **Got warnings or failures?** The script tells you exactly what to do. Most issues are fixed by restarting your terminal and running the script again. See [troubleshooting](00-setup.md#troubleshooting-the-path-problem) if you're stuck.

---

## Part 3: Open VS Code

If the script succeeded, it opens VS Code automatically. If not, find **Visual Studio Code** in your Start menu.

![VS Code opening for the first time. You may see a Welcome tab and the Get Started page.](images/06-vscode-first-open.png)

> **First time?** VS Code may show a Welcome tab or ask about themes. You can close the Welcome tab -- we'll set up what matters next.

---

## Part 4: Set Your Terminal to Git Bash

This is the most important configuration step. Claude Code needs bash, but VS Code defaults to PowerShell on Windows. We're changing that now.

### Open the Command Palette

**Press `Ctrl + Shift + P`** (hold Control and Shift, then tap P). A search bar drops down from the top of VS Code.

![VS Code with the Command Palette open -- a search bar at the top of the window with a ">" prompt.](images/07-command-palette.png)

### Search for the terminal setting

**Type:** `Terminal: Select Default Profile`

Click the matching result when it appears.

![Command Palette showing "Terminal: Select Default Profile" as a search result, ready to click.](images/08-search-terminal-profile.png)

### Select Git Bash

A list of terminal options appears. **Click "Git Bash"**.

![List of terminal profiles including PowerShell, Command Prompt, Git Bash, etc. Git Bash is highlighted.](images/09-select-git-bash.png)

> **Don't see Git Bash?** The Git installation may not have finished. Close everything, restart your PC, and try again.

---

## Part 5: Open a Terminal

Now let's open a terminal inside VS Code.

**Press `` Ctrl + ` ``** -- that's the **backtick** key. It's above the Tab key, to the left of the 1 key. (It shares a key with the tilde ~ character.)

A panel slides up from the bottom of VS Code. This is your **integrated terminal**.

![VS Code with the terminal panel open at the bottom. The terminal shows a bash prompt. In the top-right corner of the terminal panel, it says "bash".](images/10-terminal-open-bash.png)

**Check the top-right corner of the terminal panel.** It should say **"bash"**. If it says "powershell", go back to Part 4 and try again.

> **Why does this matter?** Claude Code and all the curriculum commands are written for bash. If you're running PowerShell, commands will fail or behave differently.

---

## Part 6: Launch Claude Code

In the terminal, **type `claude` and press Enter**.

![Terminal showing "claude" typed at the bash prompt.](images/11-type-claude.png)

Claude Code starts up and shows a welcome screen.

### Pick a theme

Claude Code asks you to choose a color theme. **Use your arrow keys** to highlight your choice (Dark is recommended), then **press Enter**.

![Claude Code's theme selection screen showing Light, Dark, and other options. Dark is highlighted.](images/12-theme-selection.png)

### Accept the terms

Read through the terms of service. **Press Enter** (or type Y) to accept.

![Claude Code showing terms of service with a prompt to accept.](images/13-terms-of-service.png)

### Sign in

Claude Code opens your web browser to the Anthropic login page.

![Browser opening to the Anthropic login/signup page.](images/14-browser-login.png)

**If you already have an Anthropic account:** Sign in with your email and password. Skip to Part 7 step 5.

**If you're new:** Click **Sign up** and follow the next section.

---

## Part 7: Create Your Anthropic Account and Subscribe

1. **Enter your email** and create a password

![Anthropic signup page with email and password fields.](images/15-signup-page.png)

2. **Verify your email** -- check your inbox for a confirmation link and click it

3. **Choose a subscription plan.** Claude Code requires a paid plan:
   - **Claude Pro ($20/month)** -- this is all you need for learning. Start here.
   - **Claude Max ($100 or $200/month)** -- more usage, upgrade later if you want it

![Anthropic subscription page showing Pro and Max plan options.](images/16-subscription-plans.png)

4. **Enter your payment info** and confirm

5. **Your browser shows a success message.** You can close the browser tab and go back to VS Code.

![Success page in the browser after subscribing, with a message like "You're all set".](images/17-subscription-success.png)

6. **Back in VS Code**, Claude Code should now be connected. You'll see its chat interface in the terminal.

![Claude Code connected and ready in the VS Code terminal, showing the chat prompt.](images/18-claude-connected.png)

---

## Part 8: Test It

Type a quick message to make sure everything works:

```
hello, are you working?
```

![Claude Code responding to "hello, are you working?" with a friendly reply.](images/19-first-message.png)

**Claude responded?** You're all set!

Now type `/exit` to close Claude Code for now.

---

## Part 9: Start the Curriculum

You're ready to learn. Open the first lesson:

1. In VS Code's file explorer (left sidebar), navigate to:
   `curriculum/00-getting-started/00-setup.md`

![VS Code file explorer showing the curriculum folder structure, with 00-setup.md highlighted.](images/20-open-first-lesson.png)

2. Click the file to open it
3. Start reading -- the curriculum takes it from here

---

## Quick Reference

Once you're set up, this is your daily workflow:

1. Open VS Code
2. Open a terminal (`` Ctrl + ` ``)
3. Navigate to your project folder
4. Type `claude` to start Claude Code
5. Start working

---

## Something Went Wrong?

| What happened | What to do |
|--------------|------------|
| PowerShell won't open | Search "PowerShell" in the Start menu |
| Script shows red errors | Read the error message -- it usually tells you what's wrong. Try restarting and running again |
| VS Code didn't open | Find it in your Start menu (search "Visual Studio Code") |
| Terminal says "powershell" not "bash" | Redo Part 4 (set default terminal to Git Bash) |
| `claude` says "not recognized" | Close the terminal, open a new one, try again. If still broken, see [PATH troubleshooting](00-setup.md#troubleshooting-the-path-problem) |
| Browser didn't open for login | Copy the URL from the terminal and paste it into your browser |
| "Subscription required" error | Go to [claude.ai](https://claude.ai) and subscribe to Pro ($20/month) |
| Can't find the curriculum files | In VS Code: File -> Open Folder -> `C:\Users\YourName\Projects\power-user` |

**Still stuck?** Ask in the Makerspace group or [open an issue](https://github.com/melvenac/power-user/issues).

---

**Next:** [00-setup.md](00-setup.md) (the full setup reference) or [01-vscode-orientation.md](01-vscode-orientation.md) (learn VS Code)

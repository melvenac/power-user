# Lesson 01: Navigating VS Code

## Why VS Code?

VS Code is where you'll spend most of your time. It's a code editor, terminal, chat interface, and file browser all in one window. Before we touch Claude Code, let's get comfortable with VS Code itself.

## Opening VS Code

### Opening a Project Folder (Important!)

Always open VS Code **in a project folder**, not just the application by itself.

**Why this matters:** When you open a specific folder, VS Code (and Claude Code) knows the context — it can see all your files, understand the project structure, and work within that scope. Opening VS Code without a folder is like opening a filing cabinet without knowing which drawer to look in.

**How to open a project folder:**

Option A — From the terminal:
```bash
cd ~/Projects/my-project
code .
```
The `.` means "open this folder."

Option B — From VS Code:
1. Open VS Code
2. `File` → `Open Folder...` (or `Ctrl + K, Ctrl + O`)
3. Navigate to your project folder
4. Click "Select Folder"

Option C — From File Explorer:
Right-click a folder → "Open with Code" (if you enabled this during VS Code installation)

### Project Folder vs. User Folder

| What you open | What happens |
|---------------|-------------|
| `~/Projects/my-project` | VS Code sees only this project. Claude Code is scoped here. This is correct. |
| `~/Projects` | VS Code sees ALL your projects. Too broad — Claude Code won't know which one to focus on. |
| `~/` (home folder) | VS Code sees everything. Way too broad. Don't do this for project work. |

**Rule of thumb:** One project = one VS Code window.

---

## The VS Code Layout

When you open VS Code, you'll see several areas. Here's the map:

```
┌─────────────────────────────────────────────────────┐
│  Menu Bar (File, Edit, View, etc.)                  │
├────────┬────────────────────────────────────────────┤
│        │                                            │
│  Side  │                                            │
│  Bar   │            Editor Area                     │
│        │       (where you read/write code)          │
│ (files,│                                            │
│ search,│                                            │
│ etc.)  │                                            │
│        │                                            │
│        ├────────────────────────────────────────────┤
│        │                                            │
│        │            Panel (Terminal, Output)         │
│        │                                            │
├────────┴────────────────────────────────────────────┤
│  Status Bar (branch name, errors, line number)      │
└─────────────────────────────────────────────────────┘
```

### 1. Side Bar (Left)

The vertical bar on the left with icons. Click each icon to switch views:

| Icon | Name | Shortcut | What it does |
|------|------|----------|-------------|
| 📄 | Explorer | `Ctrl + Shift + E` | Browse your project's files and folders |
| 🔍 | Search | `Ctrl + Shift + F` | Search text across all files |
| 🔀 | Source Control | `Ctrl + Shift + G` | Git changes, commits, branches |
| 🐛 | Run & Debug | `Ctrl + Shift + D` | Debugging tools |
| 🧩 | Extensions | `Ctrl + Shift + X` | Install/manage extensions |
| 🤖 | Claude Code | (varies) | Claude Code chat panel (if extension installed) |

**Tip:** You can collapse the side bar to get more space: `Ctrl + B`

### 2. Editor Area (Center)

This is where you read and write code. Key things to know:

- **Tabs** — each open file is a tab at the top. Click to switch between files.
- **Split editors** — drag a tab to the right side to view two files side by side
- **Minimap** — the thin preview on the right edge shows where you are in a long file
- **Breadcrumbs** — the path at the top of the editor shows the file's location

**Keyboard shortcuts for the editor:**
| Shortcut | What it does |
|----------|-------------|
| `Ctrl + P` | Quick open — type a file name to jump to it |
| `Ctrl + G` | Go to a specific line number |
| `Ctrl + D` | Select the next occurrence of selected text |
| `Ctrl + /` | Toggle comment on selected lines |
| `Ctrl + Z` | Undo |
| `Ctrl + Shift + Z` | Redo |
| `Ctrl + S` | Save the current file |

### 3. Panel (Bottom)

The bottom panel contains the terminal and other outputs. This is where Claude Code runs in terminal mode.

**Show/hide the panel:** `` Ctrl + ` `` (the backtick key, usually below Escape)

The panel has tabs:
- **Terminal** — your command line (this is where you type `claude`)
- **Problems** — shows errors and warnings in your code
- **Output** — shows output from extensions and tools
- **Debug Console** — for debugging

### 4. Status Bar (Bottom Edge)

The thin bar at the very bottom shows:
- Current git branch (e.g., `main`)
- Errors and warnings count
- Line and column number
- File encoding
- Language mode (TypeScript, Python, etc.)

---

## The Terminal

The terminal is critical — it's where Claude Code lives (in CLI mode).

### Opening a Terminal

- **Keyboard:** `` Ctrl + ` `` (backtick)
- **Menu:** `Terminal` → `New Terminal`
- **Shortcut:** `` Ctrl + Shift + ` `` (new terminal)

### Multiple Terminals

You can have several terminals open at once. Why?

- **Terminal 1:** Claude Code session
- **Terminal 2:** Running your dev server (`bun run dev`)
- **Terminal 3:** Running tests or git commands

**How to manage multiple terminals:**
- Click the `+` button in the terminal panel to create a new one
- Click the dropdown arrow next to `+` to see all open terminals
- Click a terminal name to switch between them
- Click the trash can icon to close a terminal

**Split terminals:** Click the split icon (looks like two panels) to see two terminals side by side.

### Setting Git Bash as Default

If your terminal shows `PS C:\` (PowerShell) instead of `$` (bash):

1. Press `Ctrl + Shift + P`
2. Type: `Terminal: Select Default Profile`
3. Select: **Git Bash**
4. Close the current terminal and open a new one

All new terminals will now use bash. This is important because Claude Code and all the curriculum commands use bash.

---

## The Chat Panel (Claude Code Extension)

If you installed the Claude Code VS Code extension, you have a chat panel.

### Opening the Chat

- Click the Claude Code icon in the side bar
- Or use the keyboard shortcut (check Extensions settings for the binding)

### The Layout Toggle Buttons

In the **top right corner** of VS Code, you'll see small toggle buttons. These control the layout:

```
[Editor] [Panel] [Side Bar] [Secondary Side Bar]
```

| Button | What it toggles | When to use it |
|--------|----------------|----------------|
| **Editor** | Show/hide the code editor area | Hide when you want full chat |
| **Panel** | Show/hide the bottom panel (terminal) | Hide terminal to make chat bigger |
| **Side Bar** | Show/hide the left side bar (files) | Hide for more editor space |
| **Secondary Side Bar** | Show/hide a second side bar (right) | Some extensions use this |

### Common Layouts

**Layout 1: Chat + Code (default)**
Side bar open, editor in center, chat on the side. Good for working with Claude Code while reading code.

**Layout 2: Chat focused**
Minimize the terminal panel, collapse the side bar. Chat gets maximum space. Good for longer conversations.

**Layout 3: Terminal focused**
Expand the terminal panel to full height. Good for CLI Claude Code sessions or running commands.

**Layout 4: Side by side**
Editor on left, chat on right, terminal at bottom. The "power user" layout — see everything at once.

**Tip:** Drag the borders between panels to resize them. Make the chat bigger when you're having a conversation, make the editor bigger when you're reading code.

---

## The Command Palette

The single most important keyboard shortcut in VS Code:

**`Ctrl + Shift + P`**

This opens the **Command Palette** — a search bar for every action VS Code can do. If you forget any keyboard shortcut, open the Command Palette and type what you want:

- "terminal" → find terminal commands
- "git" → find git commands
- "theme" → change color theme
- "settings" → open settings
- "install" → install extensions

If you remember one shortcut, remember this one.

---

## Essential Keyboard Shortcuts

Print this out or keep it nearby for your first week:

### Navigation
| Shortcut | What it does |
|----------|-------------|
| `Ctrl + Shift + P` | Command Palette (find any action) |
| `Ctrl + P` | Quick open file by name |
| `Ctrl + B` | Toggle side bar |
| `` Ctrl + ` `` | Toggle terminal panel |
| `Ctrl + Shift + E` | Show file explorer |
| `Ctrl + Tab` | Switch between open tabs |

### Editing
| Shortcut | What it does |
|----------|-------------|
| `Ctrl + S` | Save file |
| `Ctrl + Z` | Undo |
| `Ctrl + Shift + Z` | Redo |
| `Ctrl + /` | Toggle comment |
| `Ctrl + D` | Select next matching word |
| `Alt + Up/Down` | Move line up/down |
| `Ctrl + Shift + K` | Delete entire line |

### Terminal
| Shortcut | What it does |
|----------|-------------|
| `` Ctrl + ` `` | Toggle terminal |
| `` Ctrl + Shift + ` `` | New terminal |
| `Ctrl + Shift + P` → "kill" | Close a terminal |

---

## Exercise: Get Comfortable

Do each of these right now. It takes 5 minutes and builds muscle memory:

1. **Open a folder:** `File` → `Open Folder` → pick any project
2. **Open a file:** Click a file in the Explorer, or press `Ctrl + P` and type a name
3. **Open the terminal:** Press `` Ctrl + ` ``
4. **Open a second terminal:** Press `` Ctrl + Shift + ` ``
5. **Switch between terminals:** Click the terminal names in the dropdown
6. **Toggle the side bar:** Press `Ctrl + B` (off, then on again)
7. **Open the Command Palette:** Press `Ctrl + Shift + P`, type "theme", pick a color theme you like
8. **Resize panels:** Drag the border between editor and terminal up and down
9. **Open Claude Code chat:** Click the Claude Code icon in the side bar (if installed)
10. **Try the layout toggles:** Click each button in the top right to see what they do

Don't try to memorize everything. Just know that `Ctrl + Shift + P` (Command Palette) can find anything.

---

## Key Takeaway

VS Code is your cockpit. The editor is for reading code, the terminal is for running commands (and Claude Code), the chat panel is for visual Claude Code interaction, and the Command Palette finds everything else. Spend 10 minutes getting comfortable — it pays off for the entire curriculum.

---

**Next:** [What Is Claude Code?](02-what-is-claude-code.md)

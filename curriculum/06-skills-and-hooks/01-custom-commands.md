# Lesson 01: Custom Commands

## Your Workflows, One Slash Away

You've used built-in commands like `/help`, `/compact`, and `/bootstrap`. Now let's build your own.

## What's a Custom Command?

A markdown file in `.claude/commands/` that becomes a slash command:

```
.claude/commands/deploy.md    → /deploy
.claude/commands/pr-check.md  → /pr-check
.claude/commands/morning.md   → /morning
```

The file contains instructions that Claude Code follows when you trigger the command. Think of it as a saved prompt with structure.

## Your First Custom Command

Let's create a `/status` command that gives you a project overview:

### Step 1: Create the file

```markdown
# /status — Project Status Check

## Instructions

1. Read `.agents/SYSTEM/SUMMARY.md` for current project state
2. Read `.agents/TASKS/INBOX.md` for pending tasks
3. Run `git log --oneline -5` for recent commits
4. Run `git status` for uncommitted changes

## Output Format

Present a brief status report:
- Project state (from SUMMARY.md)
- Top 3 priority tasks (from INBOX.md)
- Recent activity (from git log)
- Any uncommitted work (from git status)

Keep it under 10 lines.
```

Save this as `.claude/commands/status.md`.

### Step 2: Use it

```
/status
```

Claude Code reads the file and follows the instructions. Every time. Consistent output.

## Command Design Principles

### 1. Be specific about steps
Don't say "check the project." Say "read SUMMARY.md, then read INBOX.md, then run git log."

### 2. Define the output format
Tell Claude Code exactly how to present results. Otherwise, you'll get different formats each time.

### 3. Keep it focused
One command, one workflow. `/deploy` deploys. `/status` checks status. Don't combine them.

### 4. Include error handling
```markdown
If SUMMARY.md doesn't exist, say "No .agents/ framework found. 
Run /bootstrap first."
```

## The Framework Commands

If you're using the Self-Improving Agent framework (set up via `/bootstrap`), you already have the most important commands:

### /start — Session Start
Loads project state, recalls relevant knowledge, creates a session log. **Run this at the beginning of every session.**

### /end — Session End  
Updates SUMMARY.md, checks off tasks, writes handoff notes. **Run this at the end of every session.**

### /sync — Validate Before Commit
Checks version consistency across docs, validates structural integrity, flags drift. **Run this before every commit.**

### /task — Pick Up Next Task
Reads INBOX.md and task.md, presents the next priority, starts work.

### /test — Zero-Token Testing
Writes Playwright test scripts (AI tokens), then runs them natively (zero tokens). Five phases: assess → author → execute → fix loop → report. We cover this in detail in Module 08.

These five commands are the backbone of the framework workflow:
```
/start → work → /task → work → /test → /sync → commit → /end
```

## Building Your Own Commands

Beyond the framework commands, you'll want custom ones for your specific workflows.

### /morning — Start your day
```markdown
# /morning — Daily Startup

1. Run /start (load project state)
2. Check git status for uncommitted work from yesterday
3. Read INBOX.md — what's the top priority?
4. Present: "Good morning. Here's where we left off and what's next."
```

### /ship — Pre-deploy checklist
```markdown
# /ship — Pre-Deploy Checklist

1. Run the test suite: `npm test`
2. Run the linter: `npm run lint`
3. Check for console.log statements: grep for them
4. Run a build: `npm run build`
5. Report: pass/fail for each step
6. If all pass: "Ready to ship."
7. If any fail: "Not ready. Fix these first: [list]"
```

### /pr — Create a pull request
```markdown
# /pr — Create Pull Request

1. Run `git diff main...HEAD` to see all changes
2. Analyze the changes — what was added, modified, fixed?
3. Draft a PR title (under 70 chars) and description
4. Create the PR using `gh pr create`
5. Return the PR URL
```

## Global vs. Project Commands

| Location | Scope | Example |
|----------|-------|---------|
| `~/.claude/commands/` | All projects | `/bootstrap`, `/morning` |
| `.claude/commands/` | This project only | `/deploy`, `/ship` |

Global commands are your personal toolkit. Project commands are shared with the team (committed to git).

## Commands With Arguments

Commands can accept arguments using `$ARGUMENTS`:

```markdown
# /review — Code Review

Review the file or directory specified: $ARGUMENTS

1. Read the file(s)
2. Check for: bugs, security issues, performance problems
3. Present findings as a bulleted list with severity ratings
```

Usage: `/review src/auth/`

## Exercise: Build Three Commands

1. **A status command** — shows project state, tasks, recent activity
2. **A check command** — runs tests + lint and reports pass/fail
3. **A personal command** — something specific to your workflow

Create them in `.claude/commands/`, test each one, and iterate on the instructions until the output is consistently what you want.

## Key Takeaway

Custom commands encode your workflows into repeatable, consistent actions. Build them for anything you do more than twice. Share project-specific ones with your team via git.

---

**Next:** [Hooks — Event-Driven Automation](02-hooks.md)

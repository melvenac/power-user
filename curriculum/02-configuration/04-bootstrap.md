# Lesson 04: Putting It Together — /bootstrap

## One Command, Full Setup

You've now learned about three layers of configuration:

1. **CLAUDE.md** — instructions for Claude Code
2. **Settings & Permissions** — what it can do
3. **.agents/** — project state and task tracking

The `/bootstrap` command sets up layers 1 and 3 in one shot. Let's see how it works and when to use it.

## When to Use /bootstrap

| Situation | Command |
|-----------|---------|
| Brand new project, nothing set up | `/bootstrap` |
| Existing project, no CLAUDE.md | `/bootstrap` (creates both) |
| Already have CLAUDE.md, want .agents/ | `/bootstrap` (skips CLAUDE.md, adds .agents/) |
| Already have both | `/bootstrap` says "you're already set up, use /start" |

It's idempotent — running it twice won't break anything.

## What /bootstrap Does (Step by Step)

### 1. Scans your project
- Reads `package.json`, `requirements.txt`, or equivalent
- Checks directory structure
- Notes existing configuration (linting, testing, etc.)

### 2. Generates CLAUDE.md (if missing)
- Creates a concise project instruction file
- Detects your tech stack automatically
- Asks you to review before writing

### 3. Scaffolds .agents/ (if missing)
- Creates the full directory structure
- Populates INBOX.md with detected tasks (TODOs, FIXMEs)
- Sets up SUMMARY.md with current project state
- Creates session templates

### 4. Initializes git (if needed)
- Asks before doing anything
- Creates initial commit with the new files
- Adds session logs to .gitignore

## After Bootstrap: The Session Workflow

Once bootstrapped, your daily workflow is:

```
claude                    # Launch Claude Code
/start                    # Load project state, pick up where you left off
                          # ... do your work ...
/end                      # Save state, update tasks, write handoff notes
```

That's it. Three commands across your entire workflow.

## Exercise: The Full Loop

Let's do a complete cycle:

1. **Create a fresh project:**
   ```bash
   mkdir ~/test-bootstrap && cd ~/test-bootstrap
   echo '{ "name": "test-app", "version": "1.0.0" }' > package.json
   ```

2. **Launch Claude Code and bootstrap:**
   ```
   claude
   /bootstrap
   ```

3. **Review what was created:**
   ```
   "Show me everything /bootstrap created"
   ```

4. **Start a session:**
   ```
   /start
   ```

5. **Do some work:**
   ```
   "Create a simple index.js that logs 'hello world'. 
   Add it as a task to INBOX first, then implement it."
   ```

6. **End the session:**
   ```
   /end
   ```

7. **Start a new session and verify continuity:**
   ```
   /start
   ```
   Claude should know what you did last time.

## Customizing After Bootstrap

The generated files are starting points. As your project evolves:

- **CLAUDE.md** — add conventions as you establish them
- **INBOX.md** — add/complete tasks as you work
- **SUMMARY.md** — gets auto-updated by `/end`, but you can edit too
- **ENTITIES.md** — add your data models as they emerge
- **RULES.md** — add rules as you discover edge cases

The framework grows with your project. Don't try to fill everything in upfront.

## Key Takeaway

`/bootstrap` gets you from zero to productive in under a minute. It handles the setup so you can focus on the work. Use `/start` and `/end` to maintain continuity across sessions. The framework is low-friction by design — it works for you, not the other way around.

---

**Next Module:** [MCP & Tools](../03-mcp-and-tools/)

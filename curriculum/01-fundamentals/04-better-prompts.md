# Lesson 04: Writing Better Prompts

## It's Not Prompt Engineering

Forget everything you've read about "prompt engineering." Claude Code isn't a text generator you need to trick into good output. It's an agent you need to **brief** clearly.

Think of it like delegating to a smart colleague who just sat down at your desk. They need:
- What you want done
- Enough context to make good judgment calls
- Clear scope so they don't go too far (or not far enough)

## The Briefing Pattern

### Bad: Vague
```
"Fix the auth"
```
Fix what? Where? What's broken?

### Better: Specific
```
"The login endpoint returns 500 when the email has a plus sign. 
Fix the email validation in src/auth/login.ts"
```

### Best: Contextual
```
"Users with emails like john+test@gmail.com get a 500 on login. 
The issue is probably in the email validation. Fix it and add a 
test case for emails with special characters."
```

The best version gives Claude Code enough context to make smart decisions (add a test) without over-prescribing how to do it.

## Five Patterns That Work

### 1. Task, Not Question
```
# Instead of:
"How would I add pagination to the users endpoint?"

# Say:
"Add cursor-based pagination to the GET /users endpoint. 
Default page size 20, max 100."
```

### 2. Scope Boundary
Tell it where to stop:
```
"Refactor the database queries in src/db/ to use prepared statements. 
Don't touch the API routes — just the DB layer."
```

### 3. Reference Existing Patterns
```
"Add a new API endpoint for /projects following the same pattern 
as the /users endpoint. Same auth, same error handling."
```
This is powerful — Claude Code reads the reference, matches the pattern, and you get consistency.

### 4. Checkpoint Requests
For big tasks, build in checkpoints:
```
"I need to migrate from REST to GraphQL. Before writing any code, 
read the current API and give me a migration plan. 
I'll approve before you start implementing."
```

### 5. Decomposition Hint
When the task is complex, tell it to break it down:
```
"Add user roles to the app. Break this into steps: 
schema changes first, then API middleware, then UI. 
Do them one at a time and check in between."
```

## Anti-Patterns

### Don't over-specify the "how"
```
# Too prescriptive:
"Open src/utils.ts, go to line 47, change the function name 
from processData to handleData, then open every file that imports 
it and update the import"

# Better:
"Rename processData to handleData in src/utils.ts and update 
all imports"
```
Claude Code knows how to rename things. Let it.

### Don't stack unrelated tasks
```
# Bad:
"Fix the login bug, add dark mode, update the README, 
and deploy to staging"

# Good: (four separate prompts)
"Fix the login bug where plus-sign emails cause 500s"
```
Each task gets full attention and clean context.

### Don't explain Claude Code to Claude Code
```
# Unnecessary:
"Use the Grep tool to search for all files containing the word 
'deprecated', then use the Read tool to read each one..."

# Just say:
"Find all deprecated code and tell me what can be removed safely"
```

## Exercise: Prompt Upgrade

Take a task you'd normally do manually. Write three versions of the prompt:

1. **First draft** — whatever comes naturally
2. **Revised** — add context and scope
3. **Power user** — use one of the five patterns above

Run the power user version and compare the result to what you expected. Did it get closer than your first draft would have?

## Key Takeaway

Good prompts are clear briefings, not magic incantations. Give context, specify scope, reference patterns, and let Claude Code figure out the implementation. The less you micro-manage, the more it can leverage its tools effectively.

---

**Next:** [The Context Window](05-context-window.md)

# /task — Pick Up Next Task

> Read the task backlog and present the next priority.

## Steps

1. Read `.agents/TASKS/INBOX.md` for the prioritized backlog
2. Read `.agents/TASKS/task.md` if it exists for current sprint focus
3. Identify the highest-priority incomplete task (`- [ ]`)
4. Present it with context:

```
Next task: [task description]
Phase: [which part of the project this belongs to]
Suggested first step: [concrete action to start]

Ready to work on this?
```

5. If the user approves, begin work
6. If the user wants a different task, ask what they'd prefer

# Lesson 04: Agent Teams

## Beyond Solo Agents

So far, you've used individual agents — spawn one, get a result, move on. Agent Teams take this further: multiple Claude Code instances coordinated by a team lead, with a shared task list and communication channel.

> **Note:** Agent Teams is an experimental feature. Enable it with:
> ```json
> { "env": { "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1" } }
> ```
> in your settings.json.

## How Teams Work

```
You (human)
  └── Team Lead (your main Claude Code session)
        ├── Teammate A (separate Claude Code instance)
        ├── Teammate B (separate Claude Code instance)
        └── Teammate C (separate Claude Code instance)
```

- **Team Lead:** Coordinates work, assigns tasks, merges results
- **Teammates:** Independent Claude Code instances with their own context
- **Shared:** Task list and mailbox for communication

## When to Use Teams vs. Single Agents

| Scenario | Use |
|----------|-----|
| Quick research | Single agent |
| One-off task | Single agent |
| Multi-step project with coordination | Team |
| Cross-layer work (frontend + backend + tests) | Team |
| Competing hypotheses for debugging | Team |

Teams are for sustained, coordinated work. Single agents are for quick delegation.

## Team Patterns

### Research Team
```
"Create a team to research our authentication options:
- Teammate 1: Research OAuth providers (Auth0, Clerk, Supabase Auth)
- Teammate 2: Research our current auth code and its limitations
- Teammate 3: Research security best practices for our stack

Each teammate reports findings. We'll synthesize into a decision."
```

### Build Team
```
"Create a team to build the notification system:
- Teammate 1: Backend — database schema and API endpoints
- Teammate 2: Frontend — notification UI components
- Teammate 3: Tests — test suite for notifications

Coordinate through the task list. Backend goes first, 
then frontend and tests can work in parallel."
```

### Debug Team
```
"Users report slow page loads. Create a team:
- Teammate 1: Profile the API endpoints
- Teammate 2: Check the database queries  
- Teammate 3: Analyze the frontend bundle size

Report findings — the bottleneck could be anywhere."
```

## Practical Considerations

### Cost
Each teammate is a separate Claude Code session. Token usage scales linearly. A team of 3 uses roughly 3x the tokens. Keep teams to 3-5 members.

### File Conflicts
Teammates should NOT edit the same files. Assign clear ownership:
- Teammate A owns `src/api/`
- Teammate B owns `src/components/`
- Teammate C owns `tests/`

### Communication
Teammates communicate through a shared mailbox. The team lead coordinates. You see all of this in your main session.

### When to Stop
Not every task needs a team. If you catch yourself creating a team for something one agent could handle, step back. Teams add coordination overhead.

## Exercise: Your First Team

If you have agent teams enabled:

1. Pick a task with 2-3 clearly independent parts
2. Create a team with one teammate per part
3. Watch the coordination — how do they divide work?
4. Review the combined output

If you don't have teams enabled yet:
1. Simulate it with sequential agents
2. Spawn Agent A, get results
3. Spawn Agent B with Agent A's findings as context
4. Compare how this feels vs. doing it all in one thread

## Key Takeaway

Agent Teams are for complex, multi-part work that benefits from parallel execution and clear ownership. They're powerful but expensive — use them when the coordination overhead pays for itself in speed and quality. For most daily work, single agents are enough.

---

**Next Module:** [Skills & Hooks](../06-skills-and-hooks/)

# Lesson 03: Task Decomposition

## Think Like a Tech Lead

The best way to use multi-agent isn't to give Claude Code a massive prompt and hope for the best. It's to **decompose the work** the way a tech lead assigns tasks to a team.

## The Decomposition Principle

Big, vague tasks → poor results:
```
"Refactor the entire codebase to use the new design system"
```

Decomposed tasks → great results:
```
"Let's refactor to the new design system. Break it into phases:

Phase 1: Audit — what components use the old system?
Phase 2: Map — for each old component, what's the new equivalent?
Phase 3: Implement — replace them one module at a time
Phase 4: Verify — run tests after each module

Start with Phase 1 — spawn an agent to do the audit."
```

## How to Decompose

### Step 1: Identify the deliverable
What does "done" look like? Be specific.

### Step 2: Find the natural seams
Where can the work be split without creating dependencies?

### Step 3: Order by dependency
What must happen first? What can run in parallel?

### Step 4: Size each piece
Each piece should fit comfortably in a single agent's context.

## Decomposition Patterns

### Pattern: Audit → Plan → Execute
```
Agent 1 (Explore): "Audit the current state"
You: Review the audit, make decisions
Agent 2 (Plan): "Plan the changes based on this audit"
You: Approve the plan
Agent 3+ (General): "Execute phase 1 of the plan"
```

### Pattern: Parallel by Module
```
Agent A: "Update auth module to new patterns"
Agent B: "Update user module to new patterns"  
Agent C: "Update payments module to new patterns"
```
Works when modules are independent and changes don't overlap.

### Pattern: Research → Implement → Validate
```
Agent 1: "Research how other projects handle this"
Agent 2: "Implement based on the research findings"
Agent 3: "Run tests and validate the implementation"
```

### Pattern: Competing Approaches
```
Agent A: "Try solving this with approach X"
Agent B: "Try solving this with approach Y"
You: Compare results, pick the winner
```

## The Dependency Rule

**Independent tasks → parallel agents**
```
"Find all API endpoints" + "Find all database models"
→ Two agents, same time
```

**Dependent tasks → sequential agents**
```
"Analyze the codebase" → "Plan changes based on analysis"
→ One agent, then the next
```

**Never:** two agents editing the same file at the same time. That's how you get merge conflicts in your own working directory.

## Real-World Example

Task: "Add comprehensive error handling to our API"

Decomposition:
```
1. Audit (Explore agent):
   "Find all API endpoints. For each one, note:
   - Does it have try/catch?
   - Does it return proper error codes?
   - Does it log errors?"

2. You review the audit and prioritize

3. Plan (Plan agent):
   "Given this audit, create an error handling pattern
   that we'll apply consistently. Include the error format,
   logging approach, and status code mapping."

4. You approve the pattern

5. Implement (General agents, parallel by module):
   Agent A: "Apply error handling pattern to /auth endpoints"
   Agent B: "Apply error handling pattern to /users endpoints"
   Agent C: "Apply error handling pattern to /projects endpoints"

6. Validate (General agent):
   "Run all API tests. Report any failures."
```

Six steps. Clean context at each step. Each agent has clear scope.

## Exercise: Decompose a Real Task

1. Pick a real task from your INBOX.md (or invent one)
2. Write out the decomposition:
   - What are the phases?
   - What can run in parallel?
   - What depends on what?
3. Execute Phase 1 using an agent
4. Review the result before proceeding

Don't rush to Phase 2. The review step is where you catch misunderstandings early.

## Key Takeaway

Task decomposition is the skill that makes everything else in this module work. Think like a tech lead: break the work down, identify dependencies, size each piece for one agent, and execute in the right order. The time you spend decomposing saves multiples in execution.

---

**Next:** [Agent Teams](04-agent-teams.md)

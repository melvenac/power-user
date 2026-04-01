# Lesson 04: Session 3 — Testing & Validation

## Building Confidence in Your Code

You've got a project with real features. Now let's make sure they actually work — using the framework's zero-token testing approach.

## Step 1: /start

```
/start
```

By now this feels natural. Claude Code loads state, shows progress, suggests the next task. You're oriented in 30 seconds.

## Step 2: Set Up Testing

If you haven't installed Playwright yet:

```
"Set up Playwright for E2E testing in this project. 
Install it and create a playwright.config.ts"
```

Then create the testing strategy doc:

```
"Create .agents/SYSTEM/TESTING.md documenting our testing approach:
- Zero-token E2E testing with Playwright
- Test categories: happy path, validation, navigation, auth gates
- Tests live in tests/e2e/
- Max 3 fix attempts per failure"
```

## Step 3: Understanding Zero-Token Testing

The framework's testing approach has two phases:

### Write Phase (uses AI tokens)
Claude Code reads your project structure, understands your routes and components, and generates `.spec.ts` test files. This is the intelligent part — it knows what to test.

### Run Phase (zero tokens)
Playwright executes those test scripts natively via CLI. No AI involved. The tests are deterministic scripts — they run the same way every time, costing you nothing.

```
AI writes the test:          ~500 tokens (one-time)
Playwright runs the test:    0 tokens (every run)
Traditional AI testing:      ~5000 tokens (every run)
```

Over 10 runs, that's 500 tokens vs. 50,000. The savings compound.

## Step 4: Run /test

```
/test
```

The five phases:

### Phase 1: Assess
Claude Code reads your project structure — framework, routing, entry points, auth. It builds a mental model of what needs testing.

### Phase 2: Author
It writes `.spec.ts` files organized by strategy:

| File | What It Tests |
|---|---|
| `happy_path.spec.ts` | Core user journeys that must always work |
| `validation.spec.ts` | Form inputs, required fields, error states |
| `navigation.spec.ts` | Routes resolve, links work, 404 handling |
| `auth_gates.spec.ts` | Protected routes redirect, public routes stay open |
| `responsive.spec.ts` | Mobile, tablet, desktop viewports |

### Phase 3: Execute
Runs tests via Playwright CLI. Zero AI tokens:
```bash
npx playwright test tests/e2e/
```

### Phase 4: Fix Loop
If tests fail, Claude Code reads the error output and determines:
- **Test bug** (bad selector, timing issue) → fixes the test
- **App bug** (broken UI, backend error) → fixes the app code

Max 3 attempts per failure. This prevents infinite loops.

### Phase 5: Report
Results table showing pass/fail per test, bugs found and fixed, and suggestions for additional coverage.

## Step 5: Iterate on Tests

After the first run, you'll likely have:
- Some tests that pass immediately
- Some tests that need selector fixes
- Maybe a real bug discovered

This is valuable. The test suite just found things you'd have missed manually.

Add more tests as features stabilize:
```
"Add a test for the [specific feature] flow. 
It should cover: [key steps]"
```

## Step 6: Entity Validation (Data Model Check)

If your project has a data model, this is the highest-ROI validation in the framework:

```
"Check that ENTITIES.md matches the actual data model in the code.
Flag any mismatches."
```

This catches drift — when you change a schema in code but forget to update the documentation. It's a common source of bugs when Claude Code uses outdated entity info.

## Step 7: /sync and /end

```
/sync
```

Validate everything is consistent — especially now that you've added test files and possibly fixed bugs.

```
/end
```

Session 3 is in the books. Your project now has:
- Working features (Session 2)
- Automated tests (Session 3)
- Validated documentation
- Three sessions of accumulated context

## The Testing Skill (Create It Now)

You've now used the testing pattern enough to formalize it. Create the skill:

```
"Create a playwright-tester skill in .agents/skills/ 
based on what we just did. Include:
- The 5-phase workflow
- Project-specific routes and components to test
- Our test categories
- The fix loop rules"
```

This is the framework's skill creation philosophy in action: you repeated the pattern, now you formalize it. Future sessions have the testing knowledge baked in.

## Exercise: The Full Test Cycle

1. Run `/test` on your project
2. Let the fix loop resolve what it can
3. Manually review any remaining failures
4. Run the tests again natively: `npx playwright test tests/e2e/`
5. Confirm zero tokens on the second run (just CLI output)

## Key Takeaway

Zero-token testing is the framework's answer to "testing is expensive with AI." Write tests once (smart), run forever (free). Combined with entity validation and /sync, you have a quality layer that catches bugs, drift, and inconsistencies — all within the session workflow.

---

**Next:** [Session 4: Skills & Continuous Improvement](05-session-4-skills.md)

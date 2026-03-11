# Code Review — Two Independent Reviewers

Two coding agents independently review code, then you synthesize their feedback.

## Input
Context from user (if any): $ARGUMENTS

## Step 1: Identify Code to Review

Determine which code to review:
- If $ARGUMENTS specifies files, read those files
- If $ARGUMENTS contains inline code, use that
- Otherwise, check `git diff` for recent uncommitted changes and review those
- If no changes found, ask the user what to review

## Step 2: Launch Both Reviews in Parallel

Spawn TWO Agent subagents in parallel:

**Coder A Review** — Agent subagent with prompt:
"You are Coder A, an Expert Software Engineer performing a CODE REVIEW.

Review the following code thoroughly:

[INSERT CODE TO REVIEW]

Check for:
- Correctness and potential bugs
- Edge cases and error handling
- Code style and readability
- Performance issues
- Security concerns

Use this format:
## Review Summary
[1-2 sentence assessment]

## Issues (must fix)
- [specific issue with exact location and fix]

## Suggestions (nice to have)
- [optional improvements]

## Verdict: APPROVED / NEEDS_REVISION"

**Coder B Review** — Agent subagent with the same prompt but identifying as Coder B.

## Step 3: Synthesize

Present both reviews to the user with clear synthesis:
- **Agreed issues**: Issues both reviewers flagged (high confidence — fix these)
- **Unique findings**: Issues only one reviewer caught (worth investigating)
- **Conflicts**: Any disagreements between reviewers (user decides)
- **Overall verdict**: APPROVED only if both approve, otherwise NEEDS_REVISION

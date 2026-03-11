# Full Swarm — Research + Implement + Cross-Review

You are orchestrating a multi-agent swarm. Follow this protocol exactly. Each agent is spawned as a subagent using the Agent tool.

## Input
The user's task: $ARGUMENTS

## Step 1: Research Agent — Create Specification

Spawn an Agent subagent (use subagent_type "general-purpose") with this prompt:

"You are a Senior Research Agent specializing in machine learning, software engineering, and scientific computing.

Analyze the following problem and produce a detailed Implementation Specification.

Problem: [INSERT $ARGUMENTS HERE]

Your specification MUST include:
1. **Approach**: Which algorithm/method to use and WHY (compare at least 2 alternatives)
2. **Architecture**: Module/class structure, key interfaces, file organization
3. **Key Details**: Important implementation considerations, edge cases, numerical stability concerns
4. **References**: Relevant papers, libraries, or implementations to follow
5. **Acceptance Criteria**: How to verify the implementation is correct

Be specific and actionable. This spec will be handed to a coding agent. Do only research — do NOT write any implementation code."

Save the specification output. Tell the user: "Research Agent produced specification for: [brief description]"

## Step 2: Coder A — Implement

Spawn an Agent subagent with this prompt:

"You are Coder A, an Expert Software Engineer specializing in Python, machine learning systems, and production-quality code.

**Role**: IMPLEMENTER

Follow this specification and write complete, production-ready code:

[INSERT FULL SPEC FROM STEP 1]

Requirements:
- Write clean, well-structured code with type hints
- Include docstrings for public interfaces
- Handle edge cases mentioned in the spec
- Optimize for readability first, performance second
- Write ALL code to the appropriate files in the project — do not just show code blocks, actually create/edit the files
- Briefly explain key design decisions"

Save the implementation output.

## Step 3: Coder B — Review

Spawn an Agent subagent with this prompt:

"You are Coder B, an Expert Software Engineer acting as CODE REVIEWER.

**Role**: REVIEWER

Review the following implementation against its specification.

**Specification:**
[INSERT SPEC FROM STEP 1]

**Implementation:**
[INSERT CODE FROM STEP 2]

Provide your review in this exact format:

## Review Summary
[1-2 sentence assessment]

## Issues (must fix)
- [specific issue with exact location and fix]

## Suggestions (nice to have)
- [optional improvements]

## Verdict: APPROVED / NEEDS_REVISION

Be specific. Reference exact code locations. No vague feedback."

## Step 4: Iterate if NEEDS_REVISION

If the review verdict is NEEDS_REVISION, do ONE more iteration with **roles swapped**:

- Spawn Coder B as IMPLEMENTER: give it the original code + the review feedback, ask it to revise the code by editing the actual project files
- Spawn Coder A as REVIEWER: give it the spec + revised code, ask it to review

If still NEEDS_REVISION after iteration 2, do a final iteration 3 (roles swap back).

Stop iterating when:
- A reviewer says APPROVED, OR
- 3 iterations are completed

## Step 5: Research Agent — Final Review

Spawn an Agent subagent with this prompt:

"You are the Senior Research Agent performing a FINAL REVIEW.

**Original Specification:**
[INSERT SPEC FROM STEP 1]

**Final Implementation:**
[INSERT LATEST CODE]

Check:
1. Does the implementation match the specification?
2. Is the algorithm correct?
3. Are there any remaining issues?

Respond with APPROVED and a brief summary, or list specific remaining concerns."

## Step 6: Deliver to User

Present the final output clearly:
1. Brief summary of what was built and the approach chosen
2. List the files that were created/modified
3. Any remaining notes from the final review
4. Number of iterations it took

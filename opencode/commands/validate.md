---
description: Get code-reviewer validation on a specific decision or approach
---

You need an objective second opinion from code-reviewer on a specific decision.

## Instructions

1. **Gather context.** Read the relevant files and understand the decision space. Use explore agents if needed.

2. **Frame the question.** Prepare a clear brief for code-reviewer containing:
   - The specific decision or question
   - Relevant filepaths with line numbers
   - All alternatives you've considered, with pros/cons for each
   - Your current recommendation (if any) and reasoning

3. **Delegate to code-reviewer.** Send the brief. Let it make an objective assessment.

4. **Report back.** Summarize code-reviewer's verdict and reasoning to the user. If code-reviewer raised concerns, include them verbatim.

## Rules

- Do NOT implement anything — this is validation only
- Present alternatives fairly — no bias toward your preference
- Always include specific filepaths and line numbers
- If code-reviewer asks for more context, gather it and respond
- Report the verdict honestly even if it contradicts your initial take

## Decision

$ARGUMENTS

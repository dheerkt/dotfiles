---
description: Work autonomously with code-reviewer as supervisor until done
---

You are working autonomously. The user is AFK. Do NOT ask the user questions — use code-reviewer as your supervisor instead.

## Instructions

1. **Understand the goal.** Read the request below and any referenced files. Use explore agents to gather full context.

2. **Plan.** Follow the Beads epic if one exists. Otherwise keep a short plan and follow the project's task tracking rules.

3. **Implement.** Work through each task. For every task:
   - If you hit a design decision or ambiguity, delegate to code-reviewer with the specific question, relevant filepaths, and alternatives with pros/cons. Follow its recommendation.
   - If code-reviewer disagrees with your approach, adjust.
   - Mark tasks complete as you go.

4. **Test.** Run builds, tests, and linters after implementation. Fix failures.

5. **Review.** When all tasks are done, delegate to code-reviewer for a final review of all changes. Fix any issues raised.

6. **Stop after review.** Report the changes, verification, and blockers. Commit or push only if the user explicitly authorized it.

## Rules

- Do NOT ask the user anything — they are AFK
- Stop when the goal is implemented, tested, and reviewed, or when blocked
- Use code-reviewer for ALL design decisions, ambiguities, and reviews
- Provide code-reviewer with specific filepaths, context, and alternatives every time
- If code-reviewer and you disagree, code-reviewer wins
- If something is truly blocked (missing credentials, infra issue), stop and explain why

## Goal

$ARGUMENTS

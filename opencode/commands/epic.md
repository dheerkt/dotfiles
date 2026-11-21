---
description: Create a beads epic with detailed, dependency-linked tasks
---

You are planning a beads epic. You must NOT implement anything. Your only output is beads tasks.

## Instructions

1. **Research first.** Explore the codebase, referenced files, and any URLs or repos mentioned below. Use `subagent` with `explore` for independent research. If delegation is unavailable, research directly.

2. **Create the epic.** Use `bd create --type=epic --title="<title>" --priority=2 --json` for the parent epic. Record the returned ID.

3. **Create tasks.** For each unit of work:
   - `bd create --type=task --title="<title>" --priority=2 --parent "<epic-id>" --description "<what to change, files, acceptance criteria>" --json`
   - `bd comments add <task-id> "Sources: <paths with line numbers, URLs, or reference code>" --json` so the implementing agent has source context.
   - For real prerequisites only, use `bd dep add <task-id> --blocked-by <prerequisite-id> --json`. Epic membership is not a blocking dependency.

4. **Backlog discovered work.** If you find out-of-scope work, create priority=4 tasks and link them.

5. **Resolve ambiguities.** Research with `websearch` and available MCP tools when useful. Use `subagent` with `code-reviewer` for an independent opinion on a specific design question; include relevant paths, findings, and tradeoffs. Record decisions only the user can make as unresolved.

6. **Unresolved questions.** If anything remains truly unresolvable (missing credentials, external dependencies, business decisions only the user can make), list them at the end -- extremely concise.

7. **Review.** Check membership with `bd show <epic-id> --children --json` and prerequisites with `bd dep list <task-id> --json`. Use `subagent` with `code-reviewer` to review the epic structure, descriptions, and ordering. Wait for its result, then verify and fix any findings. If independent review is unavailable, say so. Report the epic ID and any unresolved questions.

## Rules

- Do NOT implement any code
- Do NOT use plan agent -- the beads epic IS the plan
- Do NOT create markdown planning documents
- Every task must have comments with source file paths and line numbers
- Tasks must be ordered by dependency (what must be built first)
- Keep task titles short, descriptions detailed
- Consider: performance (memoization, lazy loading, prefetching), accessibility, error states

## Request

$ARGUMENTS

---
name: agentic-project-execution
description: "Execute an existing plan or Beads epic in an isolated worktree. Implement tasks in dependency order, delegate independent work, verify changes, and obtain a final code review. Use when the user asks to implement an already-planned epic. Do not use to create a plan or epic."
---

# Agentic Project Execution

## Overview

Turn an existing plan or beads epic into implemented, verified and reviewed code in an isolated worktree. Then hand back at "ready to deploy and test".

## Usage

Use this skill when:
- A beads epic or written plan already exists, and the user asks to implement it.
- The work spans multiple tasks or packages.

Do not use this skill to create or restructure a plan. For a single bounded task, follow the project's normal implementation workflow.

## Core Concepts

- **The plan is input, not output.** Execute it. Do not re-plan or restructure the epic.
- **The invocation overrides the defaults.** Follow the user's requested scope, review timing, and verification requirements.
- **Isolation.** All work happens in one new worktree.
- **You own every line.** Subagents produce drafts. You read, verify and accept them.
- **Evidence over claims.** Report only what you built, ran and observed.
- **Never block on independent work.** Run subagents and long CLI commands in the background. Continue independent tasks while they run. Handle results on notification; do not sleep or poll. Wait only when the next step depends on the result.

## Defaults

| Setting | Default |
|---------|---------|
| Scope | Open and in-progress child tasks of the epic. Skip deferred and backlog tasks. |
| Code reviewer | Once, at the end, over the full epic diff |
| Commits, push, pull request, deploy, close epic | Only when the user explicitly asks |

## Workflow

### 1. Load the plan

1. Read the epic and every child task: `bd show <id>`, `bd comments <id>`, `bd dep list <id>`. Read a written plan in full.
2. Derive the execution order from the dependencies. Identify the independent tasks that can run in parallel.
3. Check each task against the code before you start it. If a task is wrong or ambiguous, read the code, record the finding with `bd comment`, and continue with the most defensible reading. Ask the user only when you are blocked.
4. Skip work that is not clearly worth doing. Record the reason on the task and include it in the report.

### 2. Create the worktree

1. Use the project's worktree workflow to create an isolated worktree for the epic. Move the session into it.
2. Work only in the assigned worktree. Use separate worktrees for concurrent workers that edit files. Never modify mainline, another agent's worktree, or existing user changes.
3. Before you write code, read `AGENTS.md` and the contributing docs for every affected package.

### 3. Implement

1. Claim each task before you start it: `bd update <id> --claim`.
2. For changes across packages, read the real contract (routes, schemas, models) before you write consumers. Change producers before consumers. Include the producer file paths in every consumer subagent prompt, or the subagent will invent routes and fields.
3. Dispatch independent tasks to `general` subagents in the background, in parallel. Use `references/agent-prompt-template.md`. Never let two agents edit the same file at the same time. While they run, start the next independent task yourself.
4. When a subagent returns, read its diff. Check it against `references/review-checklist.md` and the package standards before integrating it. If a draft needs more than three fixes, dispatch it again with a better prompt or a smaller task. Write the code yourself when that is faster or safer, or when subagents keep failing.
5. Follow the package test conventions and add tests for new behavior. Never delete or weaken tests to get a pass.

### 4. Commit only if authorized

- Make one logical commit per task or fix, in each changed package, on the worktree branch.
- Before you commit, run the package formatter and its build and tests. They must pass. Do not run them in a package while a subagent is still editing it.
- Use the message format `type(scope): summary`.
- Stage only the files of the finished task. Remove accidental lockfile and generated-file changes only if you made them.

### 5. Final gate

When every in-scope task is implemented:

1. Run the project's required builds and tests for every changed package.
2. Freeze the code while independent review runs.
3. Send `code-reviewer` the exact worktree, packages, base revision, full epic diff scope (including uncommitted changes when applicable), epic ID, goal, and constraints. Send test evidence after its independent pass.
4. Fix critical and important findings. Document the others.
5. If anything changes after review starts, re-run affected checks and get a fresh review before the handoff.

### 6. Keep beads accurate

- Update task status and descriptions when the work diverges from the plan.
- If a task is code-complete but not verified live, leave it `in_progress`. Add a comment that says what is done and what verification remains.
- Close a task only after manual or live verification. Never use `--force`.
- Do not create tickets unless the user asks. Record discoveries with `bd comment`.

### 7. Hand off

Stop at "ready to deploy and test" unless the invocation asks for more. Report:
- The worktree path, the branches and each package's commit range.
- Tasks completed, tasks skipped (with the reason) and tasks left in progress.
- Evidence: builds and tests with their results, and the review verdict.
- Deviations from the plan, risks and open questions.

## Extensions (only when requested)

| Request | Action |
|---------|--------|
| Deploy and test | Follow the project's deployment instructions and verify the result on the authorized target. |
| Open or revise a pull request | Follow the repository's publishing workflow. Confirm the requested scope before any push. |
| Merge locally | Wait for final review to pass. Check that the target checkout is not in use by another agent. |

Never push or deploy without explicit authorization.

## Common Mistakes

- Re-planning or restructuring the epic instead of executing it.
- Accepting subagent output without reading the diff.
- Waiting idle on a subagent, build or review when another independent task is ready.
- Running `code-reviewer` after every task when the default is once at the end.
- Treating a submitted or timed-out review as complete.
- Changing code after the final review starts without running it again.
- Closing beads tasks on unit tests alone.
- Pushing, deploying, or opening a pull request without being asked.

## Reference Files

- `references/agent-prompt-template.md`: the prompt for dispatching a subagent.
- `references/review-checklist.md`: what to check in every subagent diff.

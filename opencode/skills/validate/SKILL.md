---
name: validate
description: 'Get an objective second opinion from the code-reviewer subagent on a specific decision, design, or approach — not a full diff review. Use to choose between alternatives, validate an architectural decision, or sanity-check a plan or beads epic before building. Triggers on: "is this the right approach", "which option is better", "validate this epic/plan", "second opinion", "sanity check". Validation only — do NOT implement.'
---

# Validate (second-opinion gate)

Get the `code-reviewer` subagent to objectively assess a decision **before** committing to it. This is a *decision gate*, not a review of a finished diff. The agent making the decision should not also grade it — delegate the judgment.

## When to use

- Choosing between alternatives (which pattern, design, or library).
- Validating a plan or beads epic before implementation starts.

## Steps

1. **Gather context.** Read the relevant files; use explore agents if needed to understand the decision space.
2. **Frame the brief** for code-reviewer — include:
   - the specific decision or question
   - relevant filepaths **with line numbers**
   - every alternative considered, with pros/cons for each
   - your current recommendation and reasoning
3. **Delegate to code-reviewer** via `subagent`. Let it assess objectively. If unavailable, say that independent validation could not run.
4. **Report the verdict** honestly — summarize the recommendation and include any concerns verbatim, even if they contradict your preference.

## Rules

- Validation only — do **NOT** implement anything here.
- Present alternatives fairly; no bias toward your own preference.
- Always include specific filepaths and line numbers in the brief.
- If code-reviewer asks for more context, gather it and respond.
- If code-reviewer and you disagree, code-reviewer wins.
- If something is truly unresolvable (missing credentials, a business decision only the user can make), list it concisely rather than guessing.

> Skill form of the `/validate` command — same logic, but auto-loads whenever an agent hits a decision gate instead of needing manual invocation.

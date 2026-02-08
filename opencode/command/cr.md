---
description: Generate CR description - usage /cr <custom prompt>
model: github-copilot/gpt-5.2-codex
---

Generate concise code review description for Amazon CRUX.

User focus: $ARGUMENTS

Review uncommitted changes:
- Unstaged: `git --no-pager diff`
- Staged: `git --no-pager diff --cached`

Analyze changes and generate structured markdown:

# [Concise title]

## Why
[1-2 sentences: business/technical motivation]

## Changes
[Grouped bullet points]

## Testing
[Validation approach - scannable]

Rules:
- Simple, direct language
- Focus WHAT/WHY not HOW
- Omit obvious details
- Group related changes
- Under 200 words
- Never "PR", always "CR"
- Pay attention to user focus above
- Plain markdown only

CRITICAL: Only generates text. Never creates/publishes/auto-merges CRs. User manually reviews output.

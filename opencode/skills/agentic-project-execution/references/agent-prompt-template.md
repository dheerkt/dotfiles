# Agent Prompt Template

Use this template when dispatching a general agent for implementation tasks.

## Template

```
You are implementing task [TASK_ID]: "[TASK_TITLE]" for [PROJECT] at [ABSOLUTE_PATH].

## Context
[2-3 sentences: what exists, what this task adds, how it fits]

## What you must do

### Step 1: Read existing files
[List 3-8 files the agent MUST read before writing. Include what to look for.]
- /path/to/types.ts (ChatMessage, ToolCall types)
- /path/to/hook.ts (useChat interface — what it returns)
- /path/to/reference-impl.tsx (inspiration, don't copy directly)

### Step 2: Create [files]
[For each file, specify:]

**src/path/to/file.ts**:
- Purpose: [one line]
- Exports: [function signatures or type names]
- Key logic: [pseudocode or code snippets for non-obvious parts]
- Dependencies: [what it imports from where]

[Repeat for each file]

### Step 3: Update [existing files] (if any)
[Specify exact changes to existing files]

## Code style rules
- [Project-specific rules]
- No any type — use unknown where needed
- No emojis in code/logs

## Verification
After writing all files, read them back and verify:
1. All imports resolve to existing files/packages
2. [Domain-specific checks]
3. No any types
4. [Integration checks — does it compose with adjacent code?]

Do not commit or edit Beads. The parent reviews your work and handles any authorized commits.

Return a summary of what you created and any decisions you made.
```

## Key principles

### Read-first
Every prompt starts with reading existing files. Agents without context hallucinate.

### Show the shape
Include TypeScript interfaces, function signatures, state shapes in the prompt. This prevents the agent from inventing incompatible types.

```
// Include this in the prompt:
interface ChatState {
  messages: ChatMessage[]
  streamingMessage: ChatMessage | null
  status: 'idle' | 'streaming' | 'error'
}
```

### Name anti-patterns
"Do NOT use axios — use native fetch for SSE streaming support" is better than "Use native fetch". Agents default to popular patterns unless told otherwise.

### One task per dispatch
A prompt that says "build the API layer AND the SSE engine AND the chat state" produces worse output than three focused prompts. Each dispatch should create 1-5 files.

### Include verification
"Read files back and check imports" catches ~30% of issues before review. Always include a verification step.

### Reference files are mandatory
3-8 file paths per prompt. Include:
- Files the agent will import from (types, utils)
- Files the agent's output will be imported by (to match interfaces)
- Reference implementations for patterns (with "for inspiration, don't copy" caveat)

## Prompt sizing

- Simple component (1 file): ~200 words
- Hook + types (2-3 files): ~400 words
- Service layer (3-5 files): ~600 words
- Never exceed ~800 words — split into multiple dispatches instead

## Parallel dispatch

Dispatch multiple agents when tasks share no files:
```
// Good: different directories, no shared state
Task A: src/services/  (API layer)
Task B: src/components/layout/  (routing)

// Bad: both modify the same file
Task A: updates ChatPage.tsx
Task B: updates ChatPage.tsx
```

When parallel agents both need to modify the same file, dispatch sequentially. The second agent reads the first agent's output.

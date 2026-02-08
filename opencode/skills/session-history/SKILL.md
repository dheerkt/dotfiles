---
name: session-history
description: Search and analyze past OpenCode sessions and plans. Use when needing to recall previous decisions, find what was discussed, understand project context from past sessions, or locate specific conversations. Triggers on questions like "what did we do", "find previous", "search sessions", "past context", "what was decided", "history of".
---

# Session History Search

Search past OpenCode sessions and plans to maintain context across conversations.

## Storage Locations

```
~/.local/share/opencode/storage/
├── message/ses_*/msg_*.json   # Message metadata (role, time, summary)
├── part/msg_*/prt_*.json      # Actual content (text, tool calls, diffs)
├── session/<hash>/*.json      # Session metadata by project (has directory field)
└── todo/                       # Todo lists

~/.local/share/opencode/plans/  # Plan files (markdown) - NOT project-scoped
```

## Search Script

```bash
# Search all sessions
~/.config/opencode/skills/session-history/scripts/search.sh "TERM"

# Search current project only (sessions only, plans always global)
~/.config/opencode/skills/session-history/scripts/search.sh "TERM" --project

# Search plans only (always searches ALL plans - no project filtering)
~/.config/opencode/skills/session-history/scripts/search.sh "TERM" --plans
```

**Note:** Plans are stored as flat files without project metadata. `--project` only filters sessions, not plans.

## Quick Commands

### Search all message content
```bash
grep -rh "TERM" ~/.local/share/opencode/storage/part/ | head -100
```

### List sessions for current project
```bash
cwd=$(echo "$PWD" | sed 's|^/home/\([^/]*\)/workplace/|/workplace/\1/|')
cat ~/.local/share/opencode/storage/session/*/*.json | jq -rs --arg dir "$cwd" '.[] | select(.directory | startswith($dir)) | {id, title, directory}'
```

### List plans
```bash
ls -lt ~/.local/share/opencode/plans/
```

## jq Patterns

### Extract text from parts
```bash
cat ~/.local/share/opencode/storage/part/msg_*/prt_*.json | jq -rs '.[] | select(.text) | .text' | grep -i "TERM"
```

### Get message summaries
```bash
cat ~/.local/share/opencode/storage/message/ses_*/msg_*.json | jq -rs '.[] | select(.summary.title) | {role, title: .summary.title}'
```

### Find tool results containing term
```bash
cat ~/.local/share/opencode/storage/part/msg_*/prt_*.json | jq -rs '.[] | select(.type=="tool-result") | select(.result | contains("TERM")) | .result[:500]'
```

## Data Structure

### Session metadata (session/<hash>/*.json)
```json
{"id": "ses_...", "directory": "/path/to/project", "title": "...", "time": {...}}
```

### Message metadata (message/ses_*/msg_*.json)
```json
{"id": "msg_...", "role": "user|assistant", "summary": {"title": "..."}, "agent": "plan|build"}
```

### Part content (part/msg_*/prt_*.json)
```json
{"type": "text|tool-invocation|tool-result", "text": "...", "name": "bash|read|..."}
```

# Global Rules

## Interactions

In all interactions and commit messages, ALWAYS be extremely concise when responding to the user. Sacrifice grammar and niceities for the sake of concision.

After completing a coding task or feature, delegate to code-reviewer subagent to review changes before considering work complete.

## Codestyle

Try to keep things in one function unless composable or reusable
DO NOT do unnecessary destructuring of variables
DO NOT use else statements unless necessary
DO NOT use try/catch if it can be avoided
DO NOT use emojis in code/logs
AVOID try/catch where possible
AVOID else statements
AVOID using any type
AVOID let statements
PREFER single word variable names where possible

## Git

Use `git --no-pager` for all git read commands - for example: `git --no-pager show`, `git --no-pager diff`, `git --no-pager log`

## Plans

- At the end of each plan, give me a list of unresolved questions to answer, if any. Make the questions extremely concise. Sacrifice grammar for the sake of concision.

## Issue Tracking with bd (beads)

**IMPORTANT**: This project uses **bd (beads)** for ALL issue tracking. Do NOT use markdown TODOs, task lists, or other tracking methods.

## __Comprehensive BD Commands Reference__

### __Core Issue Management__

- __`bd ready --json`__ - Show all ready work (unblocked, open/in-progress issues)
- __`bd show [issue-id] --json`__ - Show basic issue details without comments
- __`bd list --json`__ - List all issues with basic info
- __`bd create "title" -t task|bug|feature -p 0-4 --json`__ - Create new issue

### __Comments & Documentation__

- __`bd comments [issue-id] --json`__ - View all comments on a specific issue
- __`bd comment [issue-id] "comment text" --json`__ - Add new comment to an issue
- __`bd comments add [issue-id] "comment text"`__ - Alternative comment syntax

### __Issue Updates__

- __`bd update [issue-id] --status open|closed --json`__ - Change issue status
- __`bd update [issue-id] --notes "notes text" --json`__ - Add/update notes (may have size limits)
- __`bd update [issue-id] --description "new description" --json`__ - Update description
- __`bd update [issue-id] --priority 0-4 --json`__ - Change priority
- __`bd close [issue-id] --reason "reason" --json`__ - Close issue with reason

### __System Management__

- __`bd doctor`__ - Comprehensive system diagnostics
- __`bd migrate`__ - Fix database issues/corruption
- __`bd help`__ - Full command reference with all available subcommands

### __Advanced Filtering__

- __`bd list --json | jq '.[] | select(.status == "open")'`__ - Filter issues with jq
- __`bd list --json | jq '.[] | select(.id == "issue-id")'`__ - Find specific issue

### __Key Discoveries__

1. __Comments are superior to notes__ - Notes have size limitations and cause EOF errors, comments work reliably
2. __Database issues are common__ - Use `bd doctor` and `bd migrate` when getting EOF errors
3. __JSON output is essential__ - Always use `--json` for programmatic use
4. __Comments preserve formatting__ - Better for detailed documentation than description field

### __Best Practices__

- Use comments for detailed troubleshooting logs
- Use description for high-level status summaries
- Always include `--json` for reliable parsing
- Run `bd doctor` if experiencing database issues
- Use `bd migrate` to fix corruption

### Issue Types

- `bug` - Something broken
- `feature` - New functionality
- `task` - Work item (tests, docs, refactoring)
- `epic` - Large feature with subtasks
- `chore` - Maintenance (dependencies, tooling)

### Priorities

- `0` - Critical (security, data loss, broken builds)
- `1` - High (major features, important bugs)
- `2` - Medium (default, nice-to-have)
- `3` - Low (polish, optimization)
- `4` - Backlog (future ideas)

### Workflow for AI Agents

1. **Check ready work**: `bd ready` shows unblocked issues
2. **Claim your task**: `bd update <id> --status in_progress`
3. **Work on it**: Implement, test, document
4. **Discover new work?** Create linked issue:
   - `bd create "Found bug" -p 1 --deps discovered-from:<parent-id>`
5. **Complete**: `bd close <id> --reason "Done"`
6. **Commit together**: Always commit the `.beads/issues.jsonl` file together with the code changes so issue state stays in sync with code state

### Auto-Sync

bd automatically syncs with git:
- Exports to `.beads/issues.jsonl` after changes (5s debounce)
- Imports from JSONL when newer (e.g., after `git pull`)
- No manual export/import needed!

### Managing AI-Generated Planning Documents

AI assistants often create planning and design documents during development:
- PLAN.md, IMPLEMENTATION.md, ARCHITECTURE.md
- DESIGN.md, CODEBASE_SUMMARY.md, INTEGRATION_PLAN.md
- TESTING_GUIDE.md, TECHNICAL_DESIGN.md, and similar files

**Best Practice: Use a dedicated directory for these ephemeral files**

**Recommended approach:**
- Create a `history/` directory in the project root
- Store ALL AI-generated planning/design docs in `history/`
- Keep the repository root clean and focused on permanent project files
- Only access `history/` when explicitly asked to review past planning

**Example .gitignore entry (optional):**
```
# AI planning documents (ephemeral)
history/
```

**Benefits:**
- Clean repository root
- Clear separation between ephemeral and permanent documentation
- Easy to exclude from version control if desired
- Preserves planning history for archeological research
- Reduces noise when browsing the project

### Important Rules

- Use bd for ALL task tracking
- Always use `--json` flag for programmatic use
- Link discovered work with `discovered-from` dependencies
- Check `bd ready` before asking "what should I work on?"
- Store AI planning docs in `history/` directory
- Do NOT close a beads task or mark it as completed without manual testing
- Do NOT create markdown TODO lists
- Do NOT use external issue trackers
- Do NOT duplicate tracking systems
- Do NOT clutter repo root with planning documents

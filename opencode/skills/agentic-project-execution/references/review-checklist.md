# Review Checklist

Check every subagent diff against these categories before you commit it. Apply the sections that are relevant to the package. Reviews often miss build errors, contract mismatches and Rules of Hooks violations. This checklist catches those.

## Build blockers

- [ ] Unused variables/imports with `noUnusedLocals` enabled (tsc will fail)
- [ ] JSX in `.ts` files (must be `.tsx`)
- [ ] Missing exports that other files import
- [ ] Circular imports between modules

## React correctness

- [ ] **Rules of Hooks**: No hooks after early returns, no hooks in conditionals
- [ ] **useEffect cleanup**: AbortControllers aborted, timers cleared, listeners removed
- [ ] **useEffect deps**: All referenced values in dependency array (or documented why excluded)
- [ ] **React.memo comparison**: Does the custom areEqual function catch all meaningful prop changes? Common miss: comparing array length but not item statuses
- [ ] **Controlled vs uncontrolled**: Components don't switch between controlled/uncontrolled across renders (e.g. defaultOpen prop read only on mount)

## State management

- [ ] **Immutable updates**: Reducer returns new objects, never mutates state
- [ ] **Null guards**: Reducer handles actions when streamingMessage/activeSession is null
- [ ] **Dead state**: Every useState is both set AND read. Watch for state set in handlers but never rendered.
- [ ] **Race conditions**: What happens if user sends message while previous stream is active?

## API integration

- [ ] **Routes match backend**: Verify API paths against actual handler code, not docs
- [ ] **Auth mechanism correct**: Right SigV4 service name per API (execute-api vs bedrock-agentcore)
- [ ] **Error handling**: Network failures, 401/403, malformed responses all handled
- [ ] **Units match**: milliseconds vs seconds, bytes vs kilobytes

## Type safety

- [ ] No `any` types (search for `: any` and `as any`)
- [ ] No `@ts-ignore` or `@ts-expect-error`
- [ ] Discriminated unions exhaustively handled in switch/case
- [ ] Optional chaining on API response fields that may be undefined

## Agent-specific mistakes

These are the most common mistakes general agents make:

1. **Fabricated APIs**: Agent invents routes/endpoints that don't exist. Always verify against backend code.
2. **Wrong import paths**: Agent uses relative paths when project uses @/ aliases, or vice versa.
3. **Duplicate code**: Agent re-implements a utility that already exists in the codebase.
4. **Over-engineering**: Agent adds features not requested (error boundaries, analytics, logging).
5. **Stale patterns**: Agent uses class components, componentDidMount, or other outdated React patterns.
6. **Missing barrel exports**: Agent creates files but forgets to add them to index.ts.

## When to re-dispatch vs fix

**Fix yourself** (1-3 edits):
- Wrong import path
- Missing optional chaining
- Unused variable
- Unit conversion

**Re-dispatch agent** (fundamental issue):
- Wrong architecture (e.g. used Zustand when plan said useReducer)
- Fabricated API that doesn't exist
- Component doesn't compose with adjacent code
- >5 issues in a single file

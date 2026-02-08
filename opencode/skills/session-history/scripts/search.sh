#!/bin/bash
# Search OpenCode session history
# Usage: search.sh "TERM" [--project] [--plans]

TERM=""
PROJECT_ONLY=false
PLANS_ONLY=false
STORAGE=~/.local/share/opencode/storage
PLANS=~/.local/share/opencode/plans

# Parse args
for arg in "$@"; do
  case $arg in
    --project) PROJECT_ONLY=true ;;
    --plans) PLANS_ONLY=true ;;
    *) [ -z "$TERM" ] && TERM="$arg" ;;
  esac
done

if [ -z "$TERM" ]; then
  echo "Usage: search.sh TERM [--project] [--plans]"
  echo "  --project  Search only current project sessions"
  echo "  --plans    Search only plan files"
  exit 1
fi

# Plans only
if [ "$PLANS_ONLY" = true ]; then
  echo "=== Plans containing '$TERM' ==="
  grep -l "$TERM" "$PLANS"/*.md 2>/dev/null | while read f; do
    echo "--- $(basename $f) ---"
    grep -n -C2 "$TERM" "$f" | head -20
  done
  exit 0
fi

# Normalize path (handle /home/user/workplace -> /workplace/user)
normalize_path() {
  echo "$1" | sed 's|^/home/\([^/]*\)/workplace/|/workplace/\1/|'
}

# Search messages
echo "=== Messages containing '$TERM' ==="

if [ "$PROJECT_ONLY" = true ]; then
  cwd=$(normalize_path "$PWD")
  sessions=$(cat "$STORAGE"/session/*/*.json 2>/dev/null | \
    jq -rs --arg dir "$cwd" '.[] | select(.directory | startswith($dir)) | .id')
  
  if [ -z "$sessions" ]; then
    echo "No sessions found for: $cwd"
  else
    echo "$sessions" | while read ses; do
      [ -z "$ses" ] && continue
      for msgfile in "$STORAGE/message/$ses"/*.json; do
        [ -f "$msgfile" ] || continue
        msgid=$(jq -r '.id' "$msgfile" 2>/dev/null)
        partdir="$STORAGE/part/$msgid"
        [ -d "$partdir" ] || continue
        if grep -q "$TERM" "$partdir"/*.json 2>/dev/null; then
          title=$(jq -r '.summary.title // "no title"' "$msgfile")
          echo "--- $msgid ($title) ---"
          cat "$partdir"/prt_*.json 2>/dev/null | jq -rs '.[] | .text // .result // empty' | grep -C1 "$TERM" 2>/dev/null | head -20
          echo ""
        fi
      done
    done
  fi
else
  grep -rl "$TERM" "$STORAGE"/part/ 2>/dev/null | head -30 | while read f; do
    msgid=$(basename $(dirname "$f"))
    jq -r '.text // .result // empty' "$f" 2>/dev/null | grep -C1 "$TERM" 2>/dev/null | head -15
    echo ""
  done
fi

# Search plans
echo ""
echo "=== Plans containing '$TERM' ==="
grep -l "$TERM" "$PLANS"/*.md 2>/dev/null | while read f; do
  echo "--- $(basename $f) ---"
  grep -n "$TERM" "$f" | head -5
done

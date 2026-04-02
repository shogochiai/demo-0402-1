#!/bin/bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  scripts/demo-send.sh <role> <command...>

Roles:
  flow | reviewer | ip | release | colony | auditor

Notes:
  - Human-operated panes reject injection by default.
  - Set DEMO_ALLOW_HUMAN_INJECT=1 to override.
EOF
}

role_to_pane() {
  case "$1" in
    flow) echo 0 ;;
    reviewer) echo 1 ;;
    ip) echo 2 ;;
    release) echo 3 ;;
    colony) echo 4 ;;
    auditor) echo 5 ;;
    *) return 1 ;;
  esac
}

role_to_title() {
  case "$1" in
    flow) echo flow-monitor ;;
    reviewer) echo reviewer ;;
    ip) echo ip-proposer ;;
    release) echo release-proposer ;;
    colony) echo colony-daemon ;;
    auditor) echo auditor ;;
    *) return 1 ;;
  esac
}

is_human_role() {
  case "$1" in
    reviewer|ip|release|auditor) return 0 ;;
    *) return 1 ;;
  esac
}

[[ $# -ge 2 ]] || { usage; exit 1; }
ROLE="$1"
shift
PANE="$(role_to_pane "$ROLE")" || { echo "ERROR: unknown role: $ROLE" >&2; exit 1; }
TITLE_EXPECTED="$(role_to_title "$ROLE")"
SESSION="${SESSION:-etherclaw-$(basename "$PWD" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9_-]/-/g; s/-\{2,\}/-/g; s/^-//; s/-$//')}"

if is_human_role "$ROLE" && [[ "${DEMO_ALLOW_HUMAN_INJECT:-0}" != "1" ]]; then
  echo "ERROR: role '$ROLE' is human-operated. Set DEMO_ALLOW_HUMAN_INJECT=1 to override." >&2
  exit 1
fi

TITLE_ACTUAL="$(tmux display-message -p -t "$SESSION:0.$PANE" '#{pane_title}' 2>/dev/null || true)"
[[ -n "$TITLE_ACTUAL" ]] || { echo "ERROR: pane $PANE not found in session $SESSION" >&2; exit 1; }
[[ "$TITLE_ACTUAL" == "$TITLE_EXPECTED" ]] || {
  echo "ERROR: pane $PANE title mismatch. expected=$TITLE_EXPECTED actual=$TITLE_ACTUAL" >&2
  exit 1
}

echo "[demo-send] session=$SESSION role=$ROLE pane=$PANE title=$TITLE_ACTUAL"
tmux capture-pane -t "$SESSION:0.$PANE" -p | tail -20
tmux send-keys -t "$SESSION:0.$PANE" "$*" Enter

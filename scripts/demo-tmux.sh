#!/bin/bash
# EtherClaw Demo: tmux 6-pane layout (timeline order, left→right, top→bottom)
#
# +-----------------+-----------------+-----------------+
# | 0: Flow Monitor | 2: IP Proposer  | 4: Colony       |
# |  flow --watch   |  ip propose     |  daemon         |
# +-----------------+-----------------+-----------------+
# | 1: Reviewer     | 3: Rel Proposer | 5: Auditor      |
# |  review approve |  release propose|  auditor vote   |
# +-----------------+-----------------+-----------------+
#
# Timeline: Flow → IP Proposer → Colony → Reviewer → Release Proposer → Auditor

DEMO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
resolve_etherclaw_bin() {
  if [[ -n "${ETHERCLAW_BIN:-}" ]] && [[ -x "$ETHERCLAW_BIN" ]]; then
    printf '%s\n' "$ETHERCLAW_BIN"
    return
  fi

  local root app fallback
  for root in "${ETHERCLAW_ROOT:-}" "$HOME/code/etherclaw"; do
    [[ -n "$root" ]] || continue
    [[ -d "$root" ]] || continue
    if app="$(cd "$root" && pack app-path etherclaw 2>/dev/null)" && [[ -x "$app" ]]; then
      printf '%s\n' "$app"
      return
    fi
  done

  fallback="$(ls -t "$HOME"/.local/state/pack/install/*/etherclaw/*/bin/etherclaw 2>/dev/null | head -1 || true)"
  if [[ -n "$fallback" ]] && [[ -x "$fallback" ]]; then
    printf '%s\n' "$fallback"
    return
  fi

  if command -v etherclaw >/dev/null 2>&1; then
    printf '%s\n' etherclaw
    return
  fi

  echo 'ERROR: could not resolve etherclaw binary. Set ETHERCLAW_BIN or ETHERCLAW_ROOT.' >&2
  exit 1
}
ETHERCLAW_BIN="$(resolve_etherclaw_bin)"

sanitize_session() {
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9_-]/-/g; s/-\{2,\}/-/g; s/^-//; s/-$//'
}
DEFAULT_SESSION="etherclaw-$(sanitize_session "$(basename "$DEMO_DIR")")"
SESSION="${SESSION:-$DEFAULT_SESSION}"

tmux kill-session -t "$SESSION" 2>/dev/null

# Build 3x2 grid: create top row first, then split each vertically

# Pane 0: Flow Monitor
tmux new-session -d -s "$SESSION" -c "$DEMO_DIR" -x 200 -y 60

# Split horizontally to get 2 columns, then split right column again for 3 columns
tmux split-window -h -t "$SESSION:0.0" -c "$DEMO_DIR" -p 66
tmux split-window -h -t "$SESSION:0.1" -c "$DEMO_DIR" -p 50
# Now: 0=Flow, 1=middle, 2=right

# Split each column vertically (bottom row)
tmux split-window -v -t "$SESSION:0.0" -c "$DEMO_DIR"
# Now: 0=Flow(top-left), 1=Reviewer(bottom-left), 2=middle-top, 3=right-top
tmux split-window -v -t "$SESSION:0.2" -c "$DEMO_DIR"
# Now: 0=Flow, 1=Reviewer, 2=IP-Proposer(top-mid), 3=RelProposer(bottom-mid), 4=right-top
tmux split-window -v -t "$SESSION:0.4" -c "$DEMO_DIR"
# Now: 0=Flow, 1=Reviewer, 2=IP-Proposer, 3=RelProposer, 4=Colony(top-right), 5=Auditor(bottom-right)

# Assign stable pane titles for role-based supervision
tmux select-pane -t "$SESSION:0.0" -T flow-monitor
tmux select-pane -t "$SESSION:0.1" -T reviewer
tmux select-pane -t "$SESSION:0.2" -T ip-proposer
tmux select-pane -t "$SESSION:0.3" -T release-proposer
tmux select-pane -t "$SESSION:0.4" -T colony-daemon
tmux select-pane -t "$SESSION:0.5" -T auditor

# Send commands to each pane (printf banner + command)
tmux send-keys -t "$SESSION:0.0" "clear && printf '\n  FLOW MONITOR\n  ----------------------------------------\n  Pipeline status (60s refresh)\n\n' && \"$ETHERCLAW_BIN\" flow --watch --online --instance td 2>/dev/null || echo Waiting..." Enter
tmux send-keys -t "$SESSION:0.2" 'clear && printf "\n  IP PROPOSER (Shareholder)\n  ----------------------------------------\n  etherclaw ip propose --file docs/prd/...\n\n"' Enter
tmux send-keys -t "$SESSION:0.4" "clear && printf '\n  COLONY (Daemon)\n  ----------------------------------------\n  Autonomous IP implementation\n\n' && mkdir -p .etherclaw/logs && \"$ETHERCLAW_BIN\" daemon --governed 2>/dev/null && tail -f .etherclaw/logs/standalone.log 2>/dev/null | grep -v '^WARNING'" Enter
tmux send-keys -t "$SESSION:0.1" 'clear && printf "\n  REVIEWER\n  ----------------------------------------\n  etherclaw review approve <PR#>\n\n"' Enter
tmux send-keys -t "$SESSION:0.3" 'clear && printf "\n  RELEASE PROPOSER\n  ----------------------------------------\n  etherclaw release propose --ips N,N --version v1.x.0\n\n"' Enter
tmux send-keys -t "$SESSION:0.5" 'clear && printf "\n  AUDITOR\n  ----------------------------------------\n  etherclaw auditor vote --release N --approve\n\n"' Enter

tmux select-pane -t "$SESSION:0.2"
tmux attach-session -t "$SESSION"

---
name: demo-operations
description: Run and supervise the EtherClaw governed demo for td
triggers:
  - demo
  - demo-tmux
  - codex --yolo
  - tmux
  - vibecoding
---

# Demo Operations

## Startup

Run startup from the repo root after the first push and branch protection setup:

```bash
SESSION="${SESSION:-etherclaw-$(basename "$PWD" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9_-]/-/g; s/-\{2,\}/-/g; s/^-//; s/-$//')}"
./scripts/demo-tmux.sh
```

The session name is derived from the directory basename unless `SESSION` is set.

## Pane Layout

- tmux pane 0: Flow monitor (top-left)
- tmux pane 1: Reviewer (bottom-left)
- tmux pane 2: IP proposer (top-middle)
- tmux pane 3: Release proposer (bottom-middle)
- tmux pane 4: Colony daemon (top-right)
- tmux pane 5: Auditor (bottom-right)

## Codex Supervision

Use `docs/latest/CODEX_DEMO_SUPERVISOR.md` as the initial prompt context.

Rules:

- Human starts the tmux session.
- Codex observes with `tmux capture-pane`.
- Codex may suggest next commands from the runbook.
- Codex should inject commands only into existing panes, never create a new session.
- Codex should prefer `./scripts/demo-send.sh <role> <command...>` over raw `tmux send-keys`.
- Human-operated panes (`ip`, `reviewer`, `release`, `auditor`) reject injection unless `DEMO_ALLOW_HUMAN_INJECT=1` is set.

## Scene Summary

1. Intro — explain the 6-pane topology and the left-to-right lifecycle.
2. IP propose — submit PRDs from `docs/prd/*.md`.
3. Colony execution — wait for finalized IP detection, implementation, and PR creation.
4. Review — inspect PRs, dump-s, drift-check, and flow.
5. Release — propose release, vote, auditor approve, execute release.

## Source of Truth

- Local skill: `.claude/skills/demo-operations/SKILL.md`
- Local prompt: `docs/latest/CODEX_DEMO_SUPERVISOR.md`
- Safe injector: `scripts/demo-send.sh`
- Demo PRDs: `docs/prd/*.md`

## Demo Instance

- ENS: `td.onthe.eth`
- Instance display name: `td`

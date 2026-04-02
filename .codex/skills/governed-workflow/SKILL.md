---
name: governed-workflow
description: Governed PR and release workflow for the td demo
triggers:
  - governed
  - review approve
  - release propose
  - auditor vote
  - governance-gate
---

# Governed Workflow

This repo is expected to run against TheWorld instance `td.onthe.eth`.

## PR Flow

1. Colony daemon observes finalized IP proposals.
2. Colony implements changes in the repo and opens a PR.
3. `review create` / `review approve` bridge PR review state into TheWorld.
4. GitHub Actions enforce `governance-gate` before merge.
5. Auto-merge merges approved PRs back to `main`.

## Release Flow

1. Shareholder runs `etherclaw release propose --ips ... --version ...`.
2. Timer moves the release proposal into voting.
3. Shareholder casts ranked vote.
4. Auditor votes `approve` on the selected release.
5. `etherclaw release execute` creates the GitHub release/tag.

## Operational Commands

```bash
etherclaw flow --online --instance td
etherclaw review approve <PR#>
etherclaw release propose --ips N,N --version v1.x.0 --instance td.onthe.eth
etherclaw auditor vote --release N --approve --instance td.onthe.eth
```

## Failure Handling

- If branch protection is missing, run `./scripts/setup-branch-protection.sh`.
- If the daemon appears idle, inspect the tmux Colony pane before mutating state.
- Use `etherclaw flow --online` as the first status check.

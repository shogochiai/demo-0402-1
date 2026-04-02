# Add getProposalState view to TextDAO (fresh rerun)

## 1. Intro & Goal

**Title:** Add getProposalState view to TextDAO (fresh rerun)

**Goal:** Expose a read-only TextDAO view that returns the current state for a
proposal ID so clients can inspect proposal lifecycle without decoding storage
manually.

## 2. Scope

- Package root: `pkgs/Idris2TextDao`
- Do not create repo-root `src/`, `tests/`, `deploy/`, `scripts/`, `EVM/`,
  `Governance/`, or `Src/`.
- Reuse the existing proposal state logic already used internally by the
  contract.

## 3. Requirements

REQ_PROPOSAL_STATE_001: Add a read-only `getProposalState(uint256) -> uint8`
function entry in `pkgs/Idris2TextDao` that returns the stored or derived state
for the requested proposal ID.

REQ_PROPOSAL_STATE_002: Wire a new selector/signature/export so the view is
discoverable from the Propose module entry set and documented in the package
README.

REQ_PROPOSAL_STATE_003: Add tests under the package root that cover at least
pending, active, and finalized proposal states through the new view.

## 4. Acceptance

- The implementation stays inside `pkgs/Idris2TextDao`.
- The new view is externally callable through the package's public interface.
- Tests demonstrate the new view matches existing proposal state semantics.

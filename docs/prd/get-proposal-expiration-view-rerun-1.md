# Add getProposalExpiration view to TextDAO

## 1. Intro & Goal

**Title:** Add getProposalExpiration view to TextDAO

**Goal:** Expose a read-only TextDAO view that returns the stored expiration
timestamp for a proposal ID so clients can inspect proposal timing without
decoding storage manually.

## 2. Scope

- Package root: `pkgs/Idris2TextDao`
- Do not create repo-root `src/`, `tests/`, `deploy/`, `scripts/`, `EVM/`,
  `Governance/`, or `Src/`.
- Reuse the existing proposal expiration storage logic already used internally
  by the contract.

## 3. Requirements

REQ_PROPOSAL_EXPIRATION_001: Add a read-only
`getProposalExpiration(uint256) -> uint256` function entry in
`pkgs/Idris2TextDao` that returns the stored expiration timestamp for the
requested proposal ID.

REQ_PROPOSAL_EXPIRATION_002: Wire a new selector/signature/export so the view
is discoverable from the Propose module entry set and documented in the package
README.

REQ_PROPOSAL_EXPIRATION_003: Add tests under the package root that cover at
least a freshly created proposal and a manually updated expiration through the
new view.

## 4. Acceptance

- The implementation stays inside `pkgs/Idris2TextDao`.
- The new view is externally callable through the package's public interface.
- Tests demonstrate the new view matches existing proposal expiration storage.

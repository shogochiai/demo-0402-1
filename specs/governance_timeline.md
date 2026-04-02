# Governance Timeline Read API

## Goal

Provide a read-only governance timeline endpoint for UI rendering that returns
the lifecycle checkpoints for a single `proposalId`:

- `propose`
- `vote`
- `tally`
- `execute`

Each checkpoint returns a `timestamp` and a presence flag so a UI can render a
stable timeline without decoding historical logs.

## Selector Surface

- `getGovernanceTimeline(uint256)` -> `0x1c28430c`
- `getImplementation(bytes4)` -> `0xdc9cc645`

The runtime keeps the ERC-7546 selector surface available so a proxy or
dictionary can introspect the timeline implementation in the same way it
introspects other upgradeable clone targets.

## Response Schema

`getGovernanceTimeline(uint256 proposalId)` returns a fixed ABI tuple:

```solidity
(
  uint256 proposalId,
  uint256[4] eventCodes,
  uint256[4] timestamps,
  uint256[4] statuses
)
```

Event codes are stable and ordered:

- `1` = `propose`
- `2` = `vote`
- `3` = `tally`
- `4` = `execute`

Status values:

- `0` = no checkpoint recorded
- `1` = checkpoint recorded

This is intentionally ABI-safe and static:

- no dynamic arrays
- no nested dynamic tuples
- one fixed return frame for every `proposalId`

## Storage Read Model

The read model follows the TextDAO-style deliberation layout used by the Idris2
Yul examples and keeps the implementation storage-free:

- `proposalSlot = keccak256(abi.encode(proposalId, SLOT_DELIBERATION))`
- `metaSlot = proposalSlot + 0x30`

Metadata offsets used by the timeline reader:

- `meta + 0` -> `propose` / `createdAt`
- `meta + 7` -> `vote` / `lastVoteAt`
- `meta + 8` -> `tally` / `lastTallyAt`
- `meta + 9` -> `execute` / `executedAt`

The `tally` checkpoint is allowed to coexist with approved-header /
approved-command state, but the canonical `timestamp` source for the read API is
the dedicated `lastTallyAt` slot.

## ERC-7546 Compatibility

The implementation must remain proxy-compatible:

- read-only only, no `sstore`
- safe under `delegatecall`
- self-describes its selector mapping through `getImplementation(bytes4)`

Expected behavior for `getImplementation(bytes4)`:

- timeline selector -> return implementation address
- `getImplementation(bytes4)` selector -> return implementation address
- any unknown selector -> return `0`

This mirrors the selector-routing pattern used in `idris2-subcontract` and the
`Dictionary.idr` / proxy examples, while keeping the governance timeline logic
isolated from mutable dictionary storage.

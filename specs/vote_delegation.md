## Vote Delegation And Revocation

This specification defines the shareholder vote delegation extension for the
`theworld-ip-43` implementation. The extension is designed for an
`ERC-7546` / `UpgradeableClone` deployment topology where proxy state lives in
clone storage and implementation logic remains proxy-compatible. The selector
and ABI surface follows the `idris2-evm` selector-dispatch pattern and the
`idris2-subcontract` `ERC7546` conventions, including
`getImplementation(bytes4)` at selector `0xdc9cc645`.

### Goals

- Allow a shareholder to delegate voting power to a `delegatee`.
- Allow the same shareholder to revoke delegation later.
- Preserve raw shareholder voting power while moving effective voting power to
  the active `delegatee`.
- Expose ABI-safe read selectors for raw and effective voting power.
- Stay compatible with `ERC-7546` dictionary/proxy routing and
  `getImplementation(bytes4)`.

### Terminology

- `shareholder`: an address with an assigned raw voting weight.
- `delegator`: the shareholder assigning voting power elsewhere.
- `delegatee`: the address receiving delegated voting power.
- `raw shareholder voting power`: the base weight assigned to a shareholder.
- `delegated voting power`: the aggregate inbound weight received from active
  delegators.
- `effective voting power`: the weight an address can currently use for voting.

### Behavioral Model

- A shareholder may delegate only their own voting power.
- Delegation is keyed by `delegator -> delegatee`.
- A delegator has at most one active delegatee at a time.
- Re-delegation first removes the prior delegation weight from the old
  delegatee, then adds the same weight to the new delegatee.
- Revocation removes the delegator's current weight from the delegatee and
  clears the `delegator -> delegatee` mapping.
- A `delegatee` may also be a shareholder; their effective weight is their own
  undelegated shareholder weight plus all inbound delegated voting power.
- When a shareholder has delegated away their vote, their own raw shareholder
  weight no longer contributes to their effective voting power.
- Delegation to the zero address is rejected by the `delegate(address)` write
  path and is only produced by explicit revocation.
- Self-delegation is rejected to avoid ambiguous semantics.

### Storage Model

The implementation assumes clone/proxy state storage, not implementation-local
storage. Three logical mappings are used:

- `shareholder -> votingPower`
- `delegator -> delegatee`
- `delegatee -> aggregatedDelegatedVotingPower`

The implementation updates aggregate delegated weight eagerly so
`effectiveVotingPower(address)` is O(1) and does not require iterating all
shareholders.

### Selector Surface

The selector surface is intentionally compact and ABI-safe:

- `delegate(address)` -> `0x5c19a95c`
- `revokeDelegation()` -> `0xa4d31805`
- `delegationOf(address)` -> `0xf837123e`
- `shareholderVotingPower(address)` -> `0xe9c55a22`
- `delegatedVotingPower(address)` -> `0xf9a5c639`
- `effectiveVotingPower(address)` -> `0xb652a5c0`
- `getImplementation(bytes4)` -> `0xdc9cc645`

### ABI Semantics

- `delegate(address delegatee)`:
  - Caller becomes the `delegator`.
  - Reverts when `delegatee == 0`.
  - Reverts when `delegatee == caller`.
  - Returns no value.
- `revokeDelegation()`:
  - Caller becomes the `delegator`.
  - Clears the active delegation if present.
  - Returns no value.
- `delegationOf(address delegator)`:
  - Returns the current `delegatee` or zero when none is active.
- `shareholderVotingPower(address shareholder)`:
  - Returns raw shareholder weight from storage.
- `delegatedVotingPower(address delegatee)`:
  - Returns aggregate inbound delegated weight.
- `effectiveVotingPower(address shareholder)`:
  - Returns `delegatedVotingPower(shareholder)` plus raw shareholder weight when
    the shareholder has not delegated away their own vote.
- `getImplementation(bytes4 selector)`:
  - Returns the current implementation address for all delegation selectors.
  - Returns zero for unsupported selectors.

### ERC-7546 Compatibility

- `getImplementation(bytes4)` remains present with the standard `ERC-7546`
  selector `0xdc9cc645`.
- The implementation contract reports itself as the implementation for the
  delegation selector set. In a full `ERC7546` deployment this allows
  dictionary/proxy tooling to resolve the correct logic address.
- The implementation logic is suitable for `UpgradeableClone` style routing:
  it expects state in proxy storage and contains no constructor-bound state.

### Code Generation Expectations

- Idris source lives at `src/Governance/VoteDelegation.idr`.
- Yul is generated with `idris2-yul --codegen yul`.
- EVM bytecode is produced from Yul with `solc --strict-assembly`.
- No Solidity contract is introduced; the implementation follows the
  `idris2-evm` and `idris2-subcontract` pattern end to end.

### Deployment And Verification

- Deployment target: Base Mainnet.
- Signing flow: TheWorld-controlled `t-ECDSA` deployer.
- Verification flow: `IcWasm.Verification` using source -> Artifact EVM ->
  Deployed EVM provenance.

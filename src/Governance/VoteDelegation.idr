||| Shareholder vote delegation with revocation.
|||
||| This module combines a pure delegation model with an ABI-safe on-chain
||| selector dispatcher. The storage access pattern is proxy-compatible for an
||| ERC7546 / UpgradeableClone deployment and mirrors the idris2-subcontract
||| conventions around getImplementation(bytes4).
module Governance.VoteDelegation

import public EVM.Primitives
import EVM.Storage.Namespace
import Subcontract.Standards.ERC7546.Slots

%default total

-- =============================================================================
-- Pure delegation model
-- =============================================================================

public export
record Delegation where
  constructor MkDelegation
  delegator : Integer
  delegatee : Integer

public export
record VoteDelegationState where
  constructor MkVoteDelegationState
  delegationBook : List Delegation
  shareholderBook : List (Integer, Integer)
  delegatedBook : List (Integer, Integer)

export
emptyState : VoteDelegationState
emptyState = MkVoteDelegationState [] [] []

lookupAmount : Integer -> List (Integer, Integer) -> Integer
lookupAmount _ [] = 0
lookupAmount who ((candidate, amount) :: rest) =
  if who == candidate then amount else lookupAmount who rest

upsertAmount : Integer -> Integer -> List (Integer, Integer) -> List (Integer, Integer)
upsertAmount who amount [] = [(who, amount)]
upsertAmount who amount ((candidate, current) :: rest) =
  if who == candidate
    then (who, amount) :: rest
    else (candidate, current) :: upsertAmount who amount rest

clampSub : Integer -> Integer -> Integer
clampSub current delta =
  if current >= delta then current - delta else 0

adjustAmount : Integer -> Integer -> List (Integer, Integer) -> List (Integer, Integer)
adjustAmount who delta amounts =
  let current = lookupAmount who amounts
      updated = if delta < 0
        then clampSub current (0 - delta)
        else current + delta
   in upsertAmount who updated amounts

findDelegation : Integer -> List Delegation -> Maybe Delegation
findDelegation _ [] = Nothing
findDelegation delegator (delegation :: rest) =
  if delegator == delegation.delegator
    then Just delegation
    else findDelegation delegator rest

removeDelegationBy : Integer -> List Delegation -> List Delegation
removeDelegationBy _ [] = []
removeDelegationBy delegator (delegation :: rest) =
  if delegator == delegation.delegator
    then removeDelegationBy delegator rest
    else delegation :: removeDelegationBy delegator rest

export
seedShareholderVotingPower : Integer -> Integer -> VoteDelegationState -> VoteDelegationState
seedShareholderVotingPower shareholder votingPower state =
  MkVoteDelegationState
    state.delegationBook
    (upsertAmount shareholder votingPower state.shareholderBook)
    state.delegatedBook

export
shareholderVotingPower : Integer -> VoteDelegationState -> Integer
shareholderVotingPower shareholder state =
  lookupAmount shareholder state.shareholderBook

export
delegatedVotingPower : Integer -> VoteDelegationState -> Integer
delegatedVotingPower delegatee state =
  lookupAmount delegatee state.delegatedBook

export
setDelegation : Integer -> Integer -> VoteDelegationState -> VoteDelegationState
setDelegation delegator delegatee state =
  let previousDelegatee = case findDelegation delegator state.delegationBook of
        Nothing => 0
        Just delegation => delegation.delegatee
      rawVotingPower = shareholderVotingPower delegator state
      afterOldRemoval = if previousDelegatee == 0
        then state.delegatedBook
        else adjustAmount previousDelegatee (0 - rawVotingPower) state.delegatedBook
      afterNewGrant = if delegatee == 0
        then afterOldRemoval
        else adjustAmount delegatee rawVotingPower afterOldRemoval
      nextDelegations = if delegatee == 0
        then removeDelegationBy delegator state.delegationBook
        else MkDelegation delegator delegatee :: removeDelegationBy delegator state.delegationBook
   in MkVoteDelegationState nextDelegations state.shareholderBook afterNewGrant

export
clearDelegation : Integer -> VoteDelegationState -> VoteDelegationState
clearDelegation delegator state = setDelegation delegator 0 state

export
effectiveVotingPower : Integer -> VoteDelegationState -> Integer
effectiveVotingPower shareholder state =
  let incoming = delegatedVotingPower shareholder state
      rawVotingPower = shareholderVotingPower shareholder state
      hasActiveOutbound = case findDelegation shareholder state.delegationBook of
        Nothing => False
        Just delegation => delegation.delegatee /= 0
   in (if hasActiveOutbound then 0 else rawVotingPower) + incoming

-- =============================================================================
-- ABI selector surface
-- =============================================================================

public export
delegateSelector : Integer
delegateSelector = 0x5c19a95c

public export
revokeSelector : Integer
revokeSelector = 0xa4d31805

public export
delegationOfSelector : Integer
delegationOfSelector = 0xf837123e

public export
shareholderVotingPowerSelector : Integer
shareholderVotingPowerSelector = 0xe9c55a22

public export
delegatedVotingPowerSelector : Integer
delegatedVotingPowerSelector = 0xf9a5c639

public export
effectiveVotingPowerSelector : Integer
effectiveVotingPowerSelector = 0xb652a5c0

public export
erc7546GetImplementationSelector : Integer
erc7546GetImplementationSelector = 0xdc9cc645

export
supportsDelegationSelector : Integer -> Bool
supportsDelegationSelector selector =
  selector == delegateSelector ||
  selector == revokeSelector ||
  selector == delegationOfSelector ||
  selector == shareholderVotingPowerSelector ||
  selector == delegatedVotingPowerSelector ||
  selector == effectiveVotingPowerSelector ||
  selector == erc7546GetImplementationSelector ||
  selector == SEL_GET_IMPL

-- =============================================================================
-- Proxy-compatible storage slots
-- =============================================================================

||| Clone storage slots. The implementation is storage-free in the sense that
||| all state is expected to live in proxy/clone storage, not in the
||| implementation contract itself.
SLOT_SHAREHOLDER_POWER_BASE : Integer
SLOT_SHAREHOLDER_POWER_BASE = 0x560100

SLOT_DELEGATION_BASE : Integer
SLOT_DELEGATION_BASE = 0x560101

SLOT_DELEGATED_POWER_BASE : Integer
SLOT_DELEGATED_POWER_BASE = 0x560102

shareholderVotingPowerSlot : Integer -> IO Integer
shareholderVotingPowerSlot shareholder = mappingSlot SLOT_SHAREHOLDER_POWER_BASE shareholder

delegationSlot : Integer -> IO Integer
delegationSlot delegator = mappingSlot SLOT_DELEGATION_BASE delegator

delegatedVotingPowerSlot : Integer -> IO Integer
delegatedVotingPowerSlot delegatee = mappingSlot SLOT_DELEGATED_POWER_BASE delegatee

export
delegationOfStorage : Integer -> IO Integer
delegationOfStorage delegator = do
  slot <- delegationSlot delegator
  readAddress slot

export
shareholderVotingPowerStorage : Integer -> IO Integer
shareholderVotingPowerStorage shareholder = do
  slot <- shareholderVotingPowerSlot shareholder
  readUint slot

export
delegatedVotingPowerStorage : Integer -> IO Integer
delegatedVotingPowerStorage delegatee = do
  slot <- delegatedVotingPowerSlot delegatee
  readUint slot

updateDelegatedVotingPowerStorage : Integer -> Integer -> IO ()
updateDelegatedVotingPowerStorage delegatee nextValue = do
  slot <- delegatedVotingPowerSlot delegatee
  writeUint slot nextValue

writeDelegationStorage : Integer -> Integer -> IO ()
writeDelegationStorage delegator delegatee = do
  slot <- delegationSlot delegator
  writeAddress slot delegatee

export
setDelegationStorage : Integer -> Integer -> IO ()
setDelegationStorage delegator delegatee = do
  previousDelegatee <- delegationOfStorage delegator
  rawVotingPower <- shareholderVotingPowerStorage delegator

  if previousDelegatee /= 0
    then do
      previousDelegated <- delegatedVotingPowerStorage previousDelegatee
      updateDelegatedVotingPowerStorage previousDelegatee (clampSub previousDelegated rawVotingPower)
    else pure ()

  writeDelegationStorage delegator delegatee

  if delegatee /= 0
    then do
      nextDelegated <- delegatedVotingPowerStorage delegatee
      updateDelegatedVotingPowerStorage delegatee (nextDelegated + rawVotingPower)
    else pure ()

export
clearDelegationStorage : Integer -> IO ()
clearDelegationStorage delegator = setDelegationStorage delegator 0

export
effectiveVotingPowerStorage : Integer -> IO Integer
effectiveVotingPowerStorage shareholder = do
  outboundDelegatee <- delegationOfStorage shareholder
  rawVotingPower <- shareholderVotingPowerStorage shareholder
  inboundVotingPower <- delegatedVotingPowerStorage shareholder
  let activeOwnVotingPower = if outboundDelegatee == 0 then rawVotingPower else 0
  pure (activeOwnVotingPower + inboundVotingPower)

-- =============================================================================
-- On-chain entry points
-- =============================================================================

export
delegate : Integer -> IO ()
delegate delegatee = do
  delegator <- caller
  if delegatee == 0
    then evmRevert 0 0
    else if delegatee == delegator
      then evmRevert 0 0
      else setDelegationStorage delegator delegatee

export
revoke : IO ()
revoke = do
  delegator <- caller
  clearDelegationStorage delegator

export
getImplementation : Integer -> IO Integer
getImplementation selector =
  if supportsDelegationSelector selector
    then address
    else pure 0

||| Main selector router. The ABI reads and writes are kept explicit here so the
||| generated Yul keeps a simple selector dispatch structure.
export
voteDelegationMain : IO ()
voteDelegationMain = do
  selector <- getSelector

  if selector == SEL_GET_IMPL || selector == erc7546GetImplementationSelector
    then do
      requestedSelector <- calldataload 4
      impl <- getImplementation requestedSelector
      returnUint impl

    else if selector == delegateSelector
      then do
        delegatee <- calldataload 4
        delegate delegatee
        evmReturn 0 0

      else if selector == revokeSelector
        then do
          revoke
          evmReturn 0 0

        else if selector == delegationOfSelector
          then do
            delegator <- calldataload 4
            delegatee <- delegationOfStorage delegator
            returnUint delegatee

          else if selector == shareholderVotingPowerSelector
            then do
              shareholder <- calldataload 4
              votingPower <- shareholderVotingPowerStorage shareholder
              returnUint votingPower

            else if selector == delegatedVotingPowerSelector
              then do
                delegatee <- calldataload 4
                votingPower <- delegatedVotingPowerStorage delegatee
                returnUint votingPower

              else if selector == effectiveVotingPowerSelector
                then do
                  shareholder <- calldataload 4
                  votingPower <- effectiveVotingPowerStorage shareholder
                  returnUint votingPower

                else evmRevert 0 0

main : IO ()
main = voteDelegationMain

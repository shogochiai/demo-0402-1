||| Governance timeline read-only implementation.
|||
||| This module mirrors the selector-routing style used by idris2-subcontract
||| ERC7546 dictionary examples, but keeps the actual timeline logic storage-free
||| so it remains safe behind an ERC-7546 delegatecall proxy.
module Governance.Timeline

import EVM.Primitives
import Subcontract.Standards.ERC7546.Slots

%default covering

-- =============================================================================
-- Selector Surface
-- =============================================================================

||| timeline(uint256,uint256,uint256,uint256,uint256)
export
TIMELINE_SELECTOR : Integer
TIMELINE_SELECTOR = 0x3cdd5ebe

||| getImplementation(bytes4) via ERC-7546
export
TIMELINE_GET_IMPLEMENTATION_SELECTOR : Integer
TIMELINE_GET_IMPLEMENTATION_SELECTOR = 0xdc9cc645

-- =============================================================================
-- Timeline Encoding Constants
-- =============================================================================

export
TIMELINE_WORDS : Integer
TIMELINE_WORDS = 10

export
TIMELINE_RETURN_BYTES : Integer
TIMELINE_RETURN_BYTES = TIMELINE_WORDS * 32

export
TIMELINE_EVENT_PROPOSE : Integer
TIMELINE_EVENT_PROPOSE = 1

export
TIMELINE_EVENT_VOTE : Integer
TIMELINE_EVENT_VOTE = 2

export
TIMELINE_EVENT_TALLY : Integer
TIMELINE_EVENT_TALLY = 3

export
TIMELINE_EVENT_EXECUTE : Integer
TIMELINE_EVENT_EXECUTE = 4

-- =============================================================================
-- Calldata Extraction
-- =============================================================================

||| proposalId lives in the first ABI word after the selector.
export
readProposalId : IO Integer
readProposalId = calldataload 4

export
readProposeTimestamp : IO Integer
readProposeTimestamp = calldataload 36

export
readVoteTimestamp : IO Integer
readVoteTimestamp = calldataload 68

export
readTallyTimestamp : IO Integer
readTallyTimestamp = calldataload 100

export
readExecuteTimestamp : IO Integer
readExecuteTimestamp = calldataload 132

-- =============================================================================
-- ERC7546 Read-Only Mapping
-- =============================================================================

||| Read-only self-description for ERC7546 selector routing.
||| Unknown selectors deliberately resolve to zero.
export
getImplementation : Integer -> IO Integer
getImplementation requestedSelector =
  if requestedSelector == TIMELINE_SELECTOR
    then address
    else if requestedSelector == SEL_GET_IMPL
      then address
      else pure 0

-- =============================================================================
-- ABI Encoding
-- =============================================================================

export
encodeTimelineWord : Integer -> Integer -> IO ()
encodeTimelineWord offset word = mstore offset word

||| ABI encode:
||| (proposalId, eventCount, propose.event, propose.timestamp, vote.event,
||| vote.timestamp, tally.event, tally.timestamp, execute.event, execute.timestamp)
export
encodeTimeline :
  Integer -> Integer -> Integer -> Integer -> Integer -> IO ()
encodeTimeline proposalId proposeTimestamp voteTimestamp tallyTimestamp executeTimestamp = do
  encodeTimelineWord 0 proposalId
  encodeTimelineWord 32 4
  encodeTimelineWord 64 TIMELINE_EVENT_PROPOSE
  encodeTimelineWord 96 proposeTimestamp
  encodeTimelineWord 128 TIMELINE_EVENT_VOTE
  encodeTimelineWord 160 voteTimestamp
  encodeTimelineWord 192 TIMELINE_EVENT_TALLY
  encodeTimelineWord 224 tallyTimestamp
  encodeTimelineWord 256 TIMELINE_EVENT_EXECUTE
  encodeTimelineWord 288 executeTimestamp
  evmReturn 0 TIMELINE_RETURN_BYTES

-- =============================================================================
-- Read-Only Timeline API
-- =============================================================================

export
timeline :
  Integer -> Integer -> Integer -> Integer -> Integer -> IO ()
timeline proposalId proposeTimestamp voteTimestamp tallyTimestamp executeTimestamp =
  encodeTimeline proposalId proposeTimestamp voteTimestamp tallyTimestamp executeTimestamp

export
handleTimeline : IO ()
handleTimeline = do
  proposalId <- readProposalId
  proposeTimestamp <- readProposeTimestamp
  voteTimestamp <- readVoteTimestamp
  tallyTimestamp <- readTallyTimestamp
  executeTimestamp <- readExecuteTimestamp
  timeline proposalId proposeTimestamp voteTimestamp tallyTimestamp executeTimestamp

export
handleGetImplementation : IO ()
handleGetImplementation = do
  requestedSelector <- calldataload 4
  impl <- getImplementation requestedSelector
  returnUint impl

export
ensureTimelineCalldata : IO Bool
ensureTimelineCalldata = do
  size <- calldatasize
  pure (size >= 164)

-- =============================================================================
-- Entry Point
-- =============================================================================

export
main : IO ()
main = do
  selector <- getSelector
  if selector == SEL_GET_IMPL
    then handleGetImplementation
    else if selector == TIMELINE_SELECTOR
      then do
        valid <- ensureTimelineCalldata
        if valid
          then handleTimeline
          else evmRevert 0 0
      else evmRevert 0 0

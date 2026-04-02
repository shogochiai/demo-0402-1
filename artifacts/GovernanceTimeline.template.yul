object "GovernanceTimeline" {
  code {
    datacopy(0, dataoffset("Runtime"), datasize("Runtime"))
    return(0, datasize("Runtime"))
  }

  object "Runtime" {
    code {
      function timelineStatus(ts) -> statusWord {
        switch ts
        case 0 { statusWord := 0 }
        default { statusWord := 1 }
      }

      function proposalMetaSlot(proposalId) -> metaSlot {
        mstore(0x00, proposalId)
        mstore(0x20, 0x1000)
        metaSlot := add(keccak256(0x00, 0x40), 0x30)
      }

      function encodeTimeline(proposalId) {
        let metaSlot := proposalMetaSlot(proposalId)
        let proposeAt := sload(metaSlot)
        let voteAt := sload(add(metaSlot, 0x07))
        let tallyAt := sload(add(metaSlot, 0x08))
        let executeAt := sload(add(metaSlot, 0x09))

        mstore(0x000, proposalId)
        mstore(0x020, 0x01)
        mstore(0x040, 0x02)
        mstore(0x060, 0x03)
        mstore(0x080, 0x04)
        mstore(0x0a0, proposeAt)
        mstore(0x0c0, voteAt)
        mstore(0x0e0, tallyAt)
        mstore(0x100, executeAt)
        mstore(0x120, timelineStatus(proposeAt))
        mstore(0x140, timelineStatus(voteAt))
        mstore(0x160, timelineStatus(tallyAt))
        mstore(0x180, timelineStatus(executeAt))
        return(0x000, 0x1a0)
      }

      function getImplementationFor(requestedSelector) -> impl {
        switch requestedSelector
        case 0x1c28430c { impl := address() }
        case 0xdc9cc645 { impl := address() }
        default { impl := 0 }
      }

      let selector := shr(224, calldataload(0))

      switch selector
      case 0x1c28430c {
        if lt(calldatasize(), 0x24) { revert(0, 0) }
        encodeTimeline(calldataload(0x04))
      }
      case 0xdc9cc645 {
        if lt(calldatasize(), 0x24) { revert(0, 0) }
        mstore(0x00, getImplementationFor(shr(224, calldataload(0x04))))
        return(0x00, 0x20)
      }
      default {
        revert(0, 0)
      }
    }
  }
}

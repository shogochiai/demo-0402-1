object "Contract" {
  code {
    datacopy(0, dataoffset("runtime"), datasize("runtime"))
    return(0, datasize("runtime"))
  }
  object "runtime" {
    code {
      mstore(64, 128)
      pop(Governance_Timeline_u_main(0))
      // @source: NONE
      function mk_closure(func_id, arity, arg0, arg1, arg2, arg3) -> ptr {
        ptr := mload(64)
        mstore(64, add(ptr, 192))
        mstore(ptr, func_id)
        mstore(add(ptr, 32), arity)
        mstore(add(ptr, 64), arg0)
        mstore(add(ptr, 96), arg1)
        mstore(add(ptr, 128), arg2)
        mstore(add(ptr, 160), arg3)
      }
      // @source: NONE
      function apply_closure(closure, arg) -> result {
        let func_id := mload(closure)
        switch func_id
        case 1 {
  if eq(mload(add(closure, 32)), 1) {
  result := Governance_Timeline_m_getImplementation_0(mload(add(closure, 64)), mload(add(closure, 96)))
  leave
}
  result := mk_closure(mload(closure), sub(mload(add(closure, 32)), 1), mload(add(closure, 64)), mload(add(closure, 96)), mload(add(closure, 128)), arg)
}
        case 2 {
  if eq(mload(add(closure, 32)), 1) {
  result := PrimIO_m_unsafePerformIO_0(mload(add(closure, 64)), mload(add(closure, 96)))
  leave
}
  result := mk_closure(mload(closure), sub(mload(add(closure, 32)), 1), mload(add(closure, 64)), mload(add(closure, 96)), mload(add(closure, 128)), arg)
}
        case 3 {
  if eq(mload(add(closure, 32)), 1) {
  result := m____mainExpression_0__0(mload(add(closure, 64)))
  leave
}
  result := mk_closure(mload(closure), sub(mload(add(closure, 32)), 1), mload(add(closure, 64)), mload(add(closure, 96)), mload(add(closure, 128)), arg)
}
        default {
  result := 0
}
      }
      // @source: <generated>:0:0--0:0
      function m____mainExpression_0__0(v0) -> result {
        result := Governance_Timeline_u_main(v0)
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_timeline(v0, v1, v2, v3, v4, v5) -> result {
        result := Governance_Timeline_u_encodeTimeline(v0, v1, v2, v3, v4, v5)
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_readVoteTimestamp(v0) -> result {
        let v1 := 0
        v1 := 68
        result := EVM_Primitives_u_calldataload(v1, v0)
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_readTallyTimestamp(v0) -> result {
        let v1 := 0
        v1 := 100
        result := EVM_Primitives_u_calldataload(v1, v0)
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_readProposeTimestamp(v0) -> result {
        let v1 := 0
        v1 := 36
        result := EVM_Primitives_u_calldataload(v1, v0)
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_readProposalId(v0) -> result {
        let v1 := 0
        v1 := 4
        result := EVM_Primitives_u_calldataload(v1, v0)
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_readExecuteTimestamp(v0) -> result {
        let v1 := 0
        v1 := 132
        result := EVM_Primitives_u_calldataload(v1, v0)
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_main(v0) -> result {
        let v1 := 0
        let v2 := 0
        let v3 := 0
        let v4 := 0
        let v5 := 0
        let v6 := 0
        let v7 := 0
        let v8 := 0
        let v9 := 0
        let v10 := 0
        v1 := EVM_Primitives_u_getSelector(v0)
        v2 := 3701261893
        v10 := Prelude_EqOrd_u____Eq_Integer(v1, v2)
        switch v10
        case 1 {
  result := Governance_Timeline_u_handleGetImplementation(v0)
}
        case 0 {
  v3 := Governance_Timeline_u_TIMELINE_SELECTOR()
  v9 := Prelude_EqOrd_u____Eq_Integer(v1, v3)
  switch v9
  case 1 {
  v4 := Governance_Timeline_u_ensureTimelineCalldata(v0)
  switch v4
  case 1 {
  result := Governance_Timeline_u_handleTimeline(v0)
}
  case 0 {
  v5 := 0
  v6 := 0
  result := EVM_Primitives_u_evmRevert(v5, v6, v0)
}

}
  case 0 {
  v7 := 0
  v8 := 0
  result := EVM_Primitives_u_evmRevert(v7, v8, v0)
}

}

      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_handleTimeline(v0) -> result {
        let v1 := 0
        let v2 := 0
        let v3 := 0
        let v4 := 0
        let v5 := 0
        v1 := Governance_Timeline_u_readProposalId(v0)
        v2 := Governance_Timeline_u_readProposeTimestamp(v0)
        v3 := Governance_Timeline_u_readVoteTimestamp(v0)
        v4 := Governance_Timeline_u_readTallyTimestamp(v0)
        v5 := Governance_Timeline_u_readExecuteTimestamp(v0)
        result := Governance_Timeline_u_timeline(v1, v2, v3, v4, v5, v0)
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_handleGetImplementation(v0) -> result {
        let v1 := 0
        let v2 := 0
        let v3 := 0
        let v4 := 0
        /* Governance.Timeline:144:23--144:35 */
        v2 := 4
        v1 := EVM_Primitives_u_calldataload(v2, v0)
        /* Governance.Timeline:145:10--145:27 */
        v4 := Governance_Timeline_u_getImplementation(v1)
        v3 := apply_closure(v4, v0)
        result := EVM_Primitives_u_returnUint(v3, v0)
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_getImplementation(v0) -> result {
        result := mk_closure(1, 1, v0, 0, 0, 0)
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_m_getImplementation_0(v0, v1) -> result {
        let v2 := 0
        let v3 := 0
        let v4 := 0
        let v5 := 0
        v2 := Governance_Timeline_u_TIMELINE_SELECTOR()
        v5 := Prelude_EqOrd_u____Eq_Integer(v0, v2)
        switch v5
        case 1 {
  result := EVM_Primitives_u_address(v1)
}
        case 0 {
  v3 := 3701261893
  v4 := Prelude_EqOrd_u____Eq_Integer(v0, v3)
  switch v4
  case 1 {
  result := EVM_Primitives_u_address(v1)
}
  case 0 {
  result := 0
}

}

      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_ensureTimelineCalldata(v0) -> result {
        let v1 := 0
        let v2 := 0
        v1 := EVM_Primitives_u_calldatasize(v0)
        v2 := 164
        result := Prelude_EqOrd_u____Ord_Integer(v1, v2)
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_encodeTimelineWord(v0, v1, v2) -> result {
        result := EVM_Primitives_u_mstore(v0, v1, v2)
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_encodeTimeline(v0, v1, v2, v3, v4, v5) -> result {
        let v6 := 0
        let v7 := 0
        let v8 := 0
        let v9 := 0
        let v10 := 0
        let v11 := 0
        let v12 := 0
        let v13 := 0
        let v14 := 0
        let v15 := 0
        let v16 := 0
        let v17 := 0
        let v18 := 0
        let v19 := 0
        let v20 := 0
        let v21 := 0
        let v22 := 0
        let v23 := 0
        let v24 := 0
        let v25 := 0
        let v26 := 0
        let v27 := 0
        let v28 := 0
        let v29 := 0
        let v30 := 0
        let v31 := 0
        let v32 := 0
        /* Governance.Timeline:109:2--109:20 */
        v7 := 0
        v6 := Governance_Timeline_u_encodeTimelineWord(v7, v0, v5)
        /* Governance.Timeline:110:2--110:20 */
        v9 := 32
        /* Governance.Timeline:110:2--110:20 */
        v10 := 4
        v8 := Governance_Timeline_u_encodeTimelineWord(v9, v10, v5)
        /* Governance.Timeline:111:2--111:20 */
        v12 := 64
        /* Governance.Timeline:111:2--111:20 */
        v13 := Governance_Timeline_u_TIMELINE_EVENT_PROPOSE()
        v11 := Governance_Timeline_u_encodeTimelineWord(v12, v13, v5)
        /* Governance.Timeline:112:2--112:20 */
        v15 := 96
        v14 := Governance_Timeline_u_encodeTimelineWord(v15, v1, v5)
        /* Governance.Timeline:113:2--113:20 */
        v17 := 128
        /* Governance.Timeline:113:2--113:20 */
        v18 := Governance_Timeline_u_TIMELINE_EVENT_VOTE()
        v16 := Governance_Timeline_u_encodeTimelineWord(v17, v18, v5)
        /* Governance.Timeline:114:2--114:20 */
        v20 := 160
        v19 := Governance_Timeline_u_encodeTimelineWord(v20, v2, v5)
        /* Governance.Timeline:115:2--115:20 */
        v22 := 192
        /* Governance.Timeline:115:2--115:20 */
        v23 := Governance_Timeline_u_TIMELINE_EVENT_TALLY()
        v21 := Governance_Timeline_u_encodeTimelineWord(v22, v23, v5)
        /* Governance.Timeline:116:2--116:20 */
        v25 := 224
        v24 := Governance_Timeline_u_encodeTimelineWord(v25, v3, v5)
        /* Governance.Timeline:117:2--117:20 */
        v27 := 256
        /* Governance.Timeline:117:2--117:20 */
        v28 := Governance_Timeline_u_TIMELINE_EVENT_EXECUTE()
        v26 := Governance_Timeline_u_encodeTimelineWord(v27, v28, v5)
        /* Governance.Timeline:118:2--118:20 */
        v30 := 288
        v29 := Governance_Timeline_u_encodeTimelineWord(v30, v4, v5)
        v31 := 0
        v32 := Governance_Timeline_u_TIMELINE_RETURN_BYTES()
        result := EVM_Primitives_u_evmReturn(v31, v32, v5)
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_TIMELINE_WORDS() -> result {
        result := 10
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_TIMELINE_SELECTOR() -> result {
        result := 1021140670
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_TIMELINE_RETURN_BYTES() -> result {
        let v0 := 0
        let v1 := 0
        v0 := Governance_Timeline_u_TIMELINE_WORDS()
        v1 := 32
        result := mul(v0, v1)
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_TIMELINE_EVENT_VOTE() -> result {
        result := 2
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_TIMELINE_EVENT_TALLY() -> result {
        result := 3
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_TIMELINE_EVENT_PROPOSE() -> result {
        result := 1
      }
      // @source: Governance.Timeline:0:0--0:0
      function Governance_Timeline_u_TIMELINE_EVENT_EXECUTE() -> result {
        result := 4
      }
      // @source: Prelude.Num:0:0--0:0
      function Prelude_Num_u_div_Integral_Integer(v0, v1) -> result {
        let v2 := 0
        let v3 := 0
        let v4 := 0
        v2 := 0
        v4 := Prelude_EqOrd_u____Eq_Integer(v1, v2)
        switch v4
        case 0 {
  result := div(v0, v1)
}
        default {
  v3 := 0
  revert(0, 0)
  result := 0
}
      }
      // @source: Prelude.EqOrd:0:0--0:0
      function Prelude_EqOrd_u____Ord_Integer(v0, v1) -> result {
        let v2 := 0
        v2 := iszero(lt(v0, v1))
        switch v2
        case 0 {
  result := 0
}
        default {
  result := 1
}
      }
      // @source: Prelude.EqOrd:0:0--0:0
      function Prelude_EqOrd_u____Eq_Integer(v0, v1) -> result {
        let v2 := 0
        v2 := eq(v0, v1)
        switch v2
        case 0 {
  result := 0
}
        default {
  result := 1
}
      }
      // @source: PrimIO:0:0--0:0
      function PrimIO_m_unsafePerformIO_0(v0, v1) -> result {
        result := apply_closure(v0, v1)
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_returnUint(v0, v1) -> result {
        let v2 := 0
        let v3 := 0
        let v4 := 0
        let v5 := 0
        /* EVM.Primitives:54:2--54:8 */
        v3 := 0
        v2 := EVM_Primitives_u_mstore(v3, v0, v1)
        v4 := 0
        v5 := 32
        result := EVM_Primitives_u_evmReturn(v4, v5, v1)
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_prim__revert(arg0, arg1, arg2) -> result {
        revert(arg0, arg1)
        result := 0
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_prim__return(arg0, arg1, arg2) -> result {
        return(arg0, arg1)
        result := 0
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_prim__mstore(arg0, arg1, arg2) -> result {
        mstore(arg0, arg1)
        result := 0
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_prim__calldatasize(arg0) -> result {
        result := calldatasize()
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_prim__calldataload(arg0, arg1) -> result {
        result := calldataload(arg0)
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_prim__address(arg0) -> result {
        result := address()
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_mstore(v0, v1, v2) -> result {
        result := EVM_Primitives_u_prim__mstore(v0, v1, v2)
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_getSelector(v0) -> result {
        let v1 := 0
        let v2 := 0
        let v3 := 0
        /* EVM.Primitives:48:11--48:23 */
        v2 := 0
        v1 := EVM_Primitives_u_calldataload(v2, v0)
        v3 := 26959946667150639794667015087019630673637144422540572481103610249216
        result := Prelude_Num_u_div_Integral_Integer(v1, v3)
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_evmRevert(v0, v1, v2) -> result {
        result := EVM_Primitives_u_prim__revert(v0, v1, v2)
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_evmReturn(v0, v1, v2) -> result {
        result := EVM_Primitives_u_prim__return(v0, v1, v2)
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_calldatasize(v0) -> result {
        result := EVM_Primitives_u_prim__calldatasize(v0)
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_calldataload(v0, v1) -> result {
        result := EVM_Primitives_u_prim__calldataload(v0, v1)
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_address(v0) -> result {
        result := EVM_Primitives_u_prim__address(v0)
      }
    }
  }
}
object "Contract" {
  code {
    datacopy(0, dataoffset("runtime"), datasize("runtime"))
    return(0, datasize("runtime"))
  }
  object "runtime" {
    code {
      mstore(64, 128)
      pop(Governance_VoteDelegation_u_main(0))
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
  result := Governance_VoteDelegation_m_setDelegationStorage_0(mload(add(closure, 64)), mload(add(closure, 96)), mload(add(closure, 128)), mload(add(closure, 160)))
  leave
}
  result := mk_closure(mload(closure), sub(mload(add(closure, 32)), 1), mload(add(closure, 64)), mload(add(closure, 96)), mload(add(closure, 128)), arg)
}
        case 2 {
  if eq(mload(add(closure, 32)), 1) {
  result := Governance_VoteDelegation_m_setDelegationStorage_1(mload(add(closure, 64)), mload(add(closure, 96)))
  leave
}
  result := mk_closure(mload(closure), sub(mload(add(closure, 32)), 1), mload(add(closure, 64)), mload(add(closure, 96)), mload(add(closure, 128)), arg)
}
        case 3 {
  if eq(mload(add(closure, 32)), 1) {
  result := PrimIO_m_unsafePerformIO_0(mload(add(closure, 64)), mload(add(closure, 96)))
  leave
}
  result := mk_closure(mload(closure), sub(mload(add(closure, 32)), 1), mload(add(closure, 64)), mload(add(closure, 96)), mload(add(closure, 128)), arg)
}
        case 4 {
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
        result := Governance_VoteDelegation_u_main(v0)
      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_writeDelegationStorage(v0, v1, v2) -> result {
        let v3 := 0
        v3 := Governance_VoteDelegation_u_delegationSlot(v0, v2)
        result := EVM_Storage_Namespace_u_writeAddress(v3, v1, v2)
      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_voteDelegationMain(v0) -> result {
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
        let v33 := 0
        let v34 := 0
        let v35 := 0
        let v36 := 0
        let v37 := 0
        let v38 := 0
        let v39 := 0
        let v40 := 0
        let v41 := 0
        let v42 := 0
        v1 := EVM_Primitives_u_getSelector(v0)
        v2 := 3701261893
        /* Prelude.Basics:183:12--183:16 */
        v4 := Prelude_EqOrd_u____Eq_Integer(v1, v2)
        /* Prelude.Basics:183:12--183:16 */
        let case_result_0 := 0
        switch v4
        case 1 {
  case_result_0 := 1
}
        case 0 {
  v3 := 3701261893
  case_result_0 := Prelude_EqOrd_u____Eq_Integer(v1, v3)
}

        v42 := case_result_0
        switch v42
        case 1 {
  /* Governance.VoteDelegation:289:27--289:39 */
  v6 := 4
  v5 := EVM_Primitives_u_calldataload(v6, v0)
  v7 := Governance_VoteDelegation_u_getImplementation(v5, v0)
  result := EVM_Primitives_u_returnUint(v7, v0)
}
        case 0 {
  v8 := 1545185628
  v41 := Prelude_EqOrd_u____Eq_Integer(v1, v8)
  switch v41
  case 1 {
  /* Governance.VoteDelegation:295:21--295:33 */
  v10 := 4
  v9 := EVM_Primitives_u_calldataload(v10, v0)
  v11 := Governance_VoteDelegation_u_delegate(v9, v0)
  v12 := 0
  v13 := 0
  result := EVM_Primitives_u_evmReturn(v12, v13, v0)
}
  case 0 {
  v14 := 2765297669
  v40 := Prelude_EqOrd_u____Eq_Integer(v1, v14)
  switch v40
  case 1 {
  v15 := Governance_VoteDelegation_u_revoke(v0)
  v16 := 0
  v17 := 0
  result := EVM_Primitives_u_evmReturn(v16, v17, v0)
}
  case 0 {
  v18 := 4164358718
  v39 := Prelude_EqOrd_u____Eq_Integer(v1, v18)
  switch v39
  case 1 {
  /* Governance.VoteDelegation:306:25--306:37 */
  v20 := 4
  v19 := EVM_Primitives_u_calldataload(v20, v0)
  v21 := Governance_VoteDelegation_u_delegationOfStorage(v19, v0)
  result := EVM_Primitives_u_returnUint(v21, v0)
}
  case 0 {
  v22 := 3922024994
  v38 := Prelude_EqOrd_u____Eq_Integer(v1, v22)
  switch v38
  case 1 {
  /* Governance.VoteDelegation:312:29--312:41 */
  v24 := 4
  v23 := EVM_Primitives_u_calldataload(v24, v0)
  v25 := Governance_VoteDelegation_u_shareholderVotingPowerStorage(v23, v0)
  result := EVM_Primitives_u_returnUint(v25, v0)
}
  case 0 {
  v26 := 4188390969
  v37 := Prelude_EqOrd_u____Eq_Integer(v1, v26)
  switch v37
  case 1 {
  /* Governance.VoteDelegation:318:29--318:41 */
  v28 := 4
  v27 := EVM_Primitives_u_calldataload(v28, v0)
  v29 := Governance_VoteDelegation_u_delegatedVotingPowerStorage(v27, v0)
  result := EVM_Primitives_u_returnUint(v29, v0)
}
  case 0 {
  v30 := 3058869696
  v36 := Prelude_EqOrd_u____Eq_Integer(v1, v30)
  switch v36
  case 1 {
  /* Governance.VoteDelegation:324:33--324:45 */
  v32 := 4
  v31 := EVM_Primitives_u_calldataload(v32, v0)
  v33 := Governance_VoteDelegation_u_effectiveVotingPowerStorage(v31, v0)
  result := EVM_Primitives_u_returnUint(v33, v0)
}
  case 0 {
  v34 := 0
  v35 := 0
  result := EVM_Primitives_u_evmRevert(v34, v35, v0)
}

}

}

}

}

}

}

      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_updateDelegatedVotingPowerStorage(v0, v1, v2) -> result {
        let v3 := 0
        v3 := Governance_VoteDelegation_u_delegatedVotingPowerSlot(v0, v2)
        result := EVM_Storage_Namespace_u_writeUint(v3, v1, v2)
      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_supportsDelegationSelector(v0) -> result {
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
        let v11 := 0
        let v12 := 0
        let v13 := 0
        let v14 := 0
        let v15 := 0
        v1 := 1545185628
        v15 := Prelude_EqOrd_u____Eq_Integer(v0, v1)
        switch v15
        case 1 {
  result := 1
}
        case 0 {
  v2 := 2765297669
  v14 := Prelude_EqOrd_u____Eq_Integer(v0, v2)
  switch v14
  case 1 {
  result := 1
}
  case 0 {
  v3 := 4164358718
  v13 := Prelude_EqOrd_u____Eq_Integer(v0, v3)
  switch v13
  case 1 {
  result := 1
}
  case 0 {
  v4 := 3922024994
  v12 := Prelude_EqOrd_u____Eq_Integer(v0, v4)
  switch v12
  case 1 {
  result := 1
}
  case 0 {
  v5 := 4188390969
  v11 := Prelude_EqOrd_u____Eq_Integer(v0, v5)
  switch v11
  case 1 {
  result := 1
}
  case 0 {
  v6 := 3058869696
  v10 := Prelude_EqOrd_u____Eq_Integer(v0, v6)
  switch v10
  case 1 {
  result := 1
}
  case 0 {
  v7 := 3701261893
  v9 := Prelude_EqOrd_u____Eq_Integer(v0, v7)
  switch v9
  case 1 {
  result := 1
}
  case 0 {
  v8 := 3701261893
  result := Prelude_EqOrd_u____Eq_Integer(v0, v8)
}

}

}

}

}

}

}

      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_shareholderVotingPowerStorage(v0, v1) -> result {
        let v2 := 0
        v2 := Governance_VoteDelegation_u_shareholderVotingPowerSlot(v0, v1)
        result := EVM_Storage_Namespace_u_readUint(v2, v1)
      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_shareholderVotingPowerSlot(v0, v1) -> result {
        let v2 := 0
        v2 := Governance_VoteDelegation_u_SLOT_SHAREHOLDER_POWER_BASE()
        result := EVM_Storage_Namespace_u_mappingSlot(v2, v0, v1)
      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_setDelegationStorage(v0, v1, v2) -> result {
        let v3 := 0
        let v4 := 0
        let v5 := 0
        let v6 := 0
        let v7 := 0
        let v8 := 0
        let v9 := 0
        let v10 := 0
        let v11 := 0
        let v12 := 0
        let v13 := 0
        let v14 := 0
        v3 := Governance_VoteDelegation_u_delegationOfStorage(v0, v2)
        v4 := Governance_VoteDelegation_u_shareholderVotingPowerStorage(v0, v2)
        v6 := 0
        v9 := Prelude_EqOrd_u____Eq_Integer(v3, v6)
        let case_result_0 := 0
        switch v9
        case 1 {
  /* Prelude.IO:30:12--30:19 */
  v7 := Governance_VoteDelegation_u_delegatedVotingPowerStorage(v3, v2)
  /* Governance.VoteDelegation:229:6--229:39 */
  v8 := Governance_VoteDelegation_u_clampSub(v7, v4)
  case_result_0 := Governance_VoteDelegation_u_updateDelegatedVotingPowerStorage(v3, v8, v2)
}
        case 0 {
  case_result_0 := 0
}

        v5 := case_result_0
        v10 := Governance_VoteDelegation_u_writeDelegationStorage(v0, v1, v2)
        v11 := 0
        v12 := Prelude_EqOrd_u____Eq_Integer(v1, v11)
        let case_result_1 := 0
        switch v12
        case 1 {
  case_result_1 := mk_closure(1, 2, v4, v1, 0, 0)
}
        case 0 {
  case_result_1 := mk_closure(2, 2, 0, 0, 0, 0)
}

        /* Prelude.Interfaces:234:21--234:22 */
        v13 := case_result_1
        v14 := apply_closure(v13, 0)
        result := apply_closure(v14, v2)
      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_m_setDelegationStorage_1(v1, v0) -> result {
        result := 0
      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_m_setDelegationStorage_0(v0, v1, v3, v2) -> result {
        let v4 := 0
        let v5 := 0
        v4 := Governance_VoteDelegation_u_delegatedVotingPowerStorage(v1, v2)
        v5 := add(v4, v0)
        result := Governance_VoteDelegation_u_updateDelegatedVotingPowerStorage(v1, v5, v2)
      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_revoke(v0) -> result {
        let v1 := 0
        v1 := EVM_Primitives_u_caller(v0)
        result := Governance_VoteDelegation_u_clearDelegationStorage(v1, v0)
      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_main(v0) -> result {
        result := Governance_VoteDelegation_u_voteDelegationMain(v0)
      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_getImplementation(v0, v1) -> result {
        let v2 := 0
        v2 := Governance_VoteDelegation_u_supportsDelegationSelector(v0)
        switch v2
        case 1 {
  result := EVM_Primitives_u_address(v1)
}
        case 0 {
  result := 0
}

      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_effectiveVotingPowerStorage(v0, v1) -> result {
        let v2 := 0
        let v3 := 0
        let v4 := 0
        let v5 := 0
        let v6 := 0
        let v7 := 0
        v2 := Governance_VoteDelegation_u_delegationOfStorage(v0, v1)
        v3 := Governance_VoteDelegation_u_shareholderVotingPowerStorage(v0, v1)
        v4 := Governance_VoteDelegation_u_delegatedVotingPowerStorage(v0, v1)
        v6 := 0
        v7 := Prelude_EqOrd_u____Eq_Integer(v2, v6)
        let case_result_0 := 0
        switch v7
        case 1 {
  case_result_0 := v3
}
        case 0 {
  case_result_0 := 0
}

        v5 := case_result_0
        result := add(v5, v4)
      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_delegationSlot(v0, v1) -> result {
        let v2 := 0
        v2 := Governance_VoteDelegation_u_SLOT_DELEGATION_BASE()
        result := EVM_Storage_Namespace_u_mappingSlot(v2, v0, v1)
      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_delegationOfStorage(v0, v1) -> result {
        let v2 := 0
        v2 := Governance_VoteDelegation_u_delegationSlot(v0, v1)
        result := EVM_Storage_Namespace_u_readAddress(v2, v1)
      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_delegatedVotingPowerStorage(v0, v1) -> result {
        let v2 := 0
        v2 := Governance_VoteDelegation_u_delegatedVotingPowerSlot(v0, v1)
        result := EVM_Storage_Namespace_u_readUint(v2, v1)
      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_delegatedVotingPowerSlot(v0, v1) -> result {
        let v2 := 0
        v2 := Governance_VoteDelegation_u_SLOT_DELEGATED_POWER_BASE()
        result := EVM_Storage_Namespace_u_mappingSlot(v2, v0, v1)
      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_delegate(v0, v1) -> result {
        let v2 := 0
        let v3 := 0
        let v4 := 0
        let v5 := 0
        let v6 := 0
        let v7 := 0
        let v8 := 0
        let v9 := 0
        v2 := EVM_Primitives_u_caller(v1)
        v3 := 0
        v9 := Prelude_EqOrd_u____Eq_Integer(v0, v3)
        switch v9
        case 1 {
  v4 := 0
  v5 := 0
  result := EVM_Primitives_u_evmRevert(v4, v5, v1)
}
        case 0 {
  v8 := Prelude_EqOrd_u____Eq_Integer(v0, v2)
  switch v8
  case 1 {
  v6 := 0
  v7 := 0
  result := EVM_Primitives_u_evmRevert(v6, v7, v1)
}
  case 0 {
  result := Governance_VoteDelegation_u_setDelegationStorage(v2, v0, v1)
}

}

      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_clearDelegationStorage(v0, v1) -> result {
        let v2 := 0
        v2 := 0
        result := Governance_VoteDelegation_u_setDelegationStorage(v0, v2, v1)
      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_clampSub(v0, v1) -> result {
        let v2 := 0
        v2 := Prelude_EqOrd_u____Ord_Integer(v0, v1)
        switch v2
        case 1 {
  result := sub(v0, v1)
}
        case 0 {
  result := 0
}

      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_SLOT_SHAREHOLDER_POWER_BASE() -> result {
        result := 5636352
      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_SLOT_DELEGATION_BASE() -> result {
        result := 5636353
      }
      // @source: Governance.VoteDelegation:0:0--0:0
      function Governance_VoteDelegation_u_SLOT_DELEGATED_POWER_BASE() -> result {
        result := 5636354
      }
      // @source: Prelude.Num:0:0--0:0
      function Prelude_Num_u_mod_Integral_Integer(v0, v1) -> result {
        let v2 := 0
        let v3 := 0
        let v4 := 0
        v2 := 0
        v4 := Prelude_EqOrd_u____Eq_Integer(v1, v2)
        switch v4
        case 0 {
  result := mod(v0, v1)
}
        default {
  v3 := 0
  revert(0, 0)
  result := 0
}
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
      // @source: EVM.Storage.Namespace:0:0--0:0
      function EVM_Storage_Namespace_u_writeUint(v0, v1, v2) -> result {
        result := EVM_Primitives_u_sstore(v0, v1, v2)
      }
      // @source: EVM.Storage.Namespace:0:0--0:0
      function EVM_Storage_Namespace_u_writeAddress(v0, v1, v2) -> result {
        result := EVM_Primitives_u_sstore(v0, v1, v2)
      }
      // @source: EVM.Storage.Namespace:0:0--0:0
      function EVM_Storage_Namespace_u_readUint(v0, v1) -> result {
        result := EVM_Primitives_u_sload(v0, v1)
      }
      // @source: EVM.Storage.Namespace:0:0--0:0
      function EVM_Storage_Namespace_u_readAddress(v0, v1) -> result {
        let v2 := 0
        let v3 := 0
        v2 := EVM_Primitives_u_sload(v0, v1)
        v3 := 1461501637330902918203684832716283019655932542976
        result := Prelude_Num_u_mod_Integral_Integer(v2, v3)
      }
      // @source: EVM.Storage.Namespace:0:0--0:0
      function EVM_Storage_Namespace_u_mappingSlot(v0, v1, v2) -> result {
        let v3 := 0
        let v4 := 0
        let v5 := 0
        let v6 := 0
        let v7 := 0
        let v8 := 0
        /* EVM.Storage.Namespace:25:2--25:8 */
        v4 := 0
        v3 := EVM_Primitives_u_mstore(v4, v1, v2)
        /* EVM.Storage.Namespace:26:2--26:8 */
        v6 := 32
        v5 := EVM_Primitives_u_mstore(v6, v0, v2)
        v7 := 0
        v8 := 64
        result := EVM_Primitives_u_keccak256(v7, v8, v2)
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_sstore(v0, v1, v2) -> result {
        result := EVM_Primitives_u_prim__sstore(v0, v1, v2)
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_sload(v0, v1) -> result {
        result := EVM_Primitives_u_prim__sload(v0, v1)
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_returnUint(v0, v1) -> result {
        let v2 := 0
        let v3 := 0
        let v4 := 0
        let v5 := 0
        /* EVM.Primitives:443:2--443:8 */
        v3 := 0
        v2 := EVM_Primitives_u_mstore(v3, v0, v1)
        v4 := 0
        v5 := 32
        result := EVM_Primitives_u_evmReturn(v4, v5, v1)
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_prim__sstore(arg0, arg1, arg2) -> result {
        sstore(arg0, arg1)
        result := 0
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_prim__sload(arg0, arg1) -> result {
        result := sload(arg0)
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
      function EVM_Primitives_u_prim__keccak256(arg0, arg1, arg2) -> result {
        result := keccak256(arg0, arg1)
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_prim__caller(arg0) -> result {
        result := caller()
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
      function EVM_Primitives_u_keccak256(v0, v1, v2) -> result {
        result := EVM_Primitives_u_prim__keccak256(v0, v1, v2)
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_getSelector(v0) -> result {
        let v1 := 0
        let v2 := 0
        let v3 := 0
        /* EVM.Primitives:435:11--435:23 */
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
      function EVM_Primitives_u_caller(v0) -> result {
        result := EVM_Primitives_u_prim__caller(v0)
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
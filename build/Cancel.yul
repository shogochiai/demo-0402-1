object "Contract" {
  code {
    datacopy(0, dataoffset("runtime"), datasize("runtime"))
    return(0, datasize("runtime"))
  }
  object "runtime" {
    code {
      mstore(64, 128)
      pop(TextDAO_Functions_Cancel_Cancel_u_main(0))
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
  result := PrimIO_m_unsafePerformIO_0(mload(add(closure, 64)), mload(add(closure, 96)))
  leave
}
  result := mk_closure(mload(closure), sub(mload(add(closure, 32)), 1), mload(add(closure, 64)), mload(add(closure, 96)), mload(add(closure, 128)), arg)
}
        case 2 {
  if eq(mload(add(closure, 32)), 1) {
  result := TextDAO_Functions_Cancel_Cancel_m_main_0(mload(add(closure, 64)), mload(add(closure, 96)))
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
        result := TextDAO_Functions_Cancel_Cancel_u_main(v0)
      }
      // @source: TextDAO.Functions.Cancel.Cancel:0:0--0:0
      function TextDAO_Functions_Cancel_Cancel_u_requireProposalAuthor(v0, v1, v2) -> result {
        let v3 := 0
        let v4 := 0
        let v5 := 0
        let v6 := 0
        let v7 := 0
        v3 := TextDAO_Storages_Schema_u_getProposalAuthor(v0, v2)
        v7 := Prelude_EqOrd_u____Eq_Integer(v3, v1)
        switch v7
        case 1 {
  result := 0
}
        case 0 {
  v5 := 2
  /* TextDAO.Functions.Cancel.Cancel:90:35--90:46 */
  v4 := 0
  v6 := Subcontract_Core_Evidence_u_tagEvidence(v4)
  result := 1
}

      }
      // @source: TextDAO.Functions.Cancel.Cancel:0:0--0:0
      function TextDAO_Functions_Cancel_Cancel_u_rejectIfVotingEnded(v0, v1) -> result {
        let v2 := 0
        let v3 := 0
        let v4 := 0
        let v5 := 0
        let v6 := 0
        let v7 := 0
        v2 := TextDAO_Storages_Schema_u_getProposalExpiration(v0, v1)
        v3 := EVM_Primitives_u_timestamp(v1)
        v7 := Prelude_EqOrd_u___Ord_Integer(v3, v2)
        switch v7
        case 1 {
  result := 0
}
        case 0 {
  v5 := 18
  /* TextDAO.Functions.Cancel.Cancel:81:39--81:50 */
  v4 := 0
  v6 := Subcontract_Core_Evidence_u_tagEvidence(v4)
  result := 1
}

      }
      // @source: TextDAO.Functions.Cancel.Cancel:0:0--0:0
      function TextDAO_Functions_Cancel_Cancel_u_rejectIfFinalized(v0, v1) -> result {
        let v2 := 0
        let v3 := 0
        let v4 := 0
        let v5 := 0
        let v6 := 0
        v2 := TextDAO_Storages_Schema_u_getProposalStatus(v0, v1)
        v6 := TextDAO_Functions_Cancel_Cancel_u_canCancelStatus(v2)
        switch v6
        case 1 {
  result := 0
}
        case 0 {
  v4 := 18
  /* TextDAO.Functions.Cancel.Cancel:71:39--71:50 */
  v3 := 0
  v5 := Subcontract_Core_Evidence_u_tagEvidence(v3)
  result := 1
}

      }
      // @source: TextDAO.Functions.Cancel.Cancel:0:0--0:0
      function TextDAO_Functions_Cancel_Cancel_u_msg_caller(v0) -> result {
        result := EVM_Primitives_u_caller(v0)
      }
      // @source: TextDAO.Functions.Cancel.Cancel:0:0--0:0
      function TextDAO_Functions_Cancel_Cancel_u_main(v0) -> result {
        let v1 := 0
        let v2 := 0
        let v3 := 0
        let v4 := 0
        let v5 := 0
        let v6 := 0
        let v7 := 0
        let v8 := 0
        /* TextDAO.Functions.Cancel.Cancel:157:10--157:20 */
        v2 := mk_closure(2, 2, 0, 0, 0, 0)
        v1 := Subcontract_Core_ABI_Decoder_u_runDecoder(v2, v0)
        v3 := TextDAO_Functions_Cancel_Cancel_u_cancelIpProposal(v1, v0)
        switch mload(v3)
        case 0 {
  v4 := mload(add(v3, 32))
  result := EVM_Primitives_u_returnUint(v4, v0)
}
        case 1 {
  v5 := mload(add(v3, 32))
  v6 := mload(add(v3, 64))
  v7 := 0
  v8 := 0
  result := EVM_Primitives_u_evmRevert(v7, v8, v0)
}

      }
      // @source: TextDAO.Functions.Cancel.Cancel:0:0--0:0
      function TextDAO_Functions_Cancel_Cancel_m_main_0(v1, v0) -> result {
        result := Subcontract_Core_ABI_Decoder_u_decodeUint256(v1, v0)
      }
      // @source: TextDAO.Functions.Cancel.Cancel:0:0--0:0
      function TextDAO_Functions_Cancel_Cancel_u_emitCancelEvent(v0, v1, v2) -> result {
        let v3 := 0
        let v4 := 0
        let v5 := 0
        let v6 := 0
        let v7 := 0
        let v8 := 0
        let v9 := 0
        /* TextDAO.Functions.Cancel.Cancel:100:2--100:8 */
        v4 := 0
        v3 := EVM_Primitives_u_mstore(v4, v0, v2)
        /* TextDAO.Functions.Cancel.Cancel:101:2--101:8 */
        v6 := 32
        v5 := EVM_Primitives_u_mstore(v6, v1, v2)
        v7 := 0
        v8 := 64
        v9 := TextDAO_Functions_Cancel_Cancel_u_EVENT_IP_PROPOSAL_CANCELLED()
        result := EVM_Primitives_u_log2(v7, v8, v9, v0, v2)
      }
      // @source: TextDAO.Functions.Cancel.Cancel:0:0--0:0
      function TextDAO_Functions_Cancel_Cancel_u_cancelIpProposalBy(v0, v1, v2) -> result {
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
        v3 := TextDAO_Functions_Cancel_Cancel_u_rejectIfFinalized(v1, v2)
        switch mload(v3)
        case 1 {
  v4 := mload(add(v3, 32))
  v5 := mload(add(v3, 64))
  result := 1
}
        case 0 {
  v6 := mload(add(v3, 32))
  v7 := TextDAO_Functions_Cancel_Cancel_u_rejectIfVotingEnded(v1, v2)
  switch mload(v7)
  case 1 {
  v8 := mload(add(v7, 32))
  v9 := mload(add(v7, 64))
  result := 1
}
  case 0 {
  v10 := mload(add(v7, 32))
  v11 := TextDAO_Functions_Cancel_Cancel_u_requireProposalAuthor(v1, v0, v2)
  switch mload(v11)
  case 1 {
  v12 := mload(add(v11, 32))
  v13 := mload(add(v11, 64))
  result := 1
}
  case 0 {
  v14 := mload(add(v11, 32))
  v15 := TextDAO_Functions_Cancel_Cancel_u_applyCancelledState(v1, v0, v2)
  result := 0
}

}

}

      }
      // @source: TextDAO.Functions.Cancel.Cancel:0:0--0:0
      function TextDAO_Functions_Cancel_Cancel_u_cancelIpProposal(v0, v1) -> result {
        let v2 := 0
        v2 := TextDAO_Functions_Cancel_Cancel_u_msg_caller(v1)
        result := TextDAO_Functions_Cancel_Cancel_u_cancelIpProposalBy(v2, v0, v1)
      }
      // @source: TextDAO.Functions.Cancel.Cancel:0:0--0:0
      function TextDAO_Functions_Cancel_Cancel_u_canCancelStatus(v0) -> result {
        switch v0
        case 0 {
  result := 1
}
        default {
  result := 0
}
      }
      // @source: TextDAO.Functions.Cancel.Cancel:0:0--0:0
      function TextDAO_Functions_Cancel_Cancel_u_applyCancelledState(v0, v1, v2) -> result {
        let v3 := 0
        let v4 := 0
        /* TextDAO.Functions.Cancel.Cancel:108:2--108:19 */
        v4 := 3
        v3 := TextDAO_Storages_Schema_u_setProposalStatus(v0, v4, v2)
        result := TextDAO_Functions_Cancel_Cancel_u_emitCancelEvent(v0, v1, v2)
      }
      // @source: TextDAO.Functions.Cancel.Cancel:0:0--0:0
      function TextDAO_Functions_Cancel_Cancel_u_EVENT_IP_PROPOSAL_CANCELLED() -> result {
        result := 91729185591246930020385630452236378298568721102688412897548257157071939711812
      }
      // @source: TextDAO.Storages.Schema:0:0--0:0
      function TextDAO_Storages_Schema_u_setProposalStatus(v0, v1, v2) -> result {
        let v3 := 0
        let v4 := 0
        let v5 := 0
        let v6 := 0
        v3 := TextDAO_Storages_Schema_u_getProposalMetaSlot(v0, v2)
        v4 := TextDAO_Storages_Schema_u_META_OFFSET_STATUS()
        v5 := add(v3, v4)
        v6 := TextDAO_Storages_Schema_u_proposalStatusToInt(v1)
        result := EVM_Primitives_u_sstore(v5, v6, v2)
      }
      // @source: TextDAO.Storages.Schema:0:0--0:0
      function TextDAO_Storages_Schema_u_proposalStatusToInt(v0) -> result {
        switch v0
        case 0 {
  result := 0
}
        case 1 {
  result := 1
}
        case 2 {
  result := 2
}
        case 3 {
  result := 3
}

      }
      // @source: TextDAO.Storages.Schema:0:0--0:0
      function TextDAO_Storages_Schema_u_intToProposalStatus(v0) -> result {
        switch v0
        case 1 {
  result := 1
}
        case 2 {
  result := 2
}
        case 3 {
  result := 3
}
        default {
  result := 0
}
      }
      // @source: TextDAO.Storages.Schema:0:0--0:0
      function TextDAO_Storages_Schema_u_getProposalStatus(v0, v1) -> result {
        let v2 := 0
        let v3 := 0
        let v4 := 0
        let v5 := 0
        v2 := TextDAO_Storages_Schema_u_getProposalMetaSlot(v0, v1)
        v4 := TextDAO_Storages_Schema_u_META_OFFSET_STATUS()
        /* TextDAO.Storages.Schema:569:9--569:14 */
        v5 := add(v2, v4)
        v3 := EVM_Primitives_u_sload(v5, v1)
        result := TextDAO_Storages_Schema_u_intToProposalStatus(v3)
      }
      // @source: TextDAO.Storages.Schema:0:0--0:0
      function TextDAO_Storages_Schema_u_getProposalSlot(v0, v1) -> result {
        let v2 := 0
        let v3 := 0
        let v4 := 0
        let v5 := 0
        let v6 := 0
        let v7 := 0
        let v8 := 0
        /* TextDAO.Storages.Schema:248:2--248:8 */
        v3 := 0
        v2 := EVM_Primitives_u_mstore(v3, v0, v1)
        /* TextDAO.Storages.Schema:249:2--249:8 */
        v5 := 32
        /* TextDAO.Storages.Schema:249:2--249:8 */
        v6 := TextDAO_Storages_Schema_u_SLOT_DELIBERATION()
        v4 := EVM_Primitives_u_mstore(v5, v6, v1)
        v7 := 0
        v8 := 64
        result := EVM_Primitives_u_keccak256(v7, v8, v1)
      }
      // @source: TextDAO.Storages.Schema:0:0--0:0
      function TextDAO_Storages_Schema_u_getProposalMetaSlot(v0, v1) -> result {
        let v2 := 0
        let v3 := 0
        v2 := TextDAO_Storages_Schema_u_getProposalSlot(v0, v1)
        v3 := 48
        result := add(v2, v3)
      }
      // @source: TextDAO.Storages.Schema:0:0--0:0
      function TextDAO_Storages_Schema_u_getProposalExpiration(v0, v1) -> result {
        let v2 := 0
        let v3 := 0
        let v4 := 0
        v2 := TextDAO_Storages_Schema_u_getProposalMetaSlot(v0, v1)
        v3 := TextDAO_Storages_Schema_u_META_OFFSET_EXPIRATION()
        v4 := add(v2, v3)
        result := EVM_Primitives_u_sload(v4, v1)
      }
      // @source: TextDAO.Storages.Schema:0:0--0:0
      function TextDAO_Storages_Schema_u_getProposalAuthor(v0, v1) -> result {
        let v2 := 0
        let v3 := 0
        let v4 := 0
        v2 := TextDAO_Storages_Schema_u_getProposalMetaSlot(v0, v1)
        v3 := TextDAO_Storages_Schema_u_META_OFFSET_AUTHOR()
        v4 := add(v2, v3)
        result := EVM_Primitives_u_sload(v4, v1)
      }
      // @source: TextDAO.Storages.Schema:0:0--0:0
      function TextDAO_Storages_Schema_u_SLOT_DELIBERATION() -> result {
        result := 4096
      }
      // @source: TextDAO.Storages.Schema:0:0--0:0
      function TextDAO_Storages_Schema_u_META_OFFSET_STATUS() -> result {
        result := 9
      }
      // @source: TextDAO.Storages.Schema:0:0--0:0
      function TextDAO_Storages_Schema_u_META_OFFSET_EXPIRATION() -> result {
        result := 1
      }
      // @source: TextDAO.Storages.Schema:0:0--0:0
      function TextDAO_Storages_Schema_u_META_OFFSET_AUTHOR() -> result {
        result := 8
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_timestamp(v0) -> result {
        result := EVM_Primitives_u_prim__timestamp(v0)
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
      function EVM_Primitives_u_prim__timestamp(arg0) -> result {
        result := timestamp()
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
      function EVM_Primitives_u_prim__log2(arg0, arg1, arg2, arg3, arg4) -> result {
        log2(arg0, arg1, arg2, arg3)
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
      function EVM_Primitives_u_mstore(v0, v1, v2) -> result {
        result := EVM_Primitives_u_prim__mstore(v0, v1, v2)
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_log2(v0, v1, v2, v3, v4) -> result {
        result := EVM_Primitives_u_prim__log2(v0, v1, v2, v3, v4)
      }
      // @source: EVM.Primitives:0:0--0:0
      function EVM_Primitives_u_keccak256(v0, v1, v2) -> result {
        result := EVM_Primitives_u_prim__keccak256(v0, v1, v2)
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
      // @source: Prelude.EqOrd:0:0--0:0
      function Prelude_EqOrd_u___Ord_Integer(v0, v1) -> result {
        let v2 := 0
        v2 := lt(v0, v1)
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
      // @source: Subcontract.Core.Evidence:0:0--0:0
      function Subcontract_Core_Evidence_u_tagEvidence(v0) -> result {
        let v1 := 0
        let v2 := 0
        let v3 := 0
        let v4 := 0
        let v5 := 0
        let v6 := 0
        v2 := 0
        /* Subcontract.Core.Evidence:43:31--43:32 */
        v1 := 0
        v3 := 1
        v4 := 0
        v5 := 0
        v6 := 0
        result := 0
      }
      // @source: Subcontract.Core.ABI.Decoder:0:0--0:0
      function Subcontract_Core_ABI_Decoder_u_runDecoder(v0, v1) -> result {
        let v2 := 0
        let v3 := 0
        let v4 := 0
        let v5 := 0
        let v6 := 0
        /* Subcontract.Core.ABI.Decoder:139:13--139:22 */
        v3 := 4
        /* Subcontract.Core.ABI.Decoder:139:13--139:22 */
        v4 := apply_closure(v0, v3)
        v2 := apply_closure(v4, v1)
        switch mload(v2)
        case 1 {
  v5 := mload(add(v2, 32))
  v6 := mload(add(v2, 64))
  result := v5
}

      }
      // @source: Subcontract.Core.ABI.Decoder:0:0--0:0
      function Subcontract_Core_ABI_Decoder_u_prim__calldataload(arg0, arg1) -> result {
        result := calldataload(arg0)
      }
      // @source: Subcontract.Core.ABI.Decoder:0:0--0:0
      function Subcontract_Core_ABI_Decoder_u_decodeUint256(v0, v1) -> result {
        let v2 := 0
        let v3 := 0
        let v4 := 0
        v2 := Subcontract_Core_ABI_Decoder_u_calldataload(v0, v1)
        v3 := 32
        v4 := add(v0, v3)
        result := 1
      }
      // @source: Subcontract.Core.ABI.Decoder:0:0--0:0
      function Subcontract_Core_ABI_Decoder_u_calldataload(v0, v1) -> result {
        result := Subcontract_Core_ABI_Decoder_u_prim__calldataload(v0, v1)
      }
    }
  }
}
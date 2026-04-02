module Dao.DaoEntrypoints

import Dao.EmergencyStopLogic

%default total

public export
requireNotPaused : DaoState -> Either String DaoState
requireNotPaused state =
  if paused state then Left "daoPaused" else Right state

public export
whenNotPaused : (DaoState -> Either String a) -> DaoState -> Either String a
whenNotPaused action state =
  case requireNotPaused state of
    Left err => Left err
    Right ready => action ready

public export
submitProposal : String -> DaoState -> Either String String
submitProposal proposalId =
  whenNotPaused (\_ => Right ("submitProposal:" ++ proposalId))

public export
castVote : String -> Bool -> DaoState -> Either String String
castVote proposalId support =
  whenNotPaused (\_ => Right ("castVote:" ++ proposalId ++ ":" ++ show support))

public export
executeProposal : String -> DaoState -> Either String String
executeProposal proposalId =
  whenNotPaused (\_ => Right ("executeProposal:" ++ proposalId))

public export
transferTreasury : Address -> Integer -> DaoState -> Either String String
transferTreasury recipient amount =
  whenNotPaused (\_ => Right ("transferTreasury:" ++ recipient ++ ":" ++ show amount))

module Dao.EmergencyStopTypes

%default total

public export
Address : Type
Address = String

public export
Timestamp : Type
Timestamp = Integer

public export
record AuditorApproval where
  constructor MkAuditorApproval
  incidentId : String
  auditor : Address
  approvedAt : Timestamp

public export
record ShareholderBallot where
  constructor MkShareholderBallot
  shareholder : Address
  shares : Integer
  supportRelease : Bool

public export
record ShareholderReleaseVote where
  constructor MkShareholderReleaseVote
  voteId : String
  totalShares : Integer
  yesShares : Integer
  noShares : Integer
  ballots : List ShareholderBallot
  finalized : Bool

public export
record IncidentPause where
  constructor MkIncidentPause
  incidentId : String
  reason : String
  triggeredBy : List AuditorApproval
  executedAt : Maybe Timestamp
  paused : Bool
  releaseVote : Maybe ShareholderReleaseVote

public export
record EmergencyRoles where
  constructor MkEmergencyRoles
  auditors : List Address
  shareholders : List Address
  proxyAdmin : Address
  treasuryOperator : Address

public export
record EmergencyStopState where
  constructor MkEmergencyStopState
  roles : EmergencyRoles
  activePause : Maybe IncidentPause
  incidentLedger : List IncidentPause

public export
emptyReleaseVote : String -> Integer -> ShareholderReleaseVote
emptyReleaseVote voteId totalShares =
  MkShareholderReleaseVote voteId totalShares 0 0 [] False

public export
shareholderMajority : ShareholderReleaseVote -> Bool
shareholderMajority vote =
  yesShares vote * 2 > totalShares vote

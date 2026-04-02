module Dao.EmergencyStopLogic

import Dao.EmergencyStopTypes

%default total

public export
record DaoState where
  constructor MkDaoState
  paused : Bool
  roles : EmergencyRoles
  incidentPause : Maybe IncidentPause
  incidentHistory : List IncidentPause

public export
minimumAuditorApprovals : Integer
minimumAuditorApprovals = 3

public export
onlyAuditor : Address -> DaoState -> Bool
onlyAuditor caller state =
  elem caller (auditors (roles state))

public export
alreadyApproved : Address -> IncidentPause -> Bool
alreadyApproved caller pause =
  any (\approval => auditor approval == caller) (triggeredBy pause)

public export
approvalCount : IncidentPause -> Integer
approvalCount pause =
  cast (length (triggeredBy pause))

public export
appendApproval : AuditorApproval -> IncidentPause -> IncidentPause
appendApproval approval pause =
  record { triggeredBy = approval :: triggeredBy pause } pause

public export
approveIncidentPause : Address -> Timestamp -> String -> String -> DaoState -> Either String DaoState
approveIncidentPause caller now incidentId reason state =
  if not (onlyAuditor caller state) then
    Left "onlyAuditor"
  else
    let basePause =
          case incidentPause state of
            Just pause => pause
            Nothing => MkIncidentPause incidentId reason [] Nothing False Nothing in
    if alreadyApproved caller basePause then
      Left "alreadyApproved"
    else
      let approval = MkAuditorApproval incidentId caller now
          updatedPause = appendApproval approval basePause in
      Right (record { incidentPause = Just updatedPause } state)

public export
executeIncidentPause : Timestamp -> DaoState -> Either String DaoState
executeIncidentPause now state =
  case incidentPause state of
    Nothing => Left "missingIncidentPause"
    Just pause =>
      if approvalCount pause < minimumAuditorApprovals then
        Left "insufficientAuditorApprovals"
      else
        let executedPause = record
              { executedAt = Just now
              , paused = True
              } pause
            pausedState = record
              { paused = True
              , incidentPause = Just executedPause
              , incidentHistory = executedPause :: incidentHistory state
              } state in
        Right pausedState

public export
startUnpauseVote : String -> Integer -> DaoState -> Either String DaoState
startUnpauseVote voteId totalShares state =
  case incidentPause state of
    Nothing => Left "missingIncidentPause"
    Just pause =>
      let releaseVote = emptyReleaseVote voteId totalShares
          updatedPause = record { releaseVote = Just releaseVote } pause in
      Right (record { incidentPause = Just updatedPause } state)

public export
castUnpauseVote : Address -> Integer -> Bool -> DaoState -> Either String DaoState
castUnpauseVote shareholder shares supportRelease state =
  case incidentPause state of
    Nothing => Left "missingIncidentPause"
    Just pause =>
      case releaseVote pause of
        Nothing => Left "missingReleaseVote"
        Just vote =>
          let ballot = MkShareholderBallot shareholder shares supportRelease
              updatedVote =
                if supportRelease then
                  record
                    { yesShares = yesShares vote + shares
                    , ballots = ballot :: ballots vote
                    } vote
                else
                  record
                    { noShares = noShares vote + shares
                    , ballots = ballot :: ballots vote
                    } vote
              updatedPause = record { releaseVote = Just updatedVote } pause in
          Right (record { incidentPause = Just updatedPause } state)

public export
clearIncidentPause : DaoState -> DaoState
clearIncidentPause state =
  record
    { paused = False
    , incidentPause = Nothing
    } state

public export
finalizeUnpauseVote : DaoState -> Either String DaoState
finalizeUnpauseVote state =
  case incidentPause state of
    Nothing => Left "missingIncidentPause"
    Just pause =>
      case releaseVote pause of
        Nothing => Left "missingReleaseVote"
        Just vote =>
          let finalizedVote = record { finalized = True } vote in
          if shareholderMajority finalizedVote then
            let pausedState = record
                  { paused = False
                  , incidentPause = Just (record { releaseVote = Just finalizedVote } pause)
                  } state in
            Right (clearIncidentPause pausedState)
          else
            let retainedPause = record { releaseVote = Just finalizedVote } pause in
            Right (record { incidentPause = Just retainedPause } state)

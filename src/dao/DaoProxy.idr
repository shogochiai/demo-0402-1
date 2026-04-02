module Dao.DaoProxy

import Dao.EmergencyStopTypes

%default total

public export
Selector : Type
Selector = String

public export
ImplementationRef : Type
ImplementationRef = Address

public export
getImplementationSelector : Selector
getImplementationSelector = "0xdc9cc645"

public export
record DaoSelectorTable where
  constructor MkDaoSelectorTable
  emergencyStopImplementation : ImplementationRef
  governanceImplementation : ImplementationRef
  treasuryImplementation : ImplementationRef

public export
getImplementation : Selector -> DaoSelectorTable -> ImplementationRef
getImplementation selector table =
  case selector of
    "0xdc9cc645" => emergencyStopImplementation table
    "0x8f283970" => governanceImplementation table
    "0xa52fd6b4" => treasuryImplementation table
    _ => governanceImplementation table

public export
proxyFallback : Selector -> DaoSelectorTable -> ImplementationRef
proxyFallback selector table =
  getImplementation selector table

public export
erc7546RoutingNote : String
erc7546RoutingNote =
  "ERC-7546 upgradeable clone routing keeps proxy storage minimal and delegates logic lookups through getImplementation(bytes4)."

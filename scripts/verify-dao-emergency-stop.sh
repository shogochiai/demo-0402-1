#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERIFY_DIR="$ROOT_DIR/verify"

mkdir -p "$VERIFY_DIR"

cat > "$VERIFY_DIR/dao_emergency_stop.verification.json" <<'JSON'
{
  "verification_system": "IcWasm.Verification",
  "flow": [
    "Artifact EVM",
    "Deployed EVM"
  ],
  "network": "Base Mainnet",
  "artifact": "build/dao-emergency-stop/solc/EmergencyStopLogic.bin",
  "deployment_manifest": "deploy/base-mainnet/dao_emergency_stop.release.json",
  "checks": [
    "Confirm deployed bytecode matches the locally built strict-assembly output.",
    "Confirm proxy selector 0xdc9cc645 resolves getImplementation(bytes4) as expected.",
    "Record the verification receipt for the TheWorld DAO release."
  ]
}
JSON

echo "Prepared IcWasm.Verification payload at $VERIFY_DIR/dao_emergency_stop.verification.json"

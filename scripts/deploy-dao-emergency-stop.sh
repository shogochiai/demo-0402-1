#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="$ROOT_DIR/build/dao-emergency-stop"
DEPLOY_DIR="$ROOT_DIR/deploy/base-mainnet"

mkdir -p "$DEPLOY_DIR"

cat > "$DEPLOY_DIR/dao_emergency_stop.release.json" <<'JSON'
{
  "project": "TheWorld",
  "network": "Base Mainnet",
  "signer": "t-ECDSA",
  "artifact": "build/dao-emergency-stop/solc/EmergencyStopLogic.bin",
  "proxy_module": "src/dao/DaoProxy.idr",
  "logic_module": "src/dao/EmergencyStopLogic.idr",
  "notes": [
    "Deploy the ERC-7546 upgradeable clone proxy first.",
    "Register DAO selector routing before enabling the implementation.",
    "Persist the Base Mainnet deployment metadata for post-deploy verification."
  ]
}
JSON

echo "Prepared Base Mainnet deployment manifest at $DEPLOY_DIR/dao_emergency_stop.release.json"

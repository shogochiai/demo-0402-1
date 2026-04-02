#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="$ROOT_DIR/build/dao-emergency-stop"
SRC_FILE="$ROOT_DIR/src/dao/EmergencyStopLogic.idr"

mkdir -p "$BUILD_DIR/solc"

echo "Compiling DAO emergency stop Idris source to Yul via idris2-evm"
idris2-yul --codegen yul "$SRC_FILE" -o "$BUILD_DIR/EmergencyStopLogic.yul"

echo "Compiling strict Yul assembly to EVM bytecode"
solc --strict-assembly "$BUILD_DIR/EmergencyStopLogic.yul" --bin -o "$BUILD_DIR/solc"

echo "Artifacts written to $BUILD_DIR"

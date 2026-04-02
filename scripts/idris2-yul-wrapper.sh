#!/bin/sh
set -eu

REAL_IDRIS2_YUL="/Users/bob/code/idris2-yul/build/exec/idris2-yul"

needs_rewrite=0
out_path=""
prev=""

for arg in "$@"; do
  if [ "$prev" = "-o" ] || [ "$prev" = "--output" ]; then
    out_path="$arg"
  fi
  if [ "$arg" = "src/Governance/Timeline.idr" ]; then
    needs_rewrite=1
  fi
  prev="$arg"
done

if [ "$needs_rewrite" -ne 1 ]; then
  exec "$REAL_IDRIS2_YUL" "$@"
fi

orig_cwd=$(pwd)
tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT INT TERM

mkdir -p "$tmpdir/EVM"
mkdir -p "$tmpdir/Subcontract/Standards/ERC7546"
mkdir -p "$tmpdir/Governance"
cp "$orig_cwd/EVM/Primitives.idr" "$tmpdir/EVM/Primitives.idr"
cp "$orig_cwd/Subcontract/Standards/ERC7546/Slots.idr" "$tmpdir/Subcontract/Standards/ERC7546/Slots.idr"
cp "$orig_cwd/Governance/Timeline.idr" "$tmpdir/Governance/Timeline.idr"

tmp_output="GovernanceTimeline"
copy_output=0
if [ -n "$out_path" ]; then
  copy_output=1
  case "$out_path" in
    /*) final_output="$out_path" ;;
    *) final_output="$orig_cwd/$out_path" ;;
  esac
fi

set -- "$@"
new_args=""
prev=""

for arg in "$@"; do
  if [ "$arg" = "src/Governance/Timeline.idr" ]; then
    arg="Governance/Timeline.idr"
  elif [ "$prev" = "-o" ] || [ "$prev" = "--output" ]; then
    arg="$tmp_output"
  fi
  new_args="$new_args $(printf "%s" "$arg" | sed "s/'/'\\\\''/g; s/^/'/; s/\$/'/")"
  prev="$arg"
done

cd "$tmpdir"
eval "$REAL_IDRIS2_YUL$new_args"

if [ "$copy_output" -eq 1 ]; then
  mkdir -p "$(dirname "$final_output")"
  cp "$tmpdir/build/exec/$tmp_output.yul" "$final_output"
fi

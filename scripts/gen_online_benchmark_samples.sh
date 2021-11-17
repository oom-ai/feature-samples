#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1
OUT="$SDIR/online_benchmark_samples"

usage() { echo "Usage: $(basename "$0") <size>" >&2; }

[ $# -ne 1 ] && usage && exit 1

size="$1"

just gen ./scenarios/fraud_detection "$size"

mkdir -p "$OUT"
mv ../build/fraud_detection/out/*.csv "$OUT"


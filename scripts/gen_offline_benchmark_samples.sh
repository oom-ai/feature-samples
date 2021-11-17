#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1
OUT="$SDIR/offline_benchmark_samples"

usage() { echo "Usage: $(basename "$0") <start_date> <end_date> <size> <label_size>" >&2; }

[ $# -ne 4 ] && usage && exit 1

start=$(date -I -d "$1")
end=$(date -I -d "$2")
size=$3
label_size=$4

curr=$start

while [ "$curr" != "$end" ]; do
    echo "=== $curr ==="
    next=$(date -I -d "$curr +1 day")
    just seed="$(date +%s -d "$curr")" start="$curr" end="$next" \
        gen ./scenarios/fraud_detection "$size"
    mkdir -p "$OUT/$curr"
    mv ../build/fraud_detection/out/*.csv "$OUT/$curr"
    curr=$next
done

echo "=== labeles ==="
just seed="$(date +%s -d "$start")" start="$start" end="$end" \
    gen ./scenarios/user_label "$label_size"

mv ../build/user_label/out/*.csv "$OUT"

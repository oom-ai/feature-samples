set positional-arguments

list:
	#!/usr/bin/env bash
	for f in ./scenarios/*; do
		echo "$(basename "$f")"
	done

gen size scenario_path:
	#!/usr/bin/env bash
	set -euo pipefail

	info() { printf "%b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
	warn() { printf "%b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
	erro() { printf "%b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; }


	scenario_name=$(basename "{{ scenario_path }}")
	OUT="build/$scenario_name"
	data="$OUT/$scenario_name.json"
	tables=()
	mkdir -p "$OUT"

	for f in "{{ scenario_path }}"/*.json; do
		tables+=("$(basename "$f" .json)")
	done

	info "run synth ..."
	synth generate "{{ scenario_path }}" --size "{{ size }}" > "$data"

	for table in "${tables[@]}"; do
		info "generate $table.csv ..."
		<"$data" >"$OUT/$table.csv" jq -r ".$table | (map(keys) | add | unique) as \$cols | map(. as \$row | \$cols | map(\$row[.])) as \$rows | \$cols, \$rows[] | @csv"
	done

@clean:
	rm -rf build

set positional-arguments

seed := "0"
start := `date -d yesterday`
end := `date`

list:
	#!/usr/bin/env bash
	for f in ./scenarios/*; do
		echo "$(basename "$f")"
	done

gen scenario_path size:
	#!/usr/bin/env bash
	set -euo pipefail

	SIZE={{ size }}
	START=$(date -d '{{ start }}' +%s)
	END=$(date -d '{{ end }}' +%s)

	info() { printf "%b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
	warn() { printf "%b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
	erro() { printf "%b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; }

	scenario_name="$(basename "{{ scenario_path }}")"
	IN="build/$scenario_name/in"
	OUT="build/$scenario_name/out"
	data="$OUT/.data.json"
	tables=()
	rm -rf "$IN" "$OUT"
	mkdir -p "$IN" "$OUT"

	for f in "{{ scenario_path }}"/*.json; do
		table="$(basename "$f" .json)"
		cat "$f" |
			sed "s/\"{{{{SIZE}}\"/$SIZE/g" |
			sed "s/\"{{{{START}}\"/$START/g" |
			sed "s/\"{{{{END}}\"/$END/g" \
			>"$IN/$(basename "$f")"
		< "$f" jq '.content | keys_unsorted[]' -r |grep -v type > "$IN/$table.fields"
		tables+=("$table")
	done

	info "run synth ..."
	synth generate "$IN" --size "{{ size }}" --seed {{ seed }} > "$data"

	for table in "${tables[@]}"; do
		info "generate $table.csv ..."
		target="$OUT/$table.csv"
		<"$IN/$table.fields" paste -sd, >"$target"
		fields=$(<"$IN/$table.fields" sed 's/.*/\.&/' |  paste -sd,)
		<"$data" jq ".$table[] | [$fields] | @csv" -r >>"$target"
	done

@clean:
	rm -rf build

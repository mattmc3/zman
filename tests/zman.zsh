0=${(%):-%N}
@echo "=== ${0:t:r} ==="
PRJ_HOME=${0:A:h:h}

@test "ZMAN_BROWSER is not set" -z "$ZMAN_BROWSER"
@test "ZMAN_URL is not set" -z "$ZMAN_URL"
@test "zman_lookup is not set" -z "$zman_lookup"

source ${0:a:h:h}/zman.zsh
@test "sourcing zman succeeded" $? -eq 0

@test "ZMAN_BROWSER is set" -n "$ZMAN_BROWSER"
@test "ZMAN_URL is set" "$ZMAN_URL" = "https://zsh.sourceforge.io/Doc/Release"
@test "zman_lookup is an associative array" "${(t)zman_lookup}" = "association"

lookup_count=$(wc -l $PRJ_HOME/lib/zman_lookup.zsh | awk '{print $1}')
(( lookup_count = lookup_count - 2 ))
@test "zman_lookup has correct number of items: '$lookup_count'" "${#zman_lookup[@]}" -eq $lookup_count

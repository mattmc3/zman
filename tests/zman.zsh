0=${(%):-%N}
@echo "=== ${0:t:r} ==="
PRJ_HOME=${0:A:h:h}

# ensure clean environment
@test "ZMAN_URL is not set" -z "$ZMAN_URL"
@test "zman_lookup is not set" -z "$zman_lookup"
@test "zman is not a function" "$+functions[zman]" -eq 0

source ${0:a:h:h}/zman.zsh
@test "sourcing zman succeeded" $? -eq 0

# mocks
function fzf() {
  # fake a selection
  echo "AUTOCD (16.2.1 Changing Directories)"
}
selection_result=
function browser() {
  selection_result="${@:t}"
  @echo "browse $@"
}
ZMAN_BROWSER='browser'

# call zman
zman acd
#result=$(zman acd)

# ensure zman worked
@test "zman is a function" "$+functions[zman]" -ne 0
@test "ZMAN_URL is set" "$ZMAN_URL" = "https://zsh.sourceforge.io/Doc/Release"
@test "zman_lookup is an associative array" "${(t)zman_lookup}" = "association"
@test "selection result is correct AUTOCD page" "$selection_result" = "Options.html#index-AUTOCD"

lookup_count=$(wc -l $PRJ_HOME/lib/zman_lookup.zsh | awk '{print $1}')
(( lookup_count = lookup_count - 2 ))
@test "zman_lookup has correct number of items: '$lookup_count'" "${#zman_lookup[@]}" -eq $lookup_count

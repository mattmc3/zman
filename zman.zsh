# Copyright (c) 2021 mattmc3
# MIT license
# zman.zsh
# homepage: https://github.com/mattmc3/zman

0=${(%):-%N}

() {
  local basedir="${${(%):-%x}:a:h}"
  local fnfile="$basedir/functions/zman"
  local fnname="${fnfile:t}"
  (( $+functions[$fnname] )) && unfunction "$fnname"
  autoload -Uz "$fnfile"
}

# Copyright (c) 2021 mattmc3
# MIT license
# zman.zsh
# homepage: https://github.com/mattmc3/zman

0=${(%):-%N}

() {
  ZMAN_URL=${ZMAN_URL:-https://zsh.sourceforge.io/Doc/Release}
  if [[ -n "$BROWSER" ]]; then
    ZMAN_BROWSER=$BROWSER
  elif [[ "$OSTYPE" == darwin* ]]; then
    ZMAN_BROWSER=open
  elif [[ "$OSTYPE" == cygwin* ]]; then
    ZMAN_BROWSER=cygstart
  else
    ZMAN_BROWSER=xdg-open
  fi

  local basedir="${${(%):-%x}:a:h}"
  source $basedir/lib/zman_lookup.zsh
  local funcdir="$basedir/functions"
  fpath+="$funcdir"
  local fnfile; for fnfile in "$funcdir"/*(.N); do
    local fnname="${fnfile:t}"
    (( $+functions[$fnname] )) && unfunction "$fnname"
    autoload -Uz "$fnfile"
  done
}

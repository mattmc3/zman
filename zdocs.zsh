# Copyright (c) 2021 mattmc3
# MIT license
# zdocs.zsh
# homepage: https://github.com/mattmc3/zdocs

0=${(%):-%N}

() {
  ZDOCS_URL=${ZDOCS_URL:-https://zsh.sourceforge.io/Doc/Release}
  if [[ -z $BROWSER ]]; then
    ZDOCS_BROWSER=$BROWSER
  elif [[ "$OSTYPE" == darwin* ]]; then
    ZDOCS_BROWSER=open
  elif [[ "$OSTYPE" == cygwin* ]]; then
    ZDOCS_BROWSER=cygstart
  else
    ZDOCS_BROWSER=xdg-open
  fi

  local basedir="${${(%):-%x}:a:h}"
  source $basedir/lib/zdocs_lookup.zsh
  local funcdir="$basedir/functions"
  fpath+="$funcdir"
  local fnfile; for fnfile in "$funcdir"/*(.N); do
    local fnname="${fnfile:t}"
    (( $+functions[$fnname] )) && unfunction "$fnname"
    autoload -Uz "$fnfile"
  done
}

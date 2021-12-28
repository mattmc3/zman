#!/usr/bin/env zsh
# contents of ./bin/runtests in your project

0=${(%):-%N}
PROJECT_HOME=${0:a:h:h}
ZTAP_HOME=${ZTAP_HOME:-$PROJECT_HOME/.ztap}

[[ -f $ZTAP_HOME/ztap.zsh ]] ||
  git clone --depth 1 -q https://github.com/mattmc3/ztap.git $ZTAP_HOME

source $ZTAP_HOME/ztap.zsh
if [[ $# -gt 0 ]]; then
  ztap -c "$@"
else
  ztap -c $PROJECT_HOME/tests/*.zsh
fi

# Copyright (c) 2021 mattmc3
# MIT license
# zman.zsh
# homepage: https://github.com/mattmc3/zman

0=${(%):-%N}

() {
  emulate -L zsh; setopt local_options
  typeset -gax _zman_fzf_opts=(--layout=reverse-list)
  (( $+functions[zman] )) && unfunction zman

  0="${(%):-%x}"
  autoload -Uz "${0:a:h}/functions/zman"
}

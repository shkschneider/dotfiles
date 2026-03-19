#!/usr/bin/env zsh
# /usr/local/etc/zsh/cli.zsh ~/.config/zsh/cli.zsh

autoload -Uz edit-command-line
zle -N edit-command-line

bindkey '^x' edit-command-line

# EOF

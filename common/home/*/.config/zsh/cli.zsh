#!/usr/bin/env zsh
# ~/.config/zs/cli.zsh

autoload -Uz edit-command-line
zle -N edit-command-line

bindkey '^x' edit-command-line

# EOF

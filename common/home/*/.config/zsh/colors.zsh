#!/usr/bin/env zsh
# ~/.config/zsh/colors.zsh

Z_COLORS=${Z_COLORS:-true}
[[ "${Z_COLORS:-}" == true ]] || return

autoload -Uz colors
[[ $OSTYPE == darwin* ]] && export CLICOLOR=1

# EOF

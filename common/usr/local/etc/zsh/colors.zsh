#!/usr/bin/env zsh
# /usr/local/etc/zsh/colors.zsh ~/.config/zsh/colors.zsh

Z_COLORS=${Z_COLORS:-true}
[[ "${Z_COLORS:-}" == true ]] || return

autoload -Uz colors

# EOF

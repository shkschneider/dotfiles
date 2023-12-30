# ~/.config/zsh/highlight.zsh

Z_HIGHLIGHT=${Z_HIGHLIGHT:-true}

[[ "${Z_HIGHLIGHT:-}" == true ]] || return

zource 'zdharma-continuum/fast-syntax-highlighting'

# EOF

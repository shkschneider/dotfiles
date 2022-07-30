# highlight.zsh

Z_HIGHLIGHT=${Z_HIGHLIGHT:-0}

[[ $Z_HIGHLIGHT -ne 0 ]] || return

zource 'zdharma-continuum/fast-syntax-highlighting'

# EOF

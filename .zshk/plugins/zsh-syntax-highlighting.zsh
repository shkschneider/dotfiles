# @author shkschneider
# zsh-syntax-highlighting.zsh

ZSHK=${${ZSHK:=$ZSH_CUSTOM}:=$ZSH}

if [ -f "$ZSHK/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] ; then
    zle_highlight=()
    source "$ZSHK/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# EOF

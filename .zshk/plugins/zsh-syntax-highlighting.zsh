# @author shkschneider
# zsh-syntax-highlight.zsh

ZSH_CUSTOM=${ZSH_CUSTOM:=$ZSHK}

if [ -f "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] ; then
    zle_highlight=()
    source "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# EOF

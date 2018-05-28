# @author shkschneider
# zsh-autosuggestions.zsh

ZSHK=${${ZSHK:=$ZSH_CUSTOM}:=$ZSH}

if [ -f "$ZSHK/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ] ; then
    source "$ZSHK/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=white,underline"
    bindkey '^ ' autosuggest-accept
fi

# EOF

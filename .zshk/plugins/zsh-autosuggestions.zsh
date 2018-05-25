# @author shkschneider
# zsh-autosuggestions.zsh

if [ -f "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ] ; then
    source "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=white,underline"
    bindkey '^ ' autosuggest-accept
fi

# EOF

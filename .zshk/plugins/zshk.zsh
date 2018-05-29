# @author shkschneider
# plugins.zsh

ZSHK=${${ZSHK:=$ZSH_CUSTOM}:=$ZSH}

if [ -f "$ZSHK/plugins/zsh-completions/zsh-completions.plugin.zsh" ] ; then
    fpath=( "$ZSHK/plugins/zsh-completions/src/" $fpath )
    export FPATH
    autoload -Uz compinit && compinit
fi

if [ -f "$ZSHK/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ] ; then
    source "$ZSHK/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=white,underline"
    bindkey '^ ' autosuggest-accept # ctrl-space
fi

# make sure to load zsh-syntax-highlighting AFTER zsh-autosuggestions
if [ -f "$ZSHK/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] ; then
    zle_highlight=()
    source "$ZSHK/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

if [ -f "$ZSHK/plugins/fpwd/fpwd.plugin.zsh" ] ; then
    source "$ZSHK/plugins/fpwd/fpwd.plugin.zsh"
fi

# EOF

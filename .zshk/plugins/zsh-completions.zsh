# @author shkschneider
# zsh-completions.zsh

ZSHK=${${ZSHK:=$ZSH_CUSTOM}:=$ZSH}

if [ -f "$ZSHK/plugins/zsh-completions/zsh-completions.plugin.zsh" ] ; then
    fpath=( "$ZSHK/plugins/zsh-completions/src/" $fpath )
    export FPATH
    autoload -Uz compinit && compinit
fi

# EOF

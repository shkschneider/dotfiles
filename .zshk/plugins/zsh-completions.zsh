# @author shkschneider
# zsh-completions.zsh

ZSH_CUSTOM=${ZSH_CUSTOM:=$ZSHK}

if [ -f "$ZSH_CUSTOM/plugins/zsh-completions/zsh-completions.plugin.zsh" ] ; then
    autoload -U compinit && compinit
    fpath=( "$ZSH_CUSTOM/plugins/zsh-completions/" $fpath )
    export FPATH
fi

if [ -f "/etc/bash_completion" ] ; then
    autoload -Uz bashcompinit && bashcompinit
    autoload -Uz compinit && compinit
    source "/etc/bash_completion" 2>/dev/null
fi

# EOF

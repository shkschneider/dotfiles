# @author shkschneider
# git.zsh

ZSH_CUSTOM=${ZSH_CUSTOM:=$ZSHK}

if [ -f "$ZSH_CUSTOM/plugins/git/contrib/completion/git-completion.zsh" ] ; then
    zstyle ':completion:*:*:git:*' script "$ZSH_CUSTOM/plugins/git/contrib/completion/git-completion.zsh"
    fpath=( $ZSH_CUSTOM/plugins/git/contrib/completion $fpath )
    export FPATH
    #source /usr/share/zsh/functions/Completion/Unix/_git 2>/dev/null
    #source /usr/share/bash-completion/completions/gitk 2>/dev/null
    #source $ZSH_CUSTOM/plugins/git/contrib/completion/git-completion.zsh
fi

# EOF

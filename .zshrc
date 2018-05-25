# @author shkschneider
# .zshrc (vanilla zsh)

[[ $- == *i* ]] || return
[ -z "${(@)TERM:#dumb}" ] && return

PROMPT='%n@%m %# '
RPROMPT='%~'

ZSH=${ZSH:-$HOME/.zsh}
[ ! -d "$ZSH" ] && mkdir "$ZSH" &>/dev/null
export ZSH
ZSHRC="${(%):-%N}"
export ZSHRC

export HISTFILE="$ZSH/history"

[ -z "$EDITOR" -a $+commands[nano] ] && export EDITOR='nano'
[ -n "$EDITOR" ] && alias zshrc="$EDITOR $ZSHRC"
(( $+commands[most] )) && export PAGER='most' || { export PAGER='less' ; export LESS='-R' }
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

bindkey -e # emacs

for _conf in $(find "$ZSH/" -maxdepth 1 -type f -name "*.zsh" 2>/dev/null | sort) ; do
    source $_conf
done
unset _conf

#
# do not edit below this line
# use $HOME/.myzshrc
#

autoload -Uz promptinit && promptinit
type prompt &>/dev/null && {
    if [ -z "$ZSH_THEME" ] ; then
        export ZSH_THEME="random"
        if [ "${#ZSH_THEME_RANDOM_CANDIDATES[@]}" -eq 0 ] ; then
            ZSH_THEME_RANDOM_CANDIDATES=()
            ZSH_THEME_RANDOM_CANDIDATES+=( $(print -l $(prompt -l 2>/dev/null | sed '1d')) )
            ZSH_THEME_RANDOM_CANDIDATES+=( $(print -l $ZSH/themes/*(:t:r)) )
            ZSH_THEME_RANDOM_CANDIDATES=(${(u)ZSH_THEME_RANDOM_CANDIDATES[@]})
        fi
        N=${#ZSH_THEME_RANDOM_CANDIDATES[@]}
        ((N=(RANDOM%N)+1))
        export RANDOM_THEME=${ZSH_THEME_RANDOM_CANDIDATES[$N]}
        echo "zshrc: random theme: '$RANDOM_THEME'" >&2
        prompt $RANDOM_THEME &>/dev/null
        [ $(prompt -c | sed '1d' | wc -l) -ne 1 ] && echo "zshrc: failed to load prompt '$RANDOM_THEME'" >&2
    elif [ -f "$ZSH/themes/$ZSH_THEME.zsh-theme" ] ; then
        source "$ZSH/themes/$ZSH_THEME.zsh-theme"
    else
        prompt $ZSH_THEME &>/dev/null
        [ $(prompt -c | sed '1d' | wc -l) -ne 1 ] && echo "zshrc: failed to load prompt '$ZSH_THEME'" >&2
    fi
    return $ZSH_THEME
} || echo "zshrc: failed to load prompt" >&2

# EOF

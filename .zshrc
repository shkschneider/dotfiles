# @author shkschneider
# .zshrc (vanilla zsh)

# you should not have to edit this file
# use $HOME/.zshkrc

[[ $- == *i* ]] || return
[ -z "$TERM" ] && return

ZSHK=${ZSH:-$HOME/.zshk}
export ZSHK
ZSHRC="${(%):-%N}"
export ZSHRC

# default prompts

PROMPT='%n@%m %# '
RPROMPT='%~'

# environment

for _editor in emacs nano ; do
    (( $+commands[$_editor] )) && export EDITOR=$_editor && break
done ; unset _editor
[ -n "$EDITOR" ] && alias zshrc="$EDITOR $ZSHRC"
for _pager in most less more ; do
    (( $+commands[$_pager] )) && export PAGER=$_pager && break
done ; unset _pager
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# keybindings

bindkey -e # emacs

# custom configurations

if [ -d "$ZSHK/" ] ; then
    for _conf in $(find "$ZSHK/" -maxdepth 1 -type f -name "*.zsh" 2>/dev/null | sort) ; do
        source $_conf
    done ; unset _conf
elif [ -f "$HOME/.myzshrc" ] ; then
    source "$HOME/.myzshrc"
fi

# do not edit below this line

autoload -Uz promptinit && promptinit
type prompt &>/dev/null && {
    if [ -z "$ZSH_THEME" ] ; then
        export ZSH_THEME="random"
        if [ "${#ZSH_THEME_RANDOM_CANDIDATES[@]}" -eq 0 ] ; then
            ZSH_THEME_RANDOM_CANDIDATES=()
            ZSH_THEME_RANDOM_CANDIDATES+=( $(print -l $(prompt -l 2>/dev/null | sed '1d')) )
            [ -d "$ZSHK/themes" ] && ZSH_THEME_RANDOM_CANDIDATES+=( $(print -l $ZSHK/themes/*(:t:r)) )
            ZSH_THEME_RANDOM_CANDIDATES=(${(u)ZSH_THEME_RANDOM_CANDIDATES[@]})
        fi
        export RANDOM_THEME=$ZSH_THEME_RANDOM_CANDIDATES[$RANDOM%$#ZSH_THEME_RANDOM_CANDIDATES+1]
        echo "zshk: random theme: '$RANDOM_THEME'" >&2
        prompt $RANDOM_THEME &>/dev/null
        [ $(prompt -c | sed '1d' | wc -l) -ne 1 ] && echo "zshk: failed to load prompt '$RANDOM_THEME'" >&2
    elif [ -f "$ZSHK/themes/$ZSH_THEME.zsh-theme" ] ; then
        source "$ZSHK/themes/$ZSH_THEME.zsh-theme"
    else
        prompt $ZSH_THEME &>/dev/null
        [ $(prompt -c | sed '1d' | wc -l) -ne 1 ] && echo "zshk: failed to load prompt '$ZSH_THEME'" >&2
    fi
    return $ZSH_THEME
} || echo "zshk: failed to load prompt" >&2

# EOF

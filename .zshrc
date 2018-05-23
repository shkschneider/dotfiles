# @author shkschneider
# .zshrc (vanilla zsh)
# -> $HOME/.zsh/*.zsh

[[ $- == *i* ]] || return
[ -z "${(@)TERM:#dumb}" ] && return

#ZSH_THEME=""
#ZSH_THEME_RANDOM_CANDICATES=()
#PROMPT='%n@%m %# '
#RPROMPT='%~'

ZSH="${ZSH:-$HOME/.zsh}"
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

# simulates oh-my-zsh
# (moving .oh-my-zsh to .zsh would make all of this compatible)

for _file in $(find "$ZSH/" -maxdepth 1 -type f -name "*.zsh" 2>/dev/null) ; do
    source $_file
done
unset _file

# EOF

#!/bin/zsh
#
# dot.zshrc -- zsh configuration
# Copyright (C) 2009-2012  Alan SCHNEIDER
#                          <shk.schneider[at]gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY.
# This is free software, and you are welcome to redistribute it
# under certain conditions.
#
# See <http://www.zzapper.co.uk/zshtips.html> for more.
#

# ~/.zshrc r2

# zsh modules

autoload -U compinit && compinit
autoload -U colors && colors
zmodload -i zsh/complist
autoload zmv

# auto-rehash if command not found

function compctl_rehash { rehash; reply=() }
compctl -C -c + -K compctl_rehash + -c

# zsh completion

zstyle '*' single-ignored show
zstyle ':completion:*:scp:*' tag-order files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*' completer _complete _correct _approximate _prefix
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# zsh completion style

zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:descriptions' format "%B---- %d%b"
zstyle ':completion:*:messages' format '%B---- %d%b'
zstyle ':completion:*:warnings' format '%B---- no match for: %d%b'

# man zshoptions

setopt extended_glob
setopt auto_menu
setopt list_types
setopt nocorrect
setopt nocorrectall
setopt completealiases

# env settings

export PAGER=most
export EDITOR=nano
export LSCOLORS="cxfxbxdxbxegedabagacad"
#export PATH=$PATH

# prompt

cn="%{$reset_color%}" # normal color
cs="%{$fg[red]%}" # symbol color
cu="%{$fg[cyan]%}" # user info color
cr="%{$fg[red]%}" # root info color
ce="%{$fg[yellow]%}" # failed error color
PROMPT="${cr}[${ce}%*${cr}.${ce}%h${cr}] ${ce}%U%n%u${cs}@${ce}%m${cs} >_ ${cn}"
RPROMPT=" ${ce}%/${cs}/${cn}"
# %n user_name
# %m local_machine_name
# %h history
# %/ full_path

# aliases

alias ls='ls --color'
alias l='ls -lhG'
alias la='ls -lhaG'
alias cd..='cd ..'
alias na='nano'
alias ne='emacs -nw'
alias st='svn st | grep "\\?" ; svn st | grep "\\!"'
alias val='valgrind -q --tool=memcheck --leak-check=yes --show-reachable=yes --error-limit=no --num-callers=50'
alias mkdir='mkdir -p'
alias bc='bc -q'
alias gdb='gdb -q'
alias cp='cp -rpv'
alias od='od -av'

# Zzsh internal functions

clean()
{
    if [ $1 ] ; then
	SEARCH="$1"
    else
	SEARCH="."
    fi
    find "$SEARCH" \( -name "*~" -print -or -name ".*~" -print -or -name "#*" -print -or -name ".#*" -print \) -exec rm -fr {} \;
}

setenv()
{
    if [ $# -eq 0 ] ; then
	env
    elif [ $# -eq 1 ] ; then
	export $1
	echo +$1
    elif [ $# -eq 2 ] ; then
	export $1=$2
	echo +$1=$2
    else
	echo "setenv: too many arguments" >&2
    fi
}

unsetenv()
{
    if [ $# -eq 0 ] ; then
	env
    elif [ $# -eq 1 ] ; then
	unset $1
	echo -$1
    else
	echo "unsetenv: too many arguments" >&2
    fi
}

# EOF

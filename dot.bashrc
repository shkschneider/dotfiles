#!/bin/zsh
#
# ~/.bashrc -- bash configuration
# Copyright (C) 2009-2012  Alan "Shtark" SCHNEIDER
#                          <shk.schneider[at]gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY.
# This is free software, and you are welcome to redistribute it
# under certain conditions.
#

# /etc/bash/bashrc
# ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Preferences

stty -ixon #disable XON/XOFF flow control (^s/^q)
shopt -s cdspell
shopt -s histappend
shopt -s checkwinsize
shopt -s dotglob

umask 022

export HISTCONTROL=ignoredups
export PAGER=most
export EDITOR=nano

# Path

[ -d ~/bin ] && PATH=~/bin:"$PATH"

# Prompt

if [[ ${EUID} == 0 ]] ; then
    PS1='\[\033[01;31m\]\u@\h\[\033[01;34m\] \W \$\[\033[00m\] '
else
    PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
fi

# Completion

[ -f /etc/bash_completion ] && ! shopt -oq posix && . /etc/bash_completion

# Aliases

alias ls='ls --color=auto -h'
alias ne='emacs -nw'
alias j='jobs'
alias cp='cp -r'
alias mkdir='mkdirp -p'
alias scp='scp -r'
# Do NOT set aliases on commands that could be used in scripts!

# Built-in

function extract () {
    if [ -f $1 ] ; then
	case $1 in
	    *.tar.bz2) tar xjf $1 ;;
	    *.tar.gz) tar xzf $1 ;;
	    *.bz2) bunzip2 $1 ;;
	    *.rar) rar x $1 ;;
	    *.gz) gunzip $1 ;;
	    *.tar) tar xf $1 ;;
	    *.tbz2) tar xjf $1 ;;
	    *.tgz) tar xzf $1 ;;
	    *.zip) unzip $1 ;;
	    *.Z) uncompress $1 ;;
	    *) echo "E: \`$1' cannot be extracted" ;;
	esac
    else
	echo "E: \`$1' is not a valid file"
    fi
}

function calc () {
    echo "$*" | bc -l
}

# EOF

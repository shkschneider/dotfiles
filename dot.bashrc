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

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Preferences

shopt -s checkwinsize
export HISTCONTROL=ignoredups

export PAGE=most
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
alias j=jobs'
alias cp='cp -r'
alias mkdir='mkdirp -p'
alias scp='scp -r'
# Do NOT set aliases on commands that could be used in scripts!

# EOF

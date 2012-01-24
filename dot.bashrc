#!/bin/bash
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
export PAGER=most
export EDITOR=nano

# Path
[ -d ~/bin ] && PATH=~/bin:"$PATH"

# Aliases
# Do NOT set aliases on commands that could be used in scripts!
alias ls='ls --color=auto -h'
alias ne='emacs -nw'
alias j='jobs'
alias cp='cp -r'
alias mkdir='mkdir -p'
alias scp='scp -r'

# Completion
[ -f /etc/bash_completion ] && ! shopt -oq posix && . /etc/bash_completion

# Many more
if [ -f ~/.bashrc_* ] ; then
    for FILE in ~/.bashrc_* ; do
	. $FILE
    done
fi

# EOF

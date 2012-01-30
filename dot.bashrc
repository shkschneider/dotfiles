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
# Try not to set aliases on commands that could be used in scripts!
alias ls='ls --color=auto -Fh'
alias ne='emacs -nw'
alias j='jobs'
# The following are not dangerous
alias cp='cp -vr'
alias mkdir='mkdir -pv'
alias scp='scp -r'
alias wget="wget --no-check-certificate"
alias bc="bc -q"
alias rm='rm -v'

# Completion
[ -f /etc/bash_completion ] && ! shopt -oq posix && . /etc/bash_completion

# Many more
FILES=$(shopt -s nullglob ; echo ~/.bashrc_*)
for FILE in $FILES ; do
    source $FILE
done

# EOF

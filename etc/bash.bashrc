#!/bin/bash
#
# bash.bashrc -- bash global configuration
# Copyright (C) 2009-2012  Alan "Shtark" SCHNEIDER
#                          <shk.schneider[at]gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY.
# This is free software, and you are welcome to redistribute it
# under certain conditions.
#

# /etc/bash.bashrc r0

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Preferences
shopt -s hostcomplete
shopt -s cdspell
shopt -s histappend
shopt -s checkwinsize
shopt -s dotglob
export HISTCONTROL=ignoredups

# Path
[ -d $HOME/bin ] && PATH="$HOME/bin:$PATH"

# Aliases
# Try not to set aliases on commands that could be used in scripts!
alias ls='ls --color=auto -Fh'
alias ne='emacs -nw'
alias j='jobs'
alias h='history'
alias setenv=export
alias unsetenv=unset

# Completion
[ -f /etc/bash_completion ] && ! shopt -oq posix && . /etc/bash_completion

JOBS=$(jobs | wc -l)
[ $JOBS -eq 0 ] && JCOLOR="\e[1;32m"
[ $JOBS -eq 1 ] && JCOLOR="\e[1;33m"
[ $JOBS -gt 1 ] && JCOLOR="\e[1;31m"
if [ `id -u` -eq 0 ] ; then
    export PS1="\e[1;31m\u@\h $JCOLOR$JOBS \e[1;34m\w \$\e[0m "
elif [ -z "`pwd | egrep "^$HOME"`" ] ; then
    export PS1="\e[1;33m\u@\h $JCOLOR$JOBS \e[1;34m\w \$\e[0m "
else
    export PS1="\e[1;32m\u@\h $JCOLOR$JOBS \e[1;34m\w \$\e[0m "
fi

# EOF

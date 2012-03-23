#!/bin/bash
#
# bash.bashrc -- bash global configuration
# Copyright (C) 2009-2012  Alan SCHNEIDER
#                          <shk.schneider[at]gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY.
# This is free software, and you are welcome to redistribute it
# under certain conditions.
#

# /etc/bash.bashrc r3

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Preferences
shopt -s hostcomplete
shopt -s cdspell
shopt -s histappend
shopt -s checkwinsize
shopt -s dotglob
shopt -s checkhash
export HISTCONTROL=ignoredups

# umask
umask 022

# Path
[ -d $HOME/bin ] && PATH="$HOME/bin:$PATH"
PATH=$(echo $(env | egrep 'PATH=' | cut -d'=' -f2 | tr ":" "\n" | uniq | tr "\n" ":" | sed -r 's/:$//'))

# Aliases
# Try not to set aliases with options here
alias setenv=export
alias unsetenv=unset

# Completion
[ -f /etc/bash_completion ] && ! shopt -oq posix && . /etc/bash_completion

# Command not found
command_not_found_handle() { echo "bash: command not found: \`$1'"; }

function __ps1() {
    EXIT=$?
    if [ $EXIT -eq 0 ] ; then
        EXIT="\e[1;32m$EXIT"
    elif [ $EXIT -eq 148 ] ; then
        EXIT="\e[1;33m$EXIT"
    else
        EXIT="\e[1;31m$EXIT"
    fi
    JOBS=$(jobs | wc -l)
    [ $JOBS -eq 0 ] && JCOLOR="\e[1;32m"
    [ $JOBS -eq 1 ] && JCOLOR="\e[1;33m"
    [ $JOBS -gt 1 ] && JCOLOR="\e[1;31m"
    if [ $(id -u) -eq 0 ] ; then
        export PS1="$EXIT \e[1;31m\u@\h $JCOLOR$JOBS \e[1;34m\w \$\e[0m "
    elif [ -z "$(pwd | egrep "^$HOME")" ] ; then
        export PS1="$EXIT \e[1;33m\u@\h $JCOLOR$JOBS \e[1;34m\w \$\e[0m "
    else
        export PS1="$EXIT \e[1;32m\u@\h $JCOLOR$JOBS \e[1;34m\w \$\e[0m "
    fi
}

PROMPT_COMMAND=__ps1

# EOF

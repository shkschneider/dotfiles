#!/bin/bash
#
# dot.bashrc -- bash configuration
# Copyright (C) 2009-2012  Alan "Shtark" SCHNEIDER
#                          <shk.schneider[at]gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY.
# This is free software, and you are welcome to redistribute it
# under certain conditions.
#

# ~/.bashrc r10

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Preferences
shopt -s hostcomplete
shopt -s cdspell
shopt -s histappend
shopt -s checkwinsize
shopt -s dotglob
export HISTCONTROL=ignoredups
export PAGER=most
export EDITOR=nano

# Prompt
export PS1="\u@\h $(jobs | wc -l) \w \$ "

# Path
[ -d ~/bin ] && PATH=~/bin:"$PATH"

# Aliases
# Try not to set aliases on commands that could be used in scripts!
alias ls='ls --color=auto -Fh'
alias ne='emacs -nw'
alias j='jobs'
alias h='history'
alias setenv=export
alias unsetenv=unset
# The following are not dangerous
alias cp='cp -vr'
alias mkdir='mkdir -pv'
alias scp='scp -r'
alias wget="wget --no-check-certificate"
alias curl="curl -s"
alias bc="bc -q"
alias rm='rm -v'
alias ..="cd .."

# Completion
[ -f /etc/bash_completion ] && ! shopt -oq posix && . /etc/bash_completion

# Many more
FILES=$(shopt -s nullglob ; echo ~/.bashrc_*)
for FILE in $FILES ; do
    source $FILE
done

# EOF

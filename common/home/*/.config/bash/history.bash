#!/usr/bin/env bash
# ~/.config/bash/history.bash

shopt -s histappend # append instead of overwriting
shopt -s cmdhist # multi-line to single-line

export HISTFILE="$HOME/.config/bash/.history"
export HISTSIZE=1000
export HISTFILESIZE=10000
export HISTCONTROL="erasedups:ignoreboth" #ignoredups,ignorespace
export HISTIGNORE="&:test;[ ]*:exit:cd;ls:pwd;bg:fg:history:clear" # ignore
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S ' # prefix

case $OSTYPE in
    darwin*)
        export SHELL_SESSION_HISTORY=0
        ;;
esac

# EOF

#!/usr/bin/env bash

# https://github.com/mrzool/bash-sensible

unset MAILCHECK
unset -f command_not_found_handle

set -o noclobber # >| to force
shopt -s checkwinsize
PROMPT_DIRTRIM=3
shopt -s globstar 2> /dev/null # recursive globbing **
shopt -s nocaseglob # case-insensitive globbing

bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind "set show-all-if-ambiguous on"
bind "set mark-symlinked-directories on"

shopt -s histappend # append instead of overwriting
shopt -s cmdhist # multi-line to single-line
PROMPT_COMMAND='history -a' # record when issued
HISTSIZE=1000
HISTFILESIZE=10000
HISTCONTROL="erasedups:ignoreboth" # avoid duplicates
export HISTIGNORE="&:test;[ ]*:exit:ls:bg:fg:history:clear" # ignore
HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S ' # prefix

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

#!/usr/bin/env sh
# /etc/profile.d/environment.sh ~/.config/profile.d/environment.sh

TERM=xterm-256color #xterm-color xterm linux
export TERM

# LANGUAGE > LC_ALL > LANG
LC_ALL=C.UTF-8
export LC_ALL

# VISUAL > EDITOR
VISUAL="$(command -v emacs || command -v micro || command -v nano || echo 'vim -y')"
export VISUAL
EDITOR="$VISUAL"
export EDITOR

PAGER='less -R'
export PAGER
MANPAGER="$PAGER"
export MANPAGER
if command -v git >/dev/null ; then
    GIT_PAGER="$PAGER"
    export GIT_PAGER
fi

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

# https://geoff.greer.fm/lscolors/
LSCOLORS="exfxcxdxbxegedabagacad"
export LSCOLORS
LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
export LS_COLORS

# EOF

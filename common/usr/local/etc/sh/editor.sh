#!/bin/sh
# /usr/local/etc/sh/editor.sh ~/.config/sh/editor.sh

command -v nano >/dev/null && alias nano='nano -_'
command -v emacs >/dev/null && alias emacs='emacs -nw'
command -v micro >/dev/null && alias micro='MICRO_TRUECOLOR=1 micro'
if command -v vim >/dev/null ; then
    alias vim='vim -y'
    if ! command -v vi >/dev/null ; then
        alias vi='vim'
    fi
fi

# VISUAL > EDITOR

VISUAL="$(command -v emacs || command -v micro || command -v vim)"
export VISUAL

EDITOR="$(command -v micro || command -v nano || command -v vi)"
export EDITOR

if [ -n "$VISUAL" ] ; then
    alias e="$VISUAL"
elif [ -n "$EDITOR" ] ; then
    alias e="$EDITOR"
fi

# EOF

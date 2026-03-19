#!/usr/bin/env bash
# ~/.config/bash/editor.sh

set -o emacs

return 0

if command -v emacs >/dev/null ; then
    set -o emacs
elif command -v vim >/dev/null || command -v vi >/dev/null ; then
    set -o vi
    #bind '"\C-l": clear-screen'
fi

# EOF

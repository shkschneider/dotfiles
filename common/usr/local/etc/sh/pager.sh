#!/bin/sh
# /usr/local/etc/sh/pager.sh ~/.config/sh/pager.sh

if command -v bat >/dev/null ; then
    PAGER='bat -plman'
elif command -v less >/dev/null ; then
    PAGER='less -eFKnqRs --incsearch --use-color'
elif command -v more >/dev/null ; then
    PAGER='more -des'
else
    PAGER='cat'
fi

if command -v man >/dev/null ; then
    MANPAGER="$PAGER"
    export MANPAGER
fi

if command -v git >/dev/null ; then
    GIT_PAGER="$PAGER"
    export GIT_PAGER
fi

# EOF

#!/usr/bin/env sh
# /etc/profile.d/pager.sh ~/.config/profile.d/pager.sh

PAGER='less -R'
export PAGER

MANPAGER="$PAGER"
export MANPAGER

if command -v git >/dev/null ; then
    GIT_PAGER="$PAGER"
    export GIT_PAGER
fi

# EOF

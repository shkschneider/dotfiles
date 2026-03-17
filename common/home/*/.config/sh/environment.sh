#!/usr/bin/env sh
# ~/.config/sh/environment.sh

[ -n "$LANG" ] || eval "$(locale)"
[ -n "$LANG" ] || LANG='en_us.UTF-8'

USER="${USER:-$(id --user --name)}"
export USER
HOST="${HOST:-$(uname --nodename)}"
export HOST

if command -v most >/dev/null ; then
    export PAGER="most -ds"
    export MANPAGER="$PAGER"
elif command -v less >/dev/null ; then
    export PAGER="less --squeeze-blank-lines --incsearch"
    # https://github.com/sharkdp/bat/issues/2593#issuecomment-1637234733
    export MANROFFOPT="-c"
    export MANPAGER="$PAGER -R --use-color -Dd+r -Du+b"
elif command -v more >/dev/null ; then
    export PAGER="more --silent --squeeze"
    export MANPAGER="$PAGER"
fi
if command -v bat >/dev/null ; then
    export MANPAGER="bat -plman"
fi
# shellcheck disable=SC2139
alias p="$PAGER"

#COLORTERM="truecolor "
TERM="${TERM:-xterm-256color}"
export TERM
if command -v dircolors >/dev/null ; then
    for f in "$HOME/.dir_colors" "$HOME/.config/dircolors" "/etc/dircolors" ; do
        if [ -f "$f" ] ; then
            eval "$(dircolors -- "$f")" && break
        fi
    done
fi

# EOF

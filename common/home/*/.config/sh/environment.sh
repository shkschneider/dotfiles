# ~/.config/sh/environment.sh

test -n "$LANG" || eval "$(locale)"
test -n "$LANG" || LANG='en_us.UTF-8'
#(( $(umask) != 0 )) || umask 022

export USER="${USER:-$(id --user --name)}"
export HOST="${HOST:-$(uname --nodename)}"

if [[ -n "$VISUAL" ]] ; then
    alias e="$VISUAL"
elif [[ -n "$EDITOR" ]] ; then
    alias e="$EDITOR"
fi

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
alias p="$PAGER"

COLORTERM="truecolor "
export TERM=${TERM:-"xterm-256color"}
if command -v dircolors >/dev/null ; then
    for f in "$HOME/.dir_colors" "$HOME/.config/dircolors" "/etc/dircolors" ; do
        if [[ -f "$f" ]] ; then
            eval "$(dircolors $f)" && break
        fi
    done
fi

# EOF

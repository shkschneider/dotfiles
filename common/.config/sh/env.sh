# ~/.config/sh/env.sh

test -n "$LANG" || eval "$(locale)"
test -n "$LANG" || LANG='en_us.UTF-8'
test $(umask) -eq 0 && umask 022
COLORTERM="truecolor "

#:userhost

export USER="${USER:-$(id --user --name)}"
export HOST="${HOST:-$(uname --nodename)}"

#:editor

export EDITOR=${EDITOR:-$(which micro 2>/dev/null || which nano 2>/dev/null)}
alias e="$EDITOR"

#:pager

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
alias p="$PAGER"

#:colors

export TERM=${TERM:-"xterm-256color"}

if command -v dircolors >/dev/null ; then
    for f in $HOME/.dir_colors $HOME/.config/dircolors /etc/dircolors ; do
        if test -f "$f" ; then
            eval "$(dircolors $f)" && break
        fi
    done
fi

#:session

if [[ "$XDG_SESSION_TYPE" == "wayland" ]] ; then
    export MOZ_ENABLE_WAYLAND=1
    export SDL_VIDEODRIVER=wayland
    export QT_QPA_PLATFORMTHEME=qt5ct
    export QT_QPA_PLATFORM=wayland
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export _JAVA_AWT_WM_NONREPARENTING=1
fi

#:prompt

export PS1="$(whoami)@$(hostname -s)> "

# EOF

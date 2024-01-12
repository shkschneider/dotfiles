# ~/.config/sh/env.sh

test -n "$LANG" || eval "$(locale)"
test -n "$LANG" || LANG='en_us.UTF-8'
test $(umask) -eq 0 && umask 022
COLORTERM="truecolor "

#:user

for user in $(echo $USER) $(id --user --name) $(echo $LOGNAME) ; do
    export USER="$user"
    export LOGNAME="${LOGNAME:-$USER}"
    break
done

#:host

export HOST=${HOST:-$(
    cat /proc/sys/kernel/hostname 2>/dev/null \
        || echo $HOSTNAME \
        || hostnamectl hostname 2>/dev/null \
        || uname --nodename
)}

#:editor

export EDITOR=${EDITOR:-$(
    which micro 2>/dev/null \
    || which nano 2>/dev/null
)}
alias e="$EDITOR"

#:pager

for pager in less more most pg ; do
    pager=$(which $pager 2>/dev/null)
    if test -n "$pager" ; then
        export PAGER="$pager"
        for opt in 'QUIT-AT-EOF' 'exit-on-eof' ; do
            test "$($pager --help 2>&1 | grep -c -- "--$opt")" != "0" && \
                export PAGER="$PAGER --$opt"
        done
        break
    fi
done
alias p="$PAGER"

#:ls

if command -v dircolors >/dev/null ; then
    for f in $HOME/.dir_colors $HOME/.config/dircolors /etc/dircolors ; do
        if test -f "$f" ; then
            eval "$(dircolors $f)" && break
        fi
    done
fi

#:term
export TERM=${TERM:-"xterm-256color"}

test -z "$MANPAGER" && test "$PAGER" == "less" && {
    # https://github.com/sharkdp/bat/issues/2593#issuecomment-1637234733
    export MANROFFOPT="-c"
    export MANPAGER="less -R --use-color -Dd+r -Du+b"
}

command -v fzf >/dev/null && {
    command -v fd >/dev/null && {
        export FZF_DEFAULT_COMMAND="fd --unrestricted"
    } || {
        export FZF_DEFAULT_COMMAND="find"
    }
    #export FZF_DEFAULT_OPTS="--height 75% --preview-window up,25% $FZF_DEFAULT_OPTS"
}

command -v go >/dev/null && GOPATH="${GOPATH:-$HOME/.go}"

if [[ "$XDG_SESSION_TYPE" == "wayland" ]] ; then
    export MOZ_ENABLE_WAYLAND=1
    export SDL_VIDEODRIVER=wayland
    export QT_QPA_PLATFORMTHEME=qt5ct
    export QT_QPA_PLATFORM=wayland
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export _JAVA_AWT_WM_NONREPARENTING=1
fi

# EOF

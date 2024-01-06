# ~/.config/sh/env.sh

test -n "$LANG" || eval "$(locale)"
test -n "$LANG" || LANG='en_us.UTF-8'
test $(umask) -eq 0 && umask 022

#:user

for user in $(echo $USER) $(id --user --name) $(echo $LOGNAME) ; do
    export USER="$user"
    export LOGNAME="$user"
    break
done

#:host

for host in $(cat /proc/sys/kernel/hostname 2>/dev/null) $(echo $HOSTNAME) $(hostnamectl hostname 2>/dev/null) $(uname --nodename) ; do
    export HOST="$host"
    break
done

#:editor

for editor in $(command -v micro) $(command -v nano) ; do
    export EDITOR="$editor"
    break
done
alias e="$EDITOR"

#:pager

for pager in $(command -v most) $(command -v less) $(command -v more) $(command -v pg) ; do
    export PAGER="$pager"
    for opt in 'QUIT-AT-EOF' 'exit-on-eof' ; do
        test "$($pager --help 2>&1 | grep -c -- "--$opt")" != "0" && \
            export PAGER="$PAGER --$opt"
    done
    break
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
test -n "$TERM" || export TERM="xterm-256color"

#:editor
test -z "$EDITOR" && command -v micro >/dev/null && export EDITOR="micro"
test -z "$EDITOR" && command -v nano >/dev/null && export EDITOR="nano"

#:pager
test -z "$PAGER" && command -v less >/dev/null && export PAGER="less -e"
test -z "$PAGER" && command -v more >/dev/null && export PAGER="more -e"
test -z "$PAGER" && command -v most >/dev/null && export PAGER="most"

test -z "$MANPAGER" && command -v bat >/dev/null && {
    # https://github.com/sharkdp/bat/issues/2668
    export MANROFFOPT=""
    export MANPAGER="sh -c \"sed -e 's/\x1b\[[0-9;]*m//g' | bat -l man\""
}
test -z "$MANPAGER" && command -v less >/dev/null && {
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
    export FZF_DEFAULT_OPTS="--height 75% --preview-window up,25% $FZF_DEFAULT_OPTS"
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

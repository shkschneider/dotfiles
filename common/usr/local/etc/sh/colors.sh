#!/bin/sh
# /usr/local/etc/sh/colors.sh ~/.config/sh/colors.sh

TERM=xterm-256color
export TERM

COLORTERM=truecolor
export COLORTERM

unset NO_COLOR

if command -v dircolors >/dev/null ; then
    for f in "$HOME/.dir_colors" "$HOME/.config/dircolors" "/etc/dircolors" ; do
        if [ -r "$f" ] ; then
            echo dircolors $f
            eval "$(dircolors -- "$f")" && return 0
        fi
        unset f
    done
    eval "$(dircolors -b)"
fi

# EOF

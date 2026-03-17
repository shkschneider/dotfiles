#!/usr/bin/env sh
# /etc/profile.d/colors.sh ~/.config/profile.d/colors.sh

NO_COLOR=0
export NO_COLOR

if command -v dircolors >/dev/null ; then
    eval "$(dircolors -b ~/.dircolors 2>/dev/null)" || eval "$(dircolors -b)"
fi

# EOF

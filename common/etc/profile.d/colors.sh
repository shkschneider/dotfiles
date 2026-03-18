#!/usr/bin/env sh
# /etc/profile.d/colors.sh ~/.config/profile.d/colors.sh

TERM=xterm-256color
export TERM

NO_COLOR=0
export NO_COLOR

if command -v dircolors >/dev/null ; then
    eval "$(dircolors -b ~/.dircolors 2>/dev/null)" || eval "$(dircolors -b)"
fi

## https://geoff.greer.fm/lscolors/
#LSCOLORS="exfxcxdxbxegedabagacad"
#export LSCOLORS
#LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
#export LS_COLORS

# EOF

#!/usr/bin/env bash
# ~/.bashrc

if [[ -r "$HOME/.shrc" ]] ; then
    source "$HOME/.shrc"
elif [[ -r "/usr/local/etc/sh/rc" ]] ; then
    source "/usr/local/etc/sh/rc"
fi

if [[ -r "$HOME/.config/bash/rc" ]] ; then
    source "$HOME/.config/bash/rc"
elif [[ -r "/usr/local/etc/bash/rc" ]] ; then
    source "/usr/local/etc/bash/rc"
fi

true # $?

# EOF

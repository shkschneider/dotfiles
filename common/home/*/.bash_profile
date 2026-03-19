#!/usr/bin/env bash
# ~/.bash_profile

shopt login_shell >/dev/null || return 0

if [[ -r "$HOME/.profile" ]] ; then
    source "$HOME/.profile"
elif [[ -r "/usr/local/etc/profile" ]] ; then
    source "/usr/local/etc/profile"
fi

if [[ -r "$HOME/.bashrc" ]] ; then
    source "$HOME/.bashrc"
elif [[ -r "/usr/local/etc/bash/rc" ]] ; then
    source "/usr/local/etc/bash/rc"
fi

true # $?

# EOF

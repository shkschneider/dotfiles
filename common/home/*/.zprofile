#!/usr/bin/env zsh
# ~/.zprofile

[[ -o login ]] || return 0

if [[ -r "$HOME/.profile" ]] ; then
    source "$HOME/.profile"
elif [[ -r "/usr/local/etc/profile" ]] ; then
    source "/usr/local/etc/profile"
fi

# automatic ~/.zshrc

true # $?

# EOF

#!/bin/sh
# /usr/local/etc/profile.d/prompt.sh ~/.config/profile.d/prompt.sh

PS1="$(id -un)@$(uname -n)> "
export PS1

# EOF

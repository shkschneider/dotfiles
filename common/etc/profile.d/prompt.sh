#!/usr/bin/env sh
# /etc/profile.d/prompt.sh ~/.config/profile.d/prompt.sh

echo profile.d/prompt

PS1="$(id -un)@$(uname -n)> "
export PS1

# EOF

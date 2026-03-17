#!/usr/bin/env sh
# /etc/profile.d/paths.sh ~/.config/profile.d/paths.sh

[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.local/sbin" ] && PATH="$HOME/.local/sbin:$PATH"
export PATH

# EOF

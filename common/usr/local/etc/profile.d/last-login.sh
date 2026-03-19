#!/bin/sh
# /usr/local/etc/profile.d/last-login.sh ~/.config/profile.d/last-login.sh

[ -f "$HOME/.hushlogin" ] && return

USER="${USER:-$(id -un)}"
HOST="${HOST:-$(uname -n)}"
last -1 "$USER" --time-format iso 2>/dev/null | \
    head -1 2>/dev/null | \
    awk '{print $3}' 2>/dev/null | \
    xargs -I{} printf '%s last-login %s\n' "$USER@$HOST" "{}" 2>/dev/null \
    ;

# EOF

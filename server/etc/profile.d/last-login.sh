#!/usr/bin/env sh
# /etc/profile.d/last-login.sh

USER="${USER:-$(whoami)}"
last -1 "$USER" --time-format iso 2>/dev/null | \
    head -1 2>/dev/null | \
    awk '{print $3}' 2>/dev/null | \
    xargs -I{} printf '%s last-login %s\n' "$USER" "{}" 2>/dev/null \
    ;

# EOF

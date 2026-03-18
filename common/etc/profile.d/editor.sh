#!/usr/bin/env sh
# /etc/profile.d/editor.sh ~/.config/profile.d/editor.sh

# VISUAL > EDITOR

VISUAL="$(command -v emacs || command -v micro || command -v nano || echo 'vim -y')"
export VISUAL

EDITOR="$VISUAL"
export EDITOR

# EOF

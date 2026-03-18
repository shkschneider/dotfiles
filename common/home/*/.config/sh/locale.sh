#!/usr/bin/env sh
# ~/.config/sh/locale.sh

[ -n "$LC_ALL" ] || LC_ALL='C.utf8'

[ -n "$LANG" ] || LANG="$(locale -a | grep utf8 | tail -1)"
[ -n "$LANG" ] || LANG='en_us.utf8'
export LANG

# EOF

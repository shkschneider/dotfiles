#!/bin/sh
# /usr/local/etc/profile.d/locale.sh ~/.config/profile.d/locale.sh

[ -r /etc/locale.conf ] && . /etc/locale.conf
[ -r /usr/local/etc/locale.conf ] && . /usr/local/etc/locale.conf
[ -f "$HOME/.config/locale.conf" ] && . "$HOME/.config/locale.conf"

[ -n "$LC_ALL" ] || LC_ALL='C.utf8'

[ -n "$LANG" ] || LANG="$(locale -a | grep utf8 | tail -1)"
[ -n "$LANG" ] || LANG='en_us.utf8'
export LANG

# EOF

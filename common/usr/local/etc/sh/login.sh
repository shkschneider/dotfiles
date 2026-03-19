#!/bin/sh
# /usr/local/etc/sh/login.sh ~/.config/sh/login.sh

[ -f "$HOME/.hushlogin" ] && return

if [ "$(id -u)" -eq 0 ] ; then
    # shellcheck disable=SC2021
    printf '\033[31m%s ' "$(uname -n | tr '[a-z]' '[A-Z]')"
    printf '\033[32m%s ' "$(grep 'NAME=' /etc/os-release | head -1 | cut -d\" -f2 | sed -e 's/Linux//' | xargs)"
    printf '\033[33m%s ' "$(uname -s)"
    printf '\033[34m%s ' "$(uname -m)"
    printf '\033[35m%s ' "$(ip -4 -br a | grep -v '@' | grep 'UP' | head -1 | tr -s ' ' | cut -d' ' -f3 | cut -d'/' -f1)"
    printf '\033[36m%s ' "$(uptime -p | sed 's/up // ; s/ days\?,/d/ ; s/ hours\?,/h/ ; s/ minutes/m/' | tr -d ' ')"
    printf '\033[37m%s ' "$(last reboot --time-format iso | head -1 | tr -s ' ' | cut -d' ' -f5)"
else
    for i in 1 2 3 4 5 6 7 0 ; do
        printf '\033[3%dm#! ' "$i"
    done
fi
printf '\033[0m\n'

# EOF

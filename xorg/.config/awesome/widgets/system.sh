#!/usr/bin/env bash

# TODO icon could be ~/.config/awesome/icons/avatar

if [ -r /etc/os-release ] ; then
    grep ^NAME /etc/os-release 2>/dev/null | cut -d'=' -f2 | tr -d '"'
    find /usr/share/icons -type f -name $(grep ^LOGO /etc/os-release | cut -d'=' -f2)".*" | sort --reverse | head -1
else
    echo
    echo
fi

dnf --quiet list --updates --cacheonly | sed '1d' | awk '{print $1}' | cut -d'.' -f1

# EOF

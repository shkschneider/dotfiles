#!/usr/bin/env bash

command -v dnf >/dev/null || exit 1

updates=$(dnf --quiet list --updates --cacheonly | sed '1d' | awk '{print $1}' | cut -d'.' -f1)
n=$(echo -n $updates | wc --lines)
if [[ $n -eq 0 ]] ; then
    echo "0"
    echo "$(grep ^NAME /etc/os-release | head -1 | cut -d= -f2 | tr -d '"') $(grep ^VERSION /etc/os-release | head -1 | cut -d= -f2 | tr -d '"')"
    echo "up-to-date"
else
    echo $n
    echo $(echo $updates | tr "\n" "\t")
    echo "out-of-date"
fi

# EOF

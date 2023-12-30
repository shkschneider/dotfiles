#!/usr/bin/env bash

command -v df >/dev/null || exit 1

root=$(df --local --human "/" | sed '1d' | awk '{print $5}' | tr -d '%')
echo "$root"

n=0
while read device ; do
    [[ n -gt 0 ]] && echo -ne "\r"
    echo -ne "$device"
    n=$((n + 1))
done < <(blkid | cut -d':' -f1 | xargs \
    df --local --human | sed '1d' | awk '{print $6,$5,$2}')
echo

if [[ $root -gt 75 ]] ; then
    echo "critical"
elif [[ $root -gt 50 ]] ; then
    echo "warning"
fi

# EOF

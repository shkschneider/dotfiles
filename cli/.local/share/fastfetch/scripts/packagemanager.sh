#!/usr/bin/env bash

for pm in apk dpkg emerge eopkg nix pacman rpm xbps-install opkg ; do
    if command -v $pm >/dev/null ; then
        echo $(echo $pm | cut -d'-' -f1)" "$($pm --version 2>/dev/null | grep -oP '[0-9]+(\.[0-9]+)+' | head -1)
        exit 0
    fi
done
echo "?"
exit 1

# EOF

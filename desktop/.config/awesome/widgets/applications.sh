#!/usr/bin/env bash

function _application() {
    local terminal=$(grep ^Terminal= "$1" | cut -d'=' -f2)
    [ "$terminal" == "false" ] || return
    local category=$(grep ^Categories= "$1" | head -1 | cut -d'=' -f2 | sed -r 's/^[A-Z\-]+;/;/g' | sed -r 's/;[A-Z\-]+;//g' | sed 's/^;//g' | cut -d';' -f1)
    local name=$(grep ^Name= "$1" | head -1 | cut -d'=' -f2)
    local exec=$(grep ^Exec= "$1" | head -1 | cut -d'=' -f2 | sed -r 's/ %.+$//g')
    # /usr/share/icons/hicolor/24x24/apps/
    [ -n "$category" -a -n "$name" -a -n "$exec" ] || return
    echo "$category;$name;$exec"
}

while read desktop ; do
    _application $desktop
done < <(find /usr/share/applications -type f -name "*.desktop")
while read desktop ; do
    _application $desktop
done < <(find $HOME/.local/share/applications -type f -name "*.desktop")

# EOF

#!/usr/bin/env bash

# https://unix.stackexchange.com/q/269077
function _hex256() {
    hex=${1#"#"}
    r=$(printf '0x%0.2s' "$hex")
    g=$(printf '0x%0.2s' ${hex#??})
    b=$(printf '0x%0.2s' ${hex#????})
    printf '%03d' "$(( (r<75?0:(r-35)/40)*6*6 + (g<75?0:(g-35)/40)*6 + (b<75?0:(b-35)/40) + 16 ))"
}

#test -d ~/.dot/theming/.config/colorschemes && dir=~/.dot/theming/.config/colorschemes || dir=${0%/*}
dir=$(readlink -f ${0%/*})/.config/colorschemes

if test $# -eq 0 ; then
    while read cs ; do
        cs="${cs##*/}"
        sh "$0" "${cs%.*}"
    done < <(find $dir -type f -name "*.cs" | sort)
    exit 1
else
    for cs in $@ ; do
        source "$dir/$cs.cs" || continue
        printf "\e[48;5;%sm\e[38;5;%sm%36s\e[0m" $(_hex256 "$background") $(_hex256 "$foreground") "$cs"
        for c in $black $red $green $yellow $blue $magenta $cyan $white ; do
            printf "\e[48;5;%sm\e[38;5;%sm%s\e[0m" $(_hex256 "$background") $(_hex256 "$c") "$c"
        done
        tput sgr0
        echo
    done
fi

exit 0

# EOF

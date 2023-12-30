#!/usr/bin/env bash

battery() {
    local n=${1}
    local b="/sys/class/power_supply/BAT${n}"
    if [ -d "$b" ] ; then
        local capacity=$(cat "$b/capacity" 2>/dev/null | tr -d '\n')
        local status=$(cat "$b/status" 2>/dev/null | tr '[A-Z]' '[a-z]' | tr -d '\n')
        [ "$capacity" == "100" ] && status="full"
        echo "$n $capacity $status"
    fi
}

if [ $# -gt 0 ] ; then
    n=$(battery "${1}")
    if [ ${#n} -gt 0 ] ; then
        echo $n
    fi
else
    for n in {0..9} ; do
        n=$(battery "${n}")
        if [ ${#n} -gt 0 ] ; then
            echo $n
        fi
    done
    exit 1
fi

# EOF

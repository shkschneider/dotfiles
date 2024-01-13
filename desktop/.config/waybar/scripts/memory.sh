#!/usr/bin/env bash

mem_percentage=$(cat /proc/meminfo | sed -n '1p;3p' | awk '{print $2}' | tr "\n" " " | awk '{l=$2*100/$1} END {print l}' | cut -d'.' -f1)
mem_free=$(echo "$(cat /proc/meminfo | grep '^MemFree' | awk '{print $2}')*1024" | bc -ql)
mem_available=$(echo "$(cat /proc/meminfo | grep '^MemAvailable' | awk '{print $2}')*1024" | bc -ql)
mem_total=$(echo "$(cat /proc/meminfo | grep '^MemTotal' | awk '{print $2}')*1024" | bc -ql)
mem_used=$(echo $((mem_total - mem_free - mem_available)) | numfmt --to=iec --suffix=B --format="%.2f")

echo "${mem_percentage:-'0'}"

echo "${mem_used:-'0'} / $(numfmt --to=iec --suffix=B --format="%.2f" ${mem_total})"

if [[ $mem_percentage -gt 75 ]] ; then
    echo "critical"
elif [[ $mem_percentage -gt 50 ]] ; then
    echo "warning"
fi

# EOF

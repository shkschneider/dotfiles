#!/usr/bin/env bash

cpu_n=$(cat /proc/cpuinfo | grep '^processor' | wc -l)
cpu_percentage=$(($(grep 'cpu ' /proc/stat | awk '{l=($2+$4)*100/($2+$4+$5)} END {print l}' | cut -d'.' -f1)))
cpu_loadavg=$(cat /proc/loadavg | cut -c-14)

echo "${cpu_percentage:-'0'}"

echo "${cpu_n:-'0'}x ${cpu_loadavg:-'0'}"

if [[ $cpu_percentage -gt 75 ]] ; then
    echo "critical"
elif [[ $cpu_percentage -gt 50 ]] ; then
    echo "warning"
fi

# EOF

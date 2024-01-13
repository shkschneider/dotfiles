#!/usr/bin/env bash

cpu_n=$(cat /proc/cpuinfo | grep '^processor' | wc -l)
cpu_percentage=$(grep 'cpu ' /proc/stat | awk '{l=($2+$4)*100/($2+$4+$5)} END {print l}' | cut -d'.' -f1)
cpu_loadavg=$(cat /proc/loadavg | cut -c-14)

mem_percentage=$(cat /proc/meminfo | sed -n '1p;3p' | awk '{print $2}' | tr "\n" " " | awk '{l=$2*100/$1} END {print l}' | cut -d'.' -f1)
mem_total=$(echo "$(cat /proc/meminfo | grep '^MemTotal' | awk '{print $2}')*1024" | bc -ql)

echo "${cpu_percentage:-'0'} ${cpu_n:-'0'} ${cpu_loadavg:-'0'}"
echo "${mem_percentage:-'0'} ${mem_total:-'0'}"

# EOF

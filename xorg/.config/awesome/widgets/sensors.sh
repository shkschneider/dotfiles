#!/usr/bin/env bash

count=0
total=0
for i in $(sensors -u | grep input | awk '{print $NF}') ; do
    total=$(echo "$total+$i" | bc -ql)
    ((count++))
done
printf "%0.2f" $(echo "$total/$count" | bc -ql)

# EOF

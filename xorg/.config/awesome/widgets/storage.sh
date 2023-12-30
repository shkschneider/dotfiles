#!/usr/bin/env bash

if [ $# -gt 0 ] ; then
    cat /etc/fstab | egrep -v '^#' | awk '{print $2}' | sed '/^$/d' | grep -v '/boot' | xargs \
        df --human | grep '^/' | awk '{print $6,$5,$2}' | tr -d '%'
else
    df --human $@ | grep '^/' | awk '{print $6,$5,$2}' | tr -d '%'
fi

# EOF

#!/usr/bin/env bash

_interface() {
    interface="$1"
    [ -n "$interface" ] || return
    type=$(nmcli device status | grep "^$interface" | awk '{print $2}')
    status=$(ip --brief addr | grep "^$interface" | awk '{print $2}' | tr '[A-Z]' '[a-z]')
    address=$(ip --brief addr | grep "^$interface" | awk '{print $3}')
    received=$(cat "/sys/class/net/$interface/statistics/rx_bytes" 2>/dev/null)
    sent=$(cat "/sys/class/net/$interface/statistics/tx_bytes" 2>/dev/null)
    name=$(nmcli --terse connection show | grep ":$interface\$" | cut -d':' -f1)
    echo "$interface ${type:-'?'} ${status:-'?'} ${address:-'?'} ${received:-0} ${sent:-0} \"$name\""
}

# online=$(nmcli connection show --active | sed '1d' | wc -l)
# if [ $online -gt 0 ] ; then
for interface in $(nmcli connection | sed '1d' | awk '{print $NF}') ; do
    _interface "$interface"
done

# EOF

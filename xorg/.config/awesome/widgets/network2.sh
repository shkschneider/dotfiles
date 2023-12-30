#!/usr/bin/env bash

bluetoothctl show | head -1 | awk '{print $2}'
bluetoothctl show | grep 'Name' | awk '{print $2}'
#bluetoothctl show | grep 'PowerState' | awk '{print $2}'
bluetoothctl devices

# EOF

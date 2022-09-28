#!/usr/bin/env sh

# disable Display Power Management Signaling and prevent screen from blanking
xset s off -dpms
# should preserve setting even after force off for example
xset dpms 0 0 0

# EOF

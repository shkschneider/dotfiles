#!/bin/bash
#
# dot.bash_logout -- bash logout global configuration
# Copyright (C) 2012  Alan SCHNEIDER
#                     <shk.schneider[at]gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY.
# This is free software, and you are welcome to redistribute it
# under certain conditions.
#

# /etc/skel/.bash_logout r0

# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

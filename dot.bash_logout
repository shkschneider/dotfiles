#!/bin/bash
#
# dot.bash_logout -- bash configuration for logout
# Copyright (C) 2012  Alan SCHNEIDER
#                     <shk.schneider[at]gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY.
# This is free software, and you are welcome to redistribute it
# under certain conditions.
#

# ~/.bash_logout r3

[ "$SHLVL" = 1 ] && [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q

history -c
rm -f $HOME/.*_history

# EOF

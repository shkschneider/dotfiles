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

# ~/.bash_logout r0

history -c
rm -f "$HOME/.bash_history"

rm -f "$HOME/.mysql_history"

# EOF

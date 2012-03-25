#!/bin/bash
#
# dot.bashrc -- bash configuration
# Copyright (C) 2009-2012  Alan SCHNEIDER
#                          <shk.schneider[at]gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY.
# This is free software, and you are welcome to redistribute it
# under certain conditions.
#

# ~/.bashrc r12

# Preferences
export PAGER=most
export EDITOR=nano

# Many more
FILES=$(shopt -s nullglob ; echo $HOME/.bashrc_*)
for FILE in $FILES ; do
    source $FILE
done

# EOF

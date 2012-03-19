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

# ~/.bashrc r11

# Preferences
export HISTCONTROL=ignoredups
export PAGER=most
export EDITOR=nano

# Path
[ -d ~/bin ] && PATH=~/bin:"$PATH"
PATH=$(echo $(env | egrep 'PATH=' | cut -d'=' -f2 | tr ":" "\n" | uniq | tr "\n" ":" | sed -r 's/:$//'))

# Many more
FILES=$(shopt -s nullglob ; echo ~/.bashrc_*)
for FILE in $FILES ; do
    source $FILE
done

# EOF

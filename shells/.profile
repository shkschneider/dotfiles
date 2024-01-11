#!/usr/bin/env sh

eval "$(locale)"
test -n "$LANG" || LANG='en_us.UTF-8'
umask &>/dev/null && umask 022
COLORTERM="truecolor"

for rc in $(find $HOME -name '.profile.*') ; do
    source $rc
done

[[ $- == *i* ]] || return

tput bold ; for i in 1 2 3 4 5 6 7 0 ; do
    tput setaf $i ; printf '#! '
done ; echo ; tput sgr0

# EOF

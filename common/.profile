#!/usr/bin/env sh

eval "$(locale)"
test -n "$LANG" || export LANG='en_US.UTF-8'
umask >/dev/null 2>&1 && umask 022
COLORTERM="truecolor"

find "$HOME" -maxdepth 1 -name '.profile.*' -print | while IFS= read -r rc ; do
    . "$rc"
done

case $- in
    *i*) ;;
    *) return 0 2>/dev/null || exit 0 ;;
esac

tput bold ; for i in 1 2 3 4 5 6 7 0 ; do
    tput setaf $i ; printf '#! '
done ; echo ; tput sgr0

# EOF

#!/bin/sh
cat $0 | sed -n '1,2d;p' >/tmp/cs.$$.c && gcc -Wall -o /tmp/cs.$$ /tmp/cs.$$.c && /tmp/cs.$$ $*; rm -f /tmp/cs.$$*; exit

/*
 * C-Script
 */


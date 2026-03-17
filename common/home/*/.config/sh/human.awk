#!/usr/bin/awk -f

$1 < 1000           { print $1               ; next }
$1 < 1000000        { print $1/1000"k"       ; next }
$1 < 1000000000     { print $1/1000000"M"    ; next }
$1 < 1000000000000  { print $1/1000000000"G" ; next }

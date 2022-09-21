#!/usr/bin/env bash

run() {
  if ! pgrep -f "$1" ; then
    "$@"&
  fi
}

-- run ...

run unclutter -idle 1 -keystroke -root
run picom
--run brave
--run spotify
--run nm-applet

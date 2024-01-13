#!/usr/bin/env bash

function _inxi() {
    if command -v inxi >/dev/null ; then
        # inxi seems to not output errors to stderr
        inxi $@ -c0 | sed -n '2p' | xargs || echo
    else
        echo
    fi
}

_inxi --machine
_inxi --system

# EOF

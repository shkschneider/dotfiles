#!/usr/bin/env bash

command -v git >/dev/null || exit 1

test -d ~/.config/nano || git clone https://github.com/scopatz/nanorc.git ~/.config/nano || exit $?

test -f ~/.nanorc || {
    echo "set linenumbers" > ~/.nanorc
    find ~/.config/nano -type f -name "*.nanorc" | xargs -n1 basename \
        | xargs -I {} echo "include \"~/.config/nano/{}\"" >> ~/.nanorc
}

# EOF

#!/usr/bin/env bash
# ~/.config/bash/prompt.bash

if command -v oh-my-posh >/dev/null ; then

    eval "$(oh-my-posh init bash --config pure)"

elif command -v starship >/dev/null ; then

    if ! test -f "$HOME/.config/starship.toml" ; then
        echo 'add_newline = true' >> ~/.config/starship.toml
        starship preset pure-preset >> ~/.config/starship.toml
    fi
    eval "$(starship init bash)"

elif test -d ~/.bash_it ; then

    export BASH_IT="${BASH_IT:-$HOME/.bash_it}"
    export BASH_IT_THEME="${BASH_IT_THEME:-pure}"
    source "$BASH_IT/bash_it.sh"

fi

# EOF

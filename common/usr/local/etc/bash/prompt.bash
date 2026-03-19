#!/usr/bin/env bash
# /usr/local/etc/bash.bashrc

PROMPT() {
    echo -n "$(tput setaf 7)"
    if (( $(id -u) == 0 )) ; then
        echo -n "$(tput setaf 1)"
    else
        echo -n "$(tput setaf 2)"
    fi
    echo -n "%u"
    if [[ -n "$SSH_TTY$SSH_CLIENT$SSH2_CLIENT" ]] ; then
        echo -n "$(tput setaf 3)@%h"
    fi
    echo -n " $(tput setaf 4)%w"
}

RPROMPT() {
    printf '%s%*s' "$(tput setaf 5)" $COLUMNS '%j'
}

set-prompt() {
    c=$?
    PS1="$(tput bold)$(tput sc)$(RPROMPT)$(tput rc)$(PROMPT)"
    PS1="${PS1//%/\\}"
    # › 0x203a
    # ❯ 0x276f
    (( c )) && c="$(tput setaf 1)!" || c="$(tput setaf 7)›"
    PS1="\n$PS1\n$c$(tput sgr0) "
    export PS1
    PS2=""
    export PS2
}

PROMPT_COMMAND=set-prompt

# EOF

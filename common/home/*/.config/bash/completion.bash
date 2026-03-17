#!/usr/bin/env bash
# ~/.config/bash/completion.bash

if [[ -f /usr/share/bash-completion/bash_completion ]] ; then
    # shellcheck disable=SC1091
    source /usr/share/bash-completion/bash_completion
fi
if [[ -f /etc/bash_completion ]] ; then
    # shellcheck disable=SC1091
    source /etc/bash_completion
fi
if [ -n "$BASH_COMPLETION" ] ; then
    complete -cf sudo
    complete -cf man
fi

command -v jumpy >/dev/null && \
    eval "$(jumpy completions bash)"

shopt -s no_empty_cmd_completion
command_not_found_handle() {
    echo "bash: $1: command not found" >&2
}

# EOF

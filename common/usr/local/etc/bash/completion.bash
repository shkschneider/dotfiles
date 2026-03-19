#!/usr/bin/env bash
# ~/.config/bash/completion.bash

#if [[ -n "$BASH_COMPLETION" ]] ; then
#    complete -cf sudo
#    complete -cf man
#fi

command -v jumpy >/dev/null && \
    eval "$(jumpy completions bash)"

shopt -s no_empty_cmd_completion
command_not_found_handle() {
    echo "bash: $1: command not found" >&2
}

# EOF

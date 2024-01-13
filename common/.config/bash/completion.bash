# ~/.config/bash/completion.bash

[ -f /etc/bash_completion ] \
    && ! shopt -oq posix \
        && source /etc/bash_completion

if [ -n "$BASH_COMPLETION" ] ; then
    complete -cf sudo
    complete -cf man
fi

shopt -s no_empty_cmd_completion

# command-not-found
command_not_found_handle() {
    echo "bash: $1: command not found" >&2
}

# EOF

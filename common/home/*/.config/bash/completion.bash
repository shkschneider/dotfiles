# ~/.config/bash/completion.bash

[[ -f /usr/share/bash-completion/bash_completion ]] && \
    source /usr/share/bash-completion/bash_completion
[[ -f /etc/bash_completion ]] && \
    source /etc/bash_completion
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

#!/usr/bin/env zsh
# /usr/local/etc/zsh/promtp.zsh ~/.config/zsh/prompt.zsh
# https://gist.github.com/romkatv/2a107ef9314f0d5f76563725b42f7cab

Z_EXEC_TIME=${Z_EXEC_TIME:-true}
Z_PROMPT_NEWLINE=${Z_PROMPT_NEWLINE:-true}

autoload -Uz promptinit

function pre-exec() {
    timer=$(($(date +%s%0N)/1000000))
}
[[ "$Z_EXEC_TIME" == true ]] && add-zsh-hook preexec pre-exec

function pre-cmd() {
    if [ $timer ]; then
        now=$(($(date +%s%0N)/1000000))
        elapsed=$(($now-$timer))
        export TIME="${elapsed}ms"
        unset timer
    fi
}
[[ "$Z_EXEC_TIME" == true ]] && add-zsh-hook precmd pre-cmd

function prompt-length() {
    emulate -L zsh
    local -i COLUMNS=${2:-COLUMNS}
    local -i x y=${#1} m
    if (( y )) ; then
        while (( ${${(%):-$1%$y(l.1.0)}[-1]} )) ; do
            x=y
            (( y *= 2 ))
        done
        while (( y > x + 1 )) ; do
            (( m = x + (y - x) / 2 ))
            (( ${${(%):-$1%$m(l.x.y)}[-1]} = m ))
        done
    fi
    typeset -g REPLY=$x
}

function prompt-fill-line() {
    emulate -L zsh
    prompt-length $1
    local -i left_len=REPLY
    prompt-length $2 9999
    local -i right_len=REPLY
    local -i pad_len=$((COLUMNS - left_len - right_len - ${ZLE_RPROMPT_INDENT:-1}))
    if (( pad_len < 1 )) ; then
        typeset -g REPLY=$1
    else
        local pad=${(pl.$pad_len.. .)}
        typeset -g REPLY=${1}${pad}${2}
    fi
}

function set-prompt() {
    emulate -L zsh
    local userhost='%n'
    if [[ $(id -u) -eq 0 ]] ; then
        userhost="%F{red}$userhost%f"
    else
        userhost="%F{green}$userhost%f"
    fi
    if [[ -n "$SSH_TTY$SSH_CLIENT$SSH2_CLIENT" ]] ; then
        userhost="$userhost%F{yellow}@%m%f"
    fi
    local path="%F{blue}%(5~|%-1~/…/%3~|%4~)%f"
    local top_left="$userhost $path"
    local top_right="%F{magenta}$TIME %f%(1j.%F{cyan}%j& %f .)%(2L.%F{cyan}%L %f.)"
    local bottom_left="%(?.❯.%F{red}!%f) "
    local bottom_right=''
    local REPLY
    prompt-fill-line "$top_left" "$top_right"
    PROMPT='' ; [[ "$Z_PROMPT_NEWLINE" == true ]] && PROMPT=$'\n'
    PROMPT=$PROMPT'%B'$REPLY$'%b\n%B'$bottom_left'%b'
    RPROMPT=$bottom_right
    PS2=""
}

if command -v starship >/dev/null ; then
    if [[ ! -f "$HOME/.config/starship.toml" ]] ; then
        echo 'add_newline = true' >> ~/.config/starship.toml
        starship preset pure-preset >> ~/.config/starship.toml
    fi
    eval "$(starship init zsh)"
else
    setopt no_prompt_{bang,subst} prompt_{cr,percent,sp}
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd set-prompt #setopt prompt_subst
    unsetopt print_exit_value
fi

# EOF

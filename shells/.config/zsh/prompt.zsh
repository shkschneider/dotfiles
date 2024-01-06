# ~/.config/zsh/prompt.zsh
# https://gist.github.com/romkatv/2a107ef9314f0d5f76563725b42f7cab

autoload -Uz promptinit ; promptinit

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
    if [ $EUID -eq 0 ] ; then
        userhost="%F{red}$user%f"
    else
        userhost="%F{green}$user%f"
    fi
    if [ -n "$SSH_TTY$SSH_CLIENT$SSH2_CLIENT" ] ; then
        userhost="$userhost%F{yellow}@%m%f"
    fi
    local path="%F{blue}%(5~|%-1~/…/%3~|%4~)%f"
    local top_left="$userhost $path"
    local top_right="%(1j.%F{magenta}%j&%f .)%(1L.%F{magenta}%L%f.)"
    # › 0x203a
    # ❯ 0x276f
    local bottom_left="%(?.›.%F{red}!%f) "
    local bottom_right=''
    local REPLY
    prompt-fill-line "$top_left" "$top_right"
    PROMPT='%B'$REPLY$'%b\n%B'$bottom_left'%b'
    RPROMPT=$bottom_right
    PS2=""
}

setopt no_prompt_{bang,subst} prompt_{cr,percent,sp}
setopt no_prompt_{bang,subst} prompt_{cr,percent,sp}
autoload -Uz add-zsh-hook
add-zsh-hook precmd set-prompt #setopt prompt_subst
unsetopt print_exit_value

# EOF

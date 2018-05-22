# shkschneider
# $ZSH_CUSTOM/themes/shk.zsh-theme

[ "$(basename $SHELL)" != "zsh" ] && return

autoload -Uz colors && colors
source $ZSH_CUSTOM/plugins/git-prompt/git-prompt.plugin.zsh &>/dev/null
#source $ZSH/plugins/shrink-path/shrink-path.plugin.zsh &>/dev/null
source $ZSH_CUSTOM/plugins/shrink-path/shrink-path.plugin.zsh &>/dev/null

# user@machine /p/a/t/h                               exit_status jobs vcs:status
# $

ZSH_THEME_PROMPT_CHAR="%{»%G%}"
ZSH_THEME_PROMPT_DOTS="%{…%G%}"

#function precmd() {}
#function preexec() {}

set -o prompt_subst
shk_prompt() {
    PROMPT=''

    PROMPT+='%B%F{green}'
    _user=''
    [ "$USER" != "$LOGNAME" ] && _user=$USER
    _host=''
    [ -n "$SSH_TTY$SSH_CONNECTION" ] && _host=$(hostname)
    PROMPT+="$_user"
    [ -n "$_host" ] && PROMPT+='@'
    PROMPT+="$_host"
    PROMPT+="%{$reset_color%}"
    [ -n "$_user$_host" ] && PROMPT+=" "
    unset _user _host

    PROMPT+='%B%F{blue}'
    _pwd=${PWD/#$HOME/'~'}
    if [ ${#_pwd} -gt 80 ] ; then
        # (dev?:)/first/.../last
        #PROMPT+="%b$(echo ${$(df "$PWD" | sed -n '2p')[1]})"
        PROMPT+="%B$(shrink_path --fish)"
    else
        PROMPT+=$_pwd
    fi
    unset _pwd
    PROMPT+="%{$reset_color%}"

    PROMPT+="\n"

    PROMPT+='%B'
    if [ $(id -u) -eq 0 ] ; then
        PROMPT+='%F{red}#'
    else
        PROMPT+='%F{white}$'
    fi
    PROMPT+="%{$reset_color%}"

    echo -n "$PROMPT "
}
shk_rprompt() {
    echo "%F{red}%(1?.%? .)%f"
}

PROMPT='$(shk_prompt)'
RPROMPT='$(shk_rprompt)'

#PROMPT='%B%F{green}%n@%m%f %F{blue}%~%f%b
#%B%(!,%F{red}#,%F{white}$)%f%b '
#local L=$(($SHLVL - 1)) #%(2L.+$L.)
RPROMPT=%{$'\e[1A'%}'%B%F{red}%(1?.%? .)%f%F{magenta}%(1j.%j .)%f%F{yellow}$(git_prompt_info 2>&1)%f%b'%{$'\e[1B'%}

ZSH_THEME_HIGHLIGHT="fg=white,bold"
zle_highlight=(
    default:$ZSH_THEME_HIGHLIGHT
    isearch:$ZSH_THEME_HIGHLIGHT,underline
    region:$ZSH_THEME_HIGHLIGHT
    special:$ZSH_THEME_HIGHLIGHT
    suffix:$ZSH_THEME_HIGHLIGHT
)

# EOF

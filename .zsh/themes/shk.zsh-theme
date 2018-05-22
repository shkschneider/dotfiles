# @author shkschneider
# shk.zsh-theme (oh-my-zsh compatible)

# colors

autoload -Uz colors && colors

export LSCOLORS='exfxcxdxbxegedabagacad' # BSD
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43' # Linux
# zmodload zsh/complist
export ZLS_COLORS=$LS_COLORS

autoload -Uz compinit && compinit -i
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # completion colors

# prompts

autoload -Uz promptinit && promptinit

set -o prompt_subst # the prompt string is first subjected to parameter expansion, command substitution and arithmetic expansion
set -o prompt_percent # certain escape sequences that start with '%' are expanded
export ZLE_RPROMPT_INDENT=1 # used to give the indentation between the right hand side of the right prompt in the line editor
                            # -- if not set, the value 1 is used

ZSH_THEME_PROMPT_PREFIX="" #"%{⁅%G%}"
ZSH_THEME_PROMPT_SPACER="%{ %G%}"
ZSH_THEME_PROMPT_SUFFIX="" #"%{⁆%G%}"
ZSH_THEME_PROMPT_CHAR="%{»%G%} "
ZSH_THEME_PROMPT_DOTS="%{…%G%}"

_prompt() {
    local PROMPT=''

    local _user=''
    [ "$USER" != "$LOGNAME" ] && _user='%n'
    local _host=''
    [ -n "$SSH_TTY$SSH_CONNECTION$SSH_CLIENT" ] && _host="%m"
    if [ -n "$_user$_host" ] ; then
        PROMPT+='%B%F{green}'"$ZSH_THEME_PROMPT_PREFIX"
        PROMPT+="$_user"
        [ -n "$_host" ] && PROMPT+='@'"$_host" || PROMPT+="$_host"
        PROMPT+="$ZSH_THEME_PROMPT_SUFFIX%f%b$ZSH_THEME_PROMPT_SPACER"
    fi

    PROMPT+='%B%F{blue}'"$ZSH_THEME_PROMPT_PREFIX"
    local _pwd="${PWD/#$HOME/~}"
    if [ ${#_pwd} -gt 80 ] ; then
        local _device="$(echo ${$(df "$PWD" | sed -n '2p')[1]})"
        PROMPT+="$_device:"
        PROMPT+="$ZSH_THEME_PROMPT_DOTS/"'%c'
    else
        PROMPT+="$_pwd"
    fi
    PROMPT+="$ZSH_THEME_PROMPT_SUFFIX%f%b"

    PROMPT+="\n"

    [[ $(id -u) = 0 ]] && local _poweruser=true || local _poweruser=false
    $_poweruser && local _color="red" || local _color="white"
    PROMPT+="%B%F{$color}"
    if [ -n "$ZSH_THEME_PROMPT_CHAR" ] ; then
        PROMPT+="$ZSH_THEME_PROMPT_CHAR"
        [[ "$ZSH_THEME_PROMPT_CHAR[-1]" != ' ' ]] && PROMPT+=' '
    else
        $_poweruser && PROMPT+='#' || PROMPT+='$'
    fi
    PROMPT+='%f%b'

    echo -n "$PROMPT%{$reset_color%}"
}

source "$ZSH/plugins/git-prompt/git-prompt.plugin.zsh" &>/dev/null
type git_prompt_info &>/dev/null && ZSH_THEME_RPROMPT_GIT="true" || XSH_THEME_RPROMPT_GIT="false"

_rprompt() {
    local RPROMPT=''
    RPROMPT+='%B'
    if [[ $SHLVL -gt 1 ]] ; then
        RPROMPT+='%F{black}'"+$((SHLVL - 1))$ZSH_THEME_PROMPT_SPACER"'%f'
    fi
    RPROMPT+="%F{red}%(1?.%?$ZSH_THEME_PROMPT_SPACER.)%f"
    RPROMPT+="%F{magenta}%(1j.%j$ZSH_THEME_PROMPT_SPACER.)%f"
    if [ "$ZSH_THEME_RPROMPT_GIT" = "true" ] ; then
        local _git_prompt_info="$(git_prompt_info)"
        if [ -n "$_git_prompt_info" ] ; then
            RPROMPT+='%F{yellow}'"$ZSH_THEME_PROMPT_PREFIX"
            RPROMPT+="$_git_prompt_info"
            RPROMPT+="$ZSH_THEME_PROMPT_SUFFIX"'%f'
        fi
    else
        RPROMPT+='%F{red}?!%f'
    fi
    RPROMPT+='%b'
    #echo -n "$RPROMPT%{$reset_color%}"
    echo -n %{$'\e[1A'%}"$RPROMPT"%{$'\e[1B'%}"%{$reset_color%}"
}

# user@machine /p/a/t/h                              exit_status jobs vcs:status
# $

PROMPT='$(_prompt)'
RPROMPT='$(_rprompt)'

# command line

ZSH_THEME_HIGHLIGHT="fg=white,bold"
zle_highlight=(
    default:$ZSH_THEME_HIGHLIGHT
    isearch:$ZSH_THEME_HIGHLIGHT,underline
    region:$ZSH_THEME_HIGHLIGHT
    special:$ZSH_THEME_HIGHLIGHT
    suffix:$ZSH_THEME_HIGHLIGHT
)

# completion dots

if [[ "$COMPLETION_WAITING_DOTS" = "true" ]] ; then
    _expand-or-complete-with-dots() {
        [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti rmam
        print -Pn "%{…%G%}" # replaces dots
        [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti smam
        zle expand-or-complete
        zle redisplay
    }
    zle -N _expand-or-complete-with-dots
    bindkey '^I' _expand-or-complete-with-dots
fi

# EOF

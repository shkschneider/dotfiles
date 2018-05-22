# @author shkschneider
# $ZSH_CUSTOM/themes/shk.zsh-theme
# ZSH_THEME="shk" >> $HOME/.zshrc

[ ! -e "$HOME/.oh-my-zsh" ] && return

source $ZSH_CUSTOM/plugins/git-prompt/git-prompt.plugin.zsh #>&/dev/null

# colors

autoload -Uz colors && colors

export LSCOLORS="Gxfxcxdxbxegedabagacab" # BSD
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=4\
0;33;01:cd=40;33;01:or=41;33;01:ex=00;32:ow=0;41:*.cmd=00;32:*.exe=01;32:*.com=\
01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*\
.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=0\
0;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=0\
0;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*\
.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=0\
1;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.\
dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32\
:*.ogg=00;32:*.voc=00;32:*.wav=00;32:*.patch=00;34:*.o=00;32:*.so=01;35:*.ko=01\
;31:*.la=00;33' # Linux
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# prompts

autoload -Uz promptinit && promptinit

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

_rprompt() {
    local RPROMPT=''
    RPROMPT+='%B'
    if [[ $SHLVL -gt 1 ]] ; then
        RPROMPT+='%F{black}'"+$((SHLVL - 1))$ZSH_THEME_PROMPT_SPACER"'%f'
    fi
    RPROMPT+="%F{red}%(1?.%?$ZSH_THEME_PROMPT_SPACER.)%f"
    RPROMPT+="%F{magenta}%(1j.%j$ZSH_THEME_PROMPT_SPACER.)%f"
    _git_prompt_info="$(git_prompt_info)"
    if [ -n "$_git_prompt_info" ] ; then
        RPROMPT+='%F{yellow}'"$ZSH_THEME_PROMPT_PREFIX"
        RPROMPT+="$_git_prompt_info"
        RPROMPT+="$ZSH_THEME_PROMPT_SUFFIX"'%f'
    fi
    RPROMPT+='%b'
    echo -n %{$'\e[1A'%}"$RPROMPT"%{$'\e[1B'%}"%{$reset_color%}"
}

# user@machine /p/a/t/h                              exit_status jobs vcs:status
# $
set -o prompt_subst
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

# @author shkschneider
# shk.zsh-theme (oh-my-zsh compatible)

ZSHK=${${ZSHK:=$ZSH_CUSTOM}:=$ZSH}
ZSH_THEME=${ZSH_THEME:-${$(basename -- "${(%):-%N}")%.*}}
ZSH_THEME_HIGHLIGHT=${ZSH_THEME_HIGHLIGHT:-}

# colors

autoload -Uz colors && colors

eval $(dircolors -b)
[ -z "$LSCOLORS" ] && export LSCOLORS='exfxcxdxbxegedabagacad' # BSD
[ -z "$LS_COLORS" ] && export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43' # Linux
# zmodload zsh/complist
export ZLS_COLORS=$LS_COLORS

autoload -Uz compinit && compinit -i
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # completion colors

# prompts

autoload -Uz promptinit && promptinit
prompt $ZSH_THEME &>/dev/null
if [ $(prompt -c | wc -l) -le 1 ] ; then
    echo "zshk: failed to load prompt '$ZSH_THEME'" >&2
fi

# command-line

if [ -n "$ZSH_THEME_HIGHLIGHT" ] ; then
    zle_highlight=(
        default:$ZSH_THEME_HIGHLIGHT
        isearch:$ZSH_THEME_HIGHLIGHT,underline
        region:$ZSH_THEME_HIGHLIGHT
        special:$ZSH_THEME_HIGHLIGHT
        suffix:$ZSH_THEME_HIGHLIGHT
    )
fi

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

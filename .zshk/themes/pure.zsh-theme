# @author sindresorhus <https://github.com/sindresorhus/pure>
# @author shkschneider
# themes/pure.zsh-theme (oh-my-zsh compatible)

ZSHK=${${ZSHK:=$ZSH_CUSTOM}:=$ZSH}
ZSH_THEME=${ZSH_THEME:-${$(basename -- "${(%):-%N}")%.*}}

BASE=${"${(%):-%N}"%.*}
if [ ! -f "$BASE/async.zsh" -o ! -f "$BASE/pure.zsh" ] ; then
    echo "zshk: failed to load theme '$ZSH_THEME'" >&2
    return
fi
source "$BASE/async.zsh"
if ! [ -e "$ZSHK/prompts/prompt_${ZSH_THEME}_setup" ] ; then
    ln --symbolic "$BASE/pure.zsh" "$ZSHK/prompts/prompt_${ZSH_THEME}_setup"
fi
unset BASE

autoload -Uz promptinit && promptinit
prompt $ZSH_THEME &>/dev/null
if [ $(prompt -c | wc -l) -le 1 ] ; then
    echo "zshk: failed to load prompt '$ZSH_THEME'" >&2
fi

# EOF

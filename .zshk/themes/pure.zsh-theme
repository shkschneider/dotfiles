# @author shkschneider
# @author sindresorhus <https://github.com/sindresorhus/pure>
# themes/pure.zsh-theme (oh-my-zsh compatible)

ZSHK=${${ZSHK:=$ZSH_CUSTOM}:=$ZSH}
ZSH_THEME=${ZSH_THEME:-${$(basename -- "${(%):-%N}")%.*}}

BASE=${"${(%):-%N}"%.*}
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

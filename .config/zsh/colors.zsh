# colors.zsh

Z_COLORS=${Z_COLORS:-1}

[[ $Z_COLORS -ne 0 ]] || return

autoload -Uz colors ; colors

zource 'https://raw.githubusercontent.com/seebi/dircolors-solarized/03393f25e241e45fe9341d7baaa2507fd9741a53/dircolors.256dark'
eval $(dircolors $ZCONFDIR/src/dircolors.256dark)
LS_COLORS=${LS_COLORS//=01;/=00;}
LS_COLORS=${LS_COLORS//ex=00;38;5;64/ex=00;31;5;64}
LS_COLORS="${LS_COLORS}:fi=00;37;5;64"
export LS_COLORS

zource 'zlsun/solarized-man'

[ -z "$LS_COLORS" ] && eval "$(dircolors -b)" 2>/dev/null

return

# https://geoff.greer.fm/lscolors/
case $OSTYPE in
  darwin*|freebsd*)
    export CLICOLOR=1
    export LSCOLORS="exfxcxdxbxegedabagacad"
    ;;
esac

[ -z "$LS_COLORS" ] && eval "$(dircolors -b)" 2>/dev/null
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# EOF

# exa.zsh
# ! after aliases
# ! after colors

[[ "${Z_COLORS:-}" == true ]] || return

bin exa || { zlog w 'exa: missing exa' >&2 ; return }

# https://the.exa.website/docs/colour-themes
export EXA_COLORS="$LS_COLORS:\
xx=0;30:\
ur=0;32:uw=0;33:ux=0;31:ue=0;31:gr=0;32:gw=0;33:gx=0;31:tr=0;32:tw=0;33:tx=0;31:\
uu=2;32:gu=2;32:un=0;31:gn=0;31:\
da=2;38:lp=2;37"

alias l='exa -G --group-directories-first --classify'
alias ll='exa -l --group-directories-first --no-permissions --octal-permissions --color-scale --classify'
alias lla='ll --all'
alias lld='ll --only-dirs'
alias llt='ll --tree --level=2'

# EOF

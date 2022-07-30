# aliases.zsh

#[ -f $HOME/.aliases ] && source $HOME/.aliases

[[ ! $OSTYPE == darwin* ]] || bin gls && {
  alias ls='gls --classify --human-readable --group-directories-first --color=auto'
  alias la='ls -A'
  alias lla='ls -lA'
} || {
  alias ls='ls --classify --human-readable --color'
  alias la='ls -a'
  alias lla='ls -la'
}
alias l='ls -C'
alias ll='ls -l'
alias lld='ll -d */'
alias llt='tree -d'

#alias cp='cp --recursive --verbose'
#alias mv='mv --verbose'
#alias mkdir='mkdir --parents --verbose'
#alias scp='scp -r'
#alias wget='wget --quiet'
#alias curl='curl --silent'
#alias bc='bc --quiet'
#alias rm='rm --verbose'
#alias less='less -FX' # exit on EOF
#alias more='more -e' # exit on EOF
#alias nano='nano -z' # suspend
#alias j='jobs'
#alias h='history'
#alias hh='history | grep -i'
case $OSTYPE in
  darwin*)
    alias sed='sed -E'
    alias md5sum='md5'
    alias sha1sum='sha1'
    ;;
esac

bin warp && alias w='warp'

alias reload='exec ${SHELL:-zsh} --login'

# https://github.com/MichaelAquilina/zsh-you-should-use/issues/79
zource 'MichaelAquilina/zsh-you-should-use' 'you-should-use.plugin.zsh'
export YSU_HARDCORE=1
unset -f check_alias_usage enable_you_should_use disable_you_should_use

# EOF

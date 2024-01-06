# ~/.zshenv

case $OSTYPE in
    linux*)
        skip_global_compinit=1 # ubuntu
        ;;
    darwin*)
        export CLICOLOR=1
        export SHELL_SESSIONS_DISABLE=1
        export HOMEBREW_NO_ANALYTICS=1
        ;;
esac


if [[ -o interactive ]] ; then
    for rc in $(find $HOME -name '.zshenv.*') ; do
        source $rc
    done
    source $HOME/.profile
fi

# EOF

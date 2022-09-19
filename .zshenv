# ~/.zshenv

case $OSTYPE in
  linux*)
    skip_global_compinit=1 # ubuntu
    ;;
  darwin*)
    CLICOLOR=1
    SHELL_SESSIONS_DISABLE=1
    HOMEBREW_NO_ANALYTICS=1
    ;;
esac

PROMPT='%F{green}%n%f@%F{magenta}%m%f %F{blue}%B%~%b%f %# '
RPROMPT='[%F{yellow}%?%f]'

while read rc ; do
  source $rc
done < <(find "${ZDOTDIR:-$HOME}" -maxdepth 1 -name '.zshenv.*' 2>/dev/null)

# EOF

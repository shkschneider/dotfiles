# ~/.zshrc

Z_CHPWD=true
Z_COLORS=true
Z_HIGHLIGHT=false
Z_NOTIFY=true
Z_NOTIFY_THRESHOLD=1 # s
Z_NOTIFY_IGNORE+=(emacs less most diff-so-fancy)
Z_NOTIFY_SUCCESS=false
Z_TITLE=true
source "${ZCONFDIR:-$HOME/.config/zsh}/zshrc"

case $OSTYPE in
  darwin*)
    # brew install coreutils
    # brew install hyper && hyper i hyper-one-dark
    alias afk='pmset displaysleepnow' # only works with Security&Privacy>General>RequirePassword=Immediately
    alias battery='pmset -g batt | grep -Eo "\d+%"'
    ;;
  freebsd*)
    alias battery='sysctl -n hw.acpi.battery.life'
    ;;
  linux*)
    # TODO acpi / acpitool
    ;;
esac

alias gradlew='./gradlew'
alias review='git pull --rebase && git review -y'

while read rc ; do
  source $rc
done < <(find "${ZDOTDIR:-$HOME}" -maxdepth 1 -name '.zshrc.*' 2>/dev/null)

# EOF

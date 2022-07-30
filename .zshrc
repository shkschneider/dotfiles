# .zshrc

Z_CHPWD=1
Z_COLORS=1
Z_HIGHLIGHT=0
Z_NOTIFY_THRESHOLD=1 # s
Z_NOTIFY_IGNORE+=(emacs less most diff-so-fancy)
Z_NOTIFY_SUCCESS=0
Z_TITLE=1
YSU_IGNORED_ALIASES=(h hh)
YSU_IGNORED_GLOBAL_ALIASES=(h hh)
source "${ZCONFDIR:-$HOME/.config/zsh}/zshrc"

alias gradlew='./gradlew'
alias review='git pull --rebase && git review -y'
case $OSTYPE in
  darwin*)
    #brew install hyper && hyper i hyper-one-dark
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
bin ugrep && {
  #alias ugrep='ugrep --sort=rchanged --files-with-matches --binary-files=without-match'
  #alias egrep='ugrep -E'
  alias qgrep='ugrep -Q' # query
  alias scripts="ugrep --file-magic='#!' ''"
  # TODO export GREP_COLORS=""
}

export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/Contents/Home"
[ -d "$JAVA_HOME/bin" ] && path=("$JAVA_HOME/bin" $path)
path=($HOME/Library/Android/sdk/platform-tools $path)

# EOF

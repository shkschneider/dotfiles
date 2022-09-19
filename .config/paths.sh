# ~/.config/paths.sh

[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/sbin" ] && export PATH="$HOME/sbin:$PATH"

[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.local/sbin" ] && export PATH="$HOME/.local/sbin:$PATH"

eval $(/opt/homebrew/bin/brew shellenv)
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
PATH="/opt/homebrew/opt/curl/bin:$PATH"

export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/Contents/Home"
[ -d "$JAVA_HOME/bin" ] && PATH="$JAVA_HOME/bin:$PATH"
PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"

export PATH

# EOF

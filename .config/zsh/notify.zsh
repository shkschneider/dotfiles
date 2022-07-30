# notify.zsh
# ! before timer

case $OSTYPE in
  darwin*) bin osascript || zprint e 'missing osascript' >&2 ; return ;;
  *) bin notify-send || zprint e 'missing notify-send' >&2 ; return ;;
esac

Z_NOTIFY_THRESHOLD=${Z_NOTIFY_THRESHOLD:-60} # s
Z_NOTIFY_IGNORE=(${Z_NOTIFY_IGNORE:-${EDITOR:-nano} sleep})
Z_NOTIFY_SUCCESS=${Z_NOTIFY_SUCCESS:-0}

typeset -U Z_NOTIFY_IGNORE

function _notify() {
  [[ $Z_NOTIFY_SUCCESS -eq 0 && $? -eq 0 ]] && return
  [ -n "$TIMER" ] || return
  [[ $TIMER =~ ^[0-9]+(\.[0-9]+)?$ ]] || return
  local argv="$(fc -ln -1)"
  local cmd="${argv%% *}"
  (( $Z_NOTIFY_IGNORE[(Ie)$cmd] )) && return
  local diff=$((EPOCHREALTIME - TIMER))
  [[ $diff -ge Z_NOTIFY_THRESHOLD ]] || return
  case $OSTYPE in
    darwin*)
      osascript -e "display notification \"$argv\" with title \"$cmd took ${diff%.*}s\""
      ;;
    *)
      notify-send -t 2500 "$cmd took ${diff%.*}s"
      ;;
  esac
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _notify

# EOF

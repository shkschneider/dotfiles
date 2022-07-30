# timer.zsh

zmodload zsh/datetime

function _timer_format() {
  local diff=${1:-0}
  printf '%d:%02d:%02d.%03d' $((diff/3600)) $((diff%3600/60)) $((diff%60)) $((diff%60*1000))
}

function _timer_start() {
  TIMER=$EPOCHREALTIME
}
_timer_start # startup

function _timer_end() {
  [ -n "$TIMER" ] || return
  [[ $TIMER =~ ^[0-9]+(\.[0-9]+)?$ ]] || return
  local diff=$((EPOCHREALTIME - TIMER))
  TIMER=$(_timer_format $diff)
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _timer_start
add-zsh-hook precmd _timer_end

# EOF

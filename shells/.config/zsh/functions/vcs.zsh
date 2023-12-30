# ~/.config/zsh/functions/vcs.zsh

bin git || return 1

_git() {
  git rev-parse --show-toplevel 2>/dev/null >&2
}

_git_branch() {
  _git || return 1
  git rev-parse --abbrev-ref HEAD 2>/dev/null || git rev-parse HEAD
}

_git_head() {
  _git || return 1
  git rev-parse --short HEAD || echo "?"
}

_git_behind_ahead() {
  _git || return 1
  git rev-parse @{upstream} >/dev/null 2>&1 || return
  local behind=$(git rev-list --count HEAD..@{upstream})
  local ahead=$(git rev-list --count @{upstream}..HEAD)
  echo -n "-$behind+$ahead"
}

function _git_status() {
  _git || return 1
  git status --porcelain 2>/dev/null | cut -c1,2 | fold -w1 | sort -u | tr -d '[:space:]'
}

function _git_stash() {
  _git || return 1
  local s=$(git stash list 2>/dev/null | wc -l | tr -d '[:space:]')
  [[ $s -gt 0 ]] && echo $s
}

# EOF

# vcs.zsh

function _git() {
  git rev-parse --show-toplevel 2>/dev/null >&2
}

function _git_branch() {
  bin git && _git || return
  git rev-parse --abbrev-ref HEAD 2>/dev/null || git rev-parse HEAD
}

function _git_head() {
  bin git && _git || return
  git rev-parse --short HEAD || echo "?"
}

function _git_behind_ahead() {
  bin git && _git || return
  git rev-parse @{upstream} >/dev/null 2>&1 || return
  local behind=$(git rev-list --count HEAD..@{upstream})
  local ahead=$(git rev-list --count @{upstream}..HEAD)
  echo -n "-$behind+$ahead"
}

function _git_status() {
  bin git && _git || return
  git status --porcelain 2>/dev/null | cut -c1,2 | fold -w1 | sort -u | tr -d '[:space:]'
}

function _git_stash() {
  bin git && -git || return
  local s=$(git stash list 2>/dev/null | wc -l | tr -d '[:space:]')
  [[ $s -gt 0 ]] && echo $s
}

# EOF

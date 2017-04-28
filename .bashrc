# ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return 0

# Options
if [ -x "$(which stty)" ] ; then
    stty -ixon 2>/dev/null
    stty -ixoff 2>/dev/null
fi
umask 022
#set -o noclobber
set -o emacs
#set -o ignoreeof
shopt -s autocd
shopt -s hostcomplete
shopt -s cdspell
shopt -s histappend
shopt -s checkwinsize
shopt -s dotglob
shopt -s checkhash
if [ -n "$BASH_COMPLETION" ] ; then
    complete -cf sudo
    complete -cf man
fi
if [ -x "$(which xset)" ] ; then
    xset -dpms 2>/dev/null
    xset s off 2>/dev/null
fi

# Environment
export HISTCONTROL=ignoreboth #ignoredups,ignorespace
export HISTIGNORE="&;cd:ls:pwd:exit:clear"
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '
export MYSQL_HISTFILE=/dev/null
[ -x "$(which nano)" ] && export EDITOR=nano
export LESS='-R'
[ -x "$(which most)" ] && export PAGER=most || export PAGER=less
[ -f "$HOME/.lessfilter" ] && export LESSOPEN='|~/.lessfilter %s'
export LSCOLORS="cxfxbxdxbxegedabagacad"

# Aliases
alias setenv=export
alias unsetenv=unset

# umask
umask 022

# Completion
[ -f /etc/bash_completion ] && ! shopt -oq posix && source /etc/bash_completion

# Command not found
command_not_found_handle() { echo "bash: $1: command not found"; }

# Path
for path in bin sbin ; do
    [ -d "$HOME/$path" ] && export PATH="$PATH:$HOME/$path"
done

# Prompt
function __ps1() {
    c="$(tput bold)"
    [ $(id -u) -eq 0 ] && c="$c$(tput setaf 1)" || c="$c$(tput setaf 2)"

    user=$(whoami)
    host=$(hostname)
    [ -n "$SSH_CLIENT$SSH2_CLIENT" ] && host="ssh:"$host
    _user="$c⁅$user@$host⁆$(tput sgr0)"
    unset user host

    path=$(readlink -f "." | sed "s#$HOME#~#")
    _path="$(tput bold)$(tput setaf 4)⁅$path⁆$(tput sgr0)"
    unset path

    _prompt=""
    j=$(jobs | wc -l)
    [ $j -gt 0 ] && _prompt="$_prompt $(tput setaf 3)+$j$(tput sgr0)"
    [ $SHLVL -gt 1 ] && _prompt="$_prompt $SHLVL"
    _prompt="$_prompt\n"
    [ $(id -u) -eq 0 ] && _prompt="$_prompt\\#" || _prompt="$_prompt\\$"
    _prompt="$_prompt "
    unset j

    # git
    git_dir=$(git rev-parse --git-dir 2>/dev/null)
    if [ -n "$git_dir" ] && [ $git_dir != "." ] ; then # exclude bare
        git_repo=$(readlink -f "$git_dir" 2>/dev/null | rev | cut -d'/' -f2 | rev)
        _git="$(tput bold)$(tput setaf 3)⁅"$git_repo" "
        git_commit=$(git rev-parse --short HEAD 2>/dev/null)
        git_tag=$(git tag -l --points-at HEAD 2>/dev/null)
        [ -n "$git_tag" ] && git_commit="($git_tag)$git_commit"
        if [ -z "$(git branch -vv --no-color)" ] ; then # naked
            _git=$_git"…"
        elif [ -z "$(git symbolic-ref HEAD 2>/dev/null)" ] ; then # detached
            _git=$_git"✖:"$git_commit
            # [ -d "$git_dir/rebase-apply" ] || [ -d "$git_dir/rebase-merge" ] # rebasing
        else
            git_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
            git_remote=$(git rev-parse --abbrev-ref @{u} 2>/dev/null)
            if [ -n "$git_remote" ] ; then
                _git=$_git"↳"$git_branch":"$git_commit
                git_ahead=$(git rev-list $git_remote..HEAD 2>/dev/null | wc -l)
                git_behind=$(git rev-list HEAD..$git_remote 2>/dev/null | wc -l)
                _git=$_git" "$git_ahead"↑↓"$git_behind
                unset git_ahead git_behind
            else
                _git=$_git$git_branch":"$git_commit
            fi
            unset git_branch git_remote
        fi
        unset git_commit git_tag
        git_status=$(timeout 0.250s git status --porcelain 2>/dev/null)
        [ $? -eq 124 ] && {
            git_status="…"
        } || {
            git_status=$(echo $git_status | cut -c1,2 | tr -d " " | tr -d "\n" | sed ':;s#\(.\)\(.*\)\1#\1\2#;t')
        }
        [ -n "$git_status" ] && _git=$_git" "$git_status || _git=$_git" ✔"
        unset git_status
        git_stash=$(git stash list 2>/dev/null | wc -l)
        [ $git_stash -gt 0 ] && _git=$_git" ⚑"$git_stash
        unset git_stash
        _git=$_git"⁆$(tput sgr0)"
        export PS1=$_user" "$_path" "$_git""$_prompt
    else
        export PS1=$_user" "$_path""$_prompt
    fi
    unset c _user _path _prompt git_dir
}
PROMPT_COMMAND=__ps1

# Custom
[ -f "$HOME/.mybashrc" ] && [ -r "$HOME/.mybashrc" ] && source "$HOME/.mybashrc"

# EOF

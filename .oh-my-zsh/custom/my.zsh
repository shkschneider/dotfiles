# @author shkschneider
# $ZSH_CUSTOM/my.zsh
# -> $HOME/.myzshrc

[ ! -e "$HOME/.oh-my-zsh" ] && return

ZSH_THEME="shk"
CASE_SENSITIVE="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="false"

# compatibility

[[ $- == *i* ]] || return
[ -z "${(@)TERM:#dumb}" ] && return

local minimal_version='4.3.17'
if autoload -Uz is-at-least && ! is-at-least "${minimal_version}" ; then
    echo "warning: version $ZSH_VERSION < ${minimal_version}" >&2
    return
fi
unset minimal_version

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# functions

unfunction take &>/dev/null
unfunction uninstall_oh_my_zsh &>/dev/null
if [ -f "$ZSH/tools/uninstall.sh" ] ; then
    function omz_uninstall() {
        env ZSH=$ZSH sh "$ZSH/tools/uninstall.sh"
    }
fi
unfunction upgrade_oh_my_zsh &>/dev/null
if [ -f "$ZSH/tools/upgrade.sh" ] ; then
    function omz_upgrade() {
        env ZSH="$ZSH" sh "$ZSH/tools/upgrade.sh"
    }
fi
unfunction omz_history >&/dev/null

fpath+=( "$ZSH_CUSTOM/functions" )
export FPATH
for _function in $(find $ZSH_CUSTOM/functions/* -maxdepth 1 -type f 2>/dev/null) ; do
    autoload -Uz $(basename -- $_function)
done
unset _function

# PATH

[ -d "$HOME/bin" ] && path+=( "$HOME/bin" )
[ -d "$HOME/sbin" ] && path+=( "$HOME/sbin" )
export PATH

function _rehash { rehash; reply=() }
compctl -C -c + -K _rehash + -c # rehash upon command-not-found

# aliases

declare -A _aliases=(
    'ls' 'ls --color'
    'grep' 'grep --color'
    'egrep' 'egrep --color'
    'H' 'history'
    'J' 'jobs'
    'L' 'echo $SHLVL'
)
for _key in "${(@k)_aliases}"; do
    alias "$key"="$_aliases[$key]"
done
unset _key _aliases

# options
# setopt shows all options whose settings are changed from the default

set -o auto_cd # if a command is issued that can't be executed, and the command is the name of a directory, perform the cd command to that directory
set -o auto_pushd # make cd push the old directory onto the directory stack
set -o NO_chase_links # resolve symbolic links to their true values when changing directory
set -o always_to_end # if a completion is performed with the cursor within a word, the cursor is moved to the end of the word
set -o NO_auto_name_dirs # any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
set -o complete_in_word # if unset, the cursor is set to the end of the word if completion is started
set -o NO_list_ambiguous # if there is an unambiguous prefix to insert on the command line, that is done without a completion list being displayed
set -o NO_menu_complete # on an ambiguous completion, instead of listing possibilities or beeping, insert the first match immediately
set -o NO_rec_exact # if the string on the command line exactly matches one of the possible completions, it is accepted, even if there is another completion
set -o NO_null_glob # if a pattern for filename generation has no matches, delete the pattern from the argument list instead of reporting an error
set -o hist_ignore_dups # do not enter command lines into the history list if they are duplicates of the previous event
set -o hist_ignore_space # remove command lines from the history list when the first character on the line is a space
set -o hist_no_store # remove the history command from the history list when invoked
set -o hist_reduce_blanks # remove superfluous blanks from each command line being added to the history list
set -o NO_share_history
set -o clobber # allows '>' redirection to truncate existing files -- otherwise '>!' must be used to truncate a file
set -o NO_ignore_eof # do not exit on end-of-file -- require the use of exit or logout instead
set -o NO_correct # try to correct the spelling of commands
set -o NO_print_exit_value # print the exit value of programs with non-zero exit status
set -o NO_rm_star_silent # do not query the user before executing ‘rm *’ or ‘rm path/*’
set -o check_jobs # report the status of background and suspended jobs before exiting a shell with job control
                  # -- a second attempt to exit the shell will succeed
set -o hup # send the HUP signal to running jobs when the shell exits
set -o NO_beep NO_list_beep NO_hist_beep # stfu
set -o always_last_prompt # after listing a completion, the cursor is taken back to the line it was on before, instead of reprinting it underneath

# completion

autoload -Uz compinit && compinit -i

zstyle ':completion:*' format '%B-- %d%b' # group description format
zstyle ':completion:*:warnings' format '%B-- nothing%b' # no completion matches
zstyle ':completion:*' completer _expand _complete # completers (- _ignored _approximate)
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))' # ignore internal commands
# matcher-list matchers are evaluated in order one by one, and stops at the first matcher having candidates
zstyle ':completion:*' matcher-list 'r:|=*' # standard completion based on the start of the word
#zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*' # completion right first then left or right
zstyle ':completion:*' special-dirs true # includes . and ..
zstyle ':completion:*' group-name '' # groups
zstyle ':completion:*' list-dirs-first true # splits directories from files (directories first)
zstyle ':completion::complete:*' use-cache off # cache
zstyle ':completion:*' insert-tab pending # pasting with tabs doesn't perform completion

# keybindings

bindkey -e # emacs
_insert-last-command-output() {
    LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}
zle -N _insert-last-command-output
bindkey '^ ' _insert-last-command-output # ctrl-space

# $HOME/.myzshrc

[ -f "$HOME/.myzshrc" ] && source "$HOME/.myzshrc"

# EOF

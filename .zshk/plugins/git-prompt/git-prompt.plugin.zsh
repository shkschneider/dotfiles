# @author shkschneider
# git-prompt.plugin.zsh

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
ZSH_THEME_GIT_PROMPT_REMOTE="%{➜%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{↑%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{↓%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{…%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{✔%G%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{✗%G%}"

function git_prompt_info() {
    echo -n $ZSH_THEME_GIT_PROMPT_PREFIX
    git_dir=$(git rev-parse --git-dir 2>/dev/null)
    if [ -n "$git_dir" ] && [ $git_dir != "." ] ; then # exclude bare
        git_repo=$(git config --get remote.origin.url 2>/dev/null | rev | cut -d'/' -f1 | rev | sed 's;\.git;;')
        [ -n "$git_repo" ] && echo -n $git_repo$ZSH_THEME_GIT_PROMPT_SEPARATOR
        if [ -z "$(git branch -vv --no-color 2>/dev/null)" ] ; then # naked
            echo -n $ZSH_THEME_GIT_PROMPT_UNTRACKED
        elif [ -z "$(git symbolic-ref HEAD 2>/dev/null)" ] ; then # detached
            git_branch=$(git describe --all --contains HEAD 2>/dev/null | cut -d'~' -f1 | cut -d'^' -f1)
            echo -n $git_branch$ZSH_THEME_GIT_PROMPT_DIRTY
            # [ -d "$git_dir/rebase-apply" ] || [ -d "$git_dir/rebase-merge" ] # rebasing
        else
            git_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
            git_remote=$(git rev-parse --abbrev-ref @{u} 2>/dev/null)
            git_remote=${git_remote/@{u}/}
            if [ -n "$git_remote" ] ; then
                echo -n $git_remote$ZSH_THEME_GIT_PROMPT_REMOTE$git_branch
                git_ahead=$(git rev-list $git_remote..HEAD 2>/dev/null | wc -l)
                git_behind=$(git rev-list HEAD..$git_remote 2>/dev/null | wc -l)
                echo -n $ZSH_THEME_GIT_PROMPT_SEPARATOR
                echo -n $git_ahead$ZSH_THEME_GIT_PROMPT_AHEAD$ZSH_THEME_GIT_PROMPT_BEHIND$git_behind
            else
                echo -n $git_branch
            fi
        fi
        echo -n $ZSH_THEME_GIT_PROMPT_SEPARATOR
        git_status=$(timeout 0.100s git status --porcelain 2>/dev/null)
        [ $? -eq 124 ] && {
            git_status=$ZSH_THEME_GIT_PROMPT_UNTRACKED
        } || {
            # ACDMRTUX?!
            git_status=$(echo "$git_status" | cut -c1,2 | tr -d '[:space:]' | fold -w1 | sort -ur | tr -d '[:space:]')
        }
        [ -n "$git_status" ] && echo -n $git_status || echo -n $ZSH_THEME_GIT_PROMPT_CLEAN
    fi
    echo -n $ZSH_THEME_GIT_PROMPT_SUFFIX
}

# EOF

# ~/.config/sh/history.sh

command -v fzf >/dev/null && {
    bind '"\C-r":"history | sed -r 's;^[^a-z]+;;g' | fzf -0 -1 | ${SHELL:-sh}"'
} || {
    bind '"\C-r":"history | sed -r 's;^[^a-z]+;;g' | ${PAGER:-cat} | ${SHELL:-sh}"'
}

# EOF

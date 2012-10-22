# ~/.bash_logout

[ "$SHLVL" = 1 ] && [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q

history -c
shopt -s nullglob ; rm -f $HOME/.*_history

# EOF

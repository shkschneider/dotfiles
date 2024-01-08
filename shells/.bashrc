# ~/.bashrc

source $HOME/.profile

source $HOME/.config/bash/bashrc

for rc in $(find $HOME -name '.bashrc.*') ; do
    source $rc
done

# EOF

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

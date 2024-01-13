# ~/.bashrc

source $HOME/.profile

source $HOME/.config/bash/bashrc

for rc in $(find $HOME -maxdepth 1 -name '.bashrc.*') ; do
    source $rc
done

# EOF

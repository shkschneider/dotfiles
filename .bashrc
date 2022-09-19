# ~/.bashrc

source "${BASHCONFDIR:-$HOME/.config/bash}/bashrc"

while read rc ; do
  source $rc
done < <(find $HOME/.bashrc.* -maxdepth 1 2>/dev/null)

# EOF

# /etc/profile.d/colors.sh ~/.config/profile.d/colors.sh

export NO_COLOR=0
eval "$(dircolors -b ~/.dircolors 2>/dev/null)" || eval "$(dircolors -b)"

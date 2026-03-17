# ~/.config/hypr/reload.sh

hyprctl reload || exit 1

pkill waybar 2>/dev/null
command -v waybar >/dev/null && \
    waybar >/dev/null &

[[ -x ~/.local/bin/wallpaper ]] && \
    ~/.local/bin/wallpaper

command -v dunst >/dev/null && \
    dunstctl reload && notify-send -u low reloaded

# EOF

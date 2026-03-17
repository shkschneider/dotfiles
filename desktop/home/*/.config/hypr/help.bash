# ~/.config/hypr/help.bash

command -v bash >/dev/null || exit 1
command -v hyprctl >/dev/null || exit 2
command -v jq >/dev/null || exit 3

_modmask_to_human_mod() {
    mask="$1"
    mods=()
    while (( $mask -gt 0 )) ; do
        if (( $mask -ge 128 )) ; then
            mods+=("Mod5+")
            (( mask -= 128 ))
        elif (( $mask -ge 64 )) ; then
            mods+=("Super+")
            (( mask -= 64 ))
        elif (( $mask -ge 32 )) ; then
            mods+=("Mod3+")
            (( mask -= 32 ))
        elif (( $mask -ge 16 )) ; then
            mods+=("Mod2+")
            (( mask -= 16 ))
        elif (( $mask -ge 8 )) ; then
            mods+=("Alt+")
            (( mask -= 8 ))
        elif (( $mask -ge 4 )) ; then
            mods+=("Ctrl+")
            (( mask -= 4 ))
        elif (( $mask -ge 2 )) ; then
            mods+=("Caps+")
            (( mask -= 2 ))
        elif (( $mask -ge 1 )) ; then
            mods+=("Shift+")
            (( mask -= 1 ))
        else
            mods+=("?")
            break
        fi
    done
    echo "${mods[@]}"
}

mod="$(grep "$HOME/.config/hypr/*.conf" | head -1 | tr -s ' ' | cut -d' ' -f3-)"
mod="${mod:-MOD}"
keybinds="$(grep bind "$HOME/.config/hypr/*.conf" | head -15 | tr -s ' ' | cut -d' ' -f3-)"
keybinds="${keybinds//\$mod/$mod}"
keybinds="${keybinds//,/ }"
keybinds="${keybinds//  / }"

hyprland-dialog \
    --title "Help" \
    --text "$keybinds" \
    --buttons "Close" \
    ;

# EOF

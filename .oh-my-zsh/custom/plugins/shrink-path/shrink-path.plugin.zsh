# shkschneider
# $ZSH_CUSTOM/plugins/shrink-path/shrink-path.plugin.zsh
# Overrides $ZSH/plugins/shrink-path/shrink-path.plugin.zsh

function shrink_path() {
    # if > 80: /first/.../last
    # else: path
    # dev: echo ${$(df "$PWD" | sed -n '2p')[1]}
}

# EOF

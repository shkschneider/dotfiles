# _colors.sh
# https://askubuntu.com/a/466203

local _text=$(uname -a)
for color in 00{2..8} {0{3,4,9},10}{0..7} ; do
    for bold in 0 1 ; do
        echo -e "$bold;$color \e[$bold;${color}m$_text\e[00m"
    done
done
unset _text

# EOF

# @author shkschneider
# $HOME/.zshenv

for _path in bin sbin ; do
    [ -d "$HOME/$_path" ] && path=( "$HOME/$_path" $path )
done ; unset _path
export PATH

function _rehash { rehash; reply=() }
compctl -C -c + -K _rehash + -c # rehash upon command-not-found

# EOF

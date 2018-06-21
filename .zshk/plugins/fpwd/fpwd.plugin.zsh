# @author shkschneider
# @author mcornella <https://github.com/robbyrussell/oh-my-zsh/issues/5068#issuecomment-218780098>
# plugins/fpwd/fpwd.plugin.zsh

function fpwd() {
    local _home="false"
    local _first="false"
    local _device="false"
    for _arg in $@ ; do
        case $_arg in
            -h) _home="true" ;;
            -f) _first="true" ;;
            -d) _device="true" ;;
            *) ;;
        esac
    done

    if [ "$_device" = "true" ] ; then
        echo -n ${$(df "$PWD" | sed -n '2p')[1]}":"
    fi

    if [ "$PWD" = "$HOME" ] ; then
        [ "$_home" = "true" ] && echo "$HOME" || echo "~"
    else
        local _pwd="$PWD"
        if [ "$_first" = "true" ] ; then
            if [[ $_pwd =~ /* ]] ; then
                echo -n /${_pwd[(ws:/:)1]}
                _pwd=$(realpath --relative-to="/${_pwd[(ws:/:)1]}" "$_pwd")
            fi
        fi
        if [ "$_home" = "true" ] ;then
            echo /${(j:/:)${(M)${(s:/:)_pwd:h}#(|.)[^.]}}/${_pwd:t}
        else
            echo ${${:-/${(j:/:)${(M)${(s:/:)${(D)_pwd:h}}#(|.)[^.]}}/${_pwd:t}}//\/~/\~}
        fi
    fi
}

# EOF

all_but_last:
```
s='this-is-a.test' ; echo "${s%/*}"
```
last_only:
```
s='this-is-a-.test' ; echo ${s##*.}
```
remove_from_string:
```
s='this-is-a-test'; r='test'; ${(@)s:#r}
```
first_char:
```
s=01234567890abcdef ; echo ${s[1]}
```
last_char:
```
s=01234567890abcdef ; echo ${s[-1]}
```
replace:
```
s=01234567890abcdef ; echo ${s/abc/ABC}
```
split:
```
s='this-is-a-test'; echo "${(@s/-/)s}"
```
get_from_split_array:
```
s='this-is-a-test'; echo "${s[(ws:-:)1]}"
```
array:
```
s='this-is-a-test'; echo "${${(@s/-/)s}[1]}"
```
extension:
```
s='this/is/a_filename.zsh' ; echo ${s##*\.}
```
path_and_basename:
```
s='this/is/a_filename.zsh' ; echo ${s%*\.*}
```
default:
```
FOO=${VARIABLE:-default}
```
default_var:
```
FOO=${VARIABLE:=default}
```

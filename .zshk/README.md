(Oh My) Zsh will not make you a 10x developer...but you might feel like one.
============================================================================

```
> echo "${(j::)${(@Oa)${(s::):-hello}}}"
olleh
> echo hello | rev
olleh
```

> Exactly.

Configurations loading
----------------------

```
+---------------------+-------------+-------------+--------+
|                     | interactive | interactive | script |
|                     | login       | non-login   |        |
+---------------------+-------------+-------------+--------+
| /etc/zshenv         | 1           | 1           | 1      |
| ~/.zshenv           |  2          |  2          |  2     |
| /etc/zprofile       |   3         +-------------+--------+
| ~/.zprofile         |    4        +-------------+--------+
| /etc/zshrc          |     5       |   3         |
| ~/.zshrc            |      6      |    4        |
+---------------------+-------------+-------------+
| ~/.zshk/zshk.zsh    |           A               |
| ~/.zshk/functions/* |            B              |
| ~/.zshk/plugins/*   |             C             |
| ~/.zshk/prompts/*   |              D            |
| ~/.myzshrc          |               E           |
+---------------------+-------------+-------------+
| /etc/zlogin         |       7     |
| ~/.zlogin           |        8    |
+---------------------+-------------+
+---------------------+-------------+
| ~/.zlogout          |         9   |
| /etc/zlogout        |          10 |
+---------------------+-------------+
```

Oh-My-Zsh
---------

This configuration could very well work with oh-my-zsh.

Simple clone this and point ZSH_CUSTOM to it.

Tips and tricks
---------------

```
% setopt extendedglob
% rm ../debianpackage(.)   # remove files only
% ls -d *(/)               # list directories only
% ls /etc/*(@)             # list symlinks only
% ls -l *.(png|jpg|gif)    # list pictures only
% ls *(*)                  # list executables only
% ls /etc/**/zsh           # which directories contain 'zsh'?
% ls **/*(-@)              # list dangling symlinks ('**' recurses down directory trees)
% ls foo*~*bar*            # match everything that starts with foo but doesn't contain bar
```

```
# A plain old glob
print -l zsh_demo/data/europe/poland/*.txt
# Return the file name (t stands for tail)
print -l zsh_demo/data/europe/poland/*.txt(:t)
# Return the file name without the extension (r stands for remove_extension, I think)
print -l zsh_demo/data/europe/poland/*.txt(:t:r)
# Return the extension
print -l zsh_demo/data/europe/poland/*.txt(:e)
# Return the parent folder of the file (h stands for head)
print -l zsh_demo/data/europe/poland/*.txt(:h)
# Return the parent folder of the parent
print -l zsh_demo/data/europe/poland/*.txt(:h:h)
# Return the parent folder of the first file
print -l zsh_demo/data/europe/poland/*.txt([1]:h)
# Remember you can combine qualifiers and modifiers.
```

is_numeric:
```
s=42 ; [[ $s == <-> ]] && echo "ok" || echo "ko"
```
type_exists:
```
type git_prompt_info &>/dev/null && echo "ok" || echo "ko"
```
path_to_script:
```
echo ${(%):-%N}
```
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

Resources
---------

* http://reasoniamhere.com/2014/01/11/outrageously-useful-tips-to-master-your-z-shell/
* http://www.strcat.de/zsh/#tipps

PS
--

fizsh(1) is a nice alternative for an out-of-the-box zsh shell.

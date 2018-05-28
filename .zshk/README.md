(Oh My) Zsh will not make you a 10x developer...but you might feel like one.
============================================================================

```
> echo "${(j::)${(@Oa)${(s::):-hello}}}"
olleh
> echo hello | rev
olleh
```

> Exactly.

ZSH default configurations loading
----------------------------------

+---------------+-------------+-------------+--------+
|               | interactive | interactive | script |
|               | login       | non-login   |        |
+---------------+-------------+-------------+--------+
| /etc/zshenv   | 1           | 1           | 1      |
| ~/.zshenv     |  2          |  2          |  2     |
| /etc/zprofile |   3         +-------------+--------+
| ~/.zprofile   |    4        +-------------+--------+
| /etc/zshrc    |     5       |   3         |
| ~/.zshrc      |      6      |    4        |
| /etc/zlogin   |       7     +-------------+
| ~/.zlogin     |        8    |
+---------------+-------------+
| ~/.zlogout    |         9   |
| /etc/zlogout  |          10 |
+---------------+-------------+

Configuration framework explained
---------------------------------

* /etc/zshrc: sets default prompts, default global environment variables, basic path
* $HOME/.zshrc: sets default prompts, default environement variables,
then loads $HOME/.zsh/*.zsh scripts and finally loads the theme
* $HOME/.zsh/my.zsh: random theme, loads functions, plugins, prompts, sets options, zstyle, base path and aliases, default bindkeys
then loads $HOME/.myzshrc for overrides
* $HOME/.myzshrc: user-centric configuration and overrides

Vanilla ZSH:

In vanilla ZSH, without $HOME/.zsh/, loading goes: /etc/zshrc, $HOME/.zshrc, $HOME/.myzshrc. (Theme loaded last from $HOME/.zshrc.)
In vanilla ZSH, with this $HOME/.zsh/, loading goes: /etc/zshrc, $HOME/.zshrc, $HOME/.zsh/init.zsh (...), $HOME/.myzshrc. (Theme loaded last from $HOME/.zshrc.)

Oh-My-Zsh: Use .zshk as ZSH_CUSTOM

With oh-my-zsh, you would set ZSH_CUSTOM to this .zsh/; loading goes: /etc/zshrc, $HOME/.zshrc (oh-my-zsh's), $ZSH_CUSTOM/init.zsh (...), $HOME/.myzshrc. (Theme loaded by oh-my-zsh, yet $HOME/.myzshrc is sourced before and can override anything.)

Prezto: I guees you could use .zshk as a module using "zstyle ':prezto:load' pmodule-dirs $HOME/.zshk" in $HOME/.zpreztorc.

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

http://reasoniamhere.com/2014/01/11/outrageously-useful-tips-to-master-your-z-shell/
http://www.strcat.de/zsh/#tipps

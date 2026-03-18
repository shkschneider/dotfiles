local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")
local shell = import("micro/shell")
local util = import("micro/util")
local strings = import("strings")
local ioutil = import("io/ioutil")
local filepath = import("path/filepath")
local os = import("os")

function Explore(bp, args)
    local path, err = os.Getwd()
    if err then path = filepath.Dir(bp.Buf.AbsPath) else path = filepath.Abs(path) end
    local out, err = shell.RunInteractiveShell("bash -c '" .. table.concat({
        "fd . --type file --type symlink --base-directory " .. path .. " --relative-path --color=never | sort --uniq | sed \'/^$/d\'",
        "fzf --no-info --header-first --header \'" .. path .. "\' --height=100% --color=16 --prompt=\"  \" --preview \"bat --color=always " .. path .. "/{}\""
    }, " | ") .. "'", false, true)
    if err then
        local cancelled = tostring(err):match(" 130$")
        if cancelled then return else return micro.InfoBar():Error(tostring(err)) end
    end
    path = filepath.Abs(filepath.Join(path, out))
    if string.match(path, bp.Buf.AbsPath) then
        return
    end
    micro.InfoBar():GutterMessage(path)
    bp:HandleCommand("tab " .. path)
end

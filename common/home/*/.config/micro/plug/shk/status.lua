local micro = import("micro")
local buffer = import("micro/buffer")
local shell = import("micro/shell")
local strings = import("strings")
local util = import("micro/util")
local filepath = import("path/filepath")
local humanize = import("humanize")
local os = import("os")

function _git_repo(path)
    local out, err = shell.ExecCommand("git", "-C", path, "rev-parse", "--show-toplevel")
    return (not err and filepath.Base(strings.TrimSpace(out)) or nil)
end

function _git_branch(path)
    local out, err = shell.ExecCommand("git", "-C", path, "rev-parse", "--abbrev-ref", "HEAD")
    return (not err and strings.TrimSpace(out) or "")
end

function _git_hash(path)
    local out, err = shell.ExecCommand("git", "-C", path, "rev-parse", "--short", "HEAD")
    return (not err and strings.TrimSpace(out) or "")
end

function _git_action(path)
    --local git, err = shell.ExecCommand("git", "rev-parse", "--is-inside-work-tree")
    local dir, err = shell.ExecCommand("git", "-C", path, "rev-parse", "--absolute-git-dir")
    if not err then dir = strings.TrimSpace(dir) else return "" end
    local _, err = os.Stat(dir .. "/rebase-apply")
    if not err then return "REBASE" end
    local _, err = os.Stat(dir .. "/MERGE_HEAD")
    if not err then return "MERGE" end
    return ""
end

function _git_diff(path)
    local out, err = shell.ExecCommand("git", "-C", path, "diff", "--shortstat")
    return (not err and strings.TrimSpace(out):gsub(",", "~", 1):gsub("[^%d\~\+\-]", "") or "")
end

LEFT = nil
function StatusLeft(buf)
    local file = tostring(buf.OpenBuffers)
    -- Tab:TotalSize()
    local filename = buf:GetName() .. (buf:Modified() and "~" or "")
    -- local filetype = buf:FileType()
    local cursor = buf:GetActiveCursor()
    local x, y = cursor.Loc.X, cursor.Loc.Y
    local pc = (y * 100) / buf.LineArray:LinesNum()
    return string.format("%s | %s | %d:%d %d%%", filename, humanize.Bytes(buf:Size()), y, x, pc):gsub("%s%s+", " ")
end

RIGHT = nil
function StatusRight(buf)
    if RIGHT and not buf:Modified() then return RIGHT end
    local path = filepath.Dir(buf.AbsPath or buf.Path)
    local git = _git_repo(path)
    if git then
        RIGHT = table.concat({_git_action(git), _git_branch(git), _git_hash(git), _git_diff(git)}, " ") .. " | " .. git
    else
        RIGHT = path:gsub(os.UserHomeDir(), "~")
    end
    return RIGHT
end

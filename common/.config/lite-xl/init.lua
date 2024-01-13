-- Theme

local core = require "core"
core.reload_module("colors.github-dark-dimmed")

-- Plugins

local config = require "core.config"
config.plugins.autoinsert = false
config.plugins.eofnewline = require("plugins.eofnewline") ~= nil
config.plugins.macro = require("plugins.macro") ~= nil
config.plugins.sort = require("plugins.sort") ~= nil

-- Bindings

local keymap = require "core.keymap"
for _, binding in ipairs({
    { ["ctrl+1lclick"] = "doc:split-cursor" },
    { ["ctrl+1"] = "root:switch-to-tab-1" },
    { ["ctrl+2"] = "root:switch-to-tab-2" },
    { ["ctrl+3"] = "root:switch-to-tab-3" },
    { ["ctrl+4"] = "root:switch-to-tab-4" },
    { ["ctrl+5"] = "root:switch-to-tab-5" },
    { ["ctrl+6"] = "root:switch-to-tab-6" },
    { ["ctrl+7"] = "root:switch-to-tab-7" },
    { ["ctrl+8"] = "root:switch-to-tab-8" },
    { ["ctrl+9"] = "root:switch-to-tab-9" },
    { ["ctrl+backspace"] = "doc:delete-to-previous-word-start" },
    { ["ctrl+c"] = "doc:copy" },
    { ["ctrl+d"] = "doc:duplicate-lines" },
    { ["ctrl+delete"] = "doc:delete-to-next-word-end" },
    { ["ctrl+]"] = "doc:move-to-next-block-end" },
    { ["ctrl+["] = "doc:move-to-previous-block-start" },
    { ["ctrl+/"] = "doc:toggle-line-comments" },
    { ["ctrl+down"] = "doc:move-to-next-page" },
    { ["ctrl+end"] = "doc:move-to-end-of-doc" },
    { ["ctrl+f"] = "find-replace:find" },
    { ["ctrl+g"] = "doc:go-to-line" },
    { ["ctrl+home"] = "doc:move-to-start-of-doc" },
    { ["ctrl+j"] = "doc:join-lines" },
    { ["ctrl+left"] = "doc:move-to-previous-word-start" },
    { ["ctrl+m"] = "macro:toggle-record" }, -- FIXME
    { ["ctrl+n"] = "core:new-named-doc" },
    { ["ctrl+o"] = "core:find-file" },
    { ["ctrl+return"] = "doc:newline-below" },
    { ["ctrl+right"] = "doc:move-to-next-word-end" },
    { ["ctrl+s"] = "doc:save" },
    { ["ctrl+shift+a"] = "doc:select-all" },
    { ["ctrl+shift+]"] = "doc:select-to-next-block-end" },
    { ["ctrl+shift+["] = "doc:select-to-previous-block-start" },
    { ["ctrl+shift+down"] = "doc:create-cursor-next-line" },
    { ["ctrl+shift+m"] = "macro:play" }, -- FIXME
    { ["ctrl+shift+o"] = "core:open-file" },
    { ["ctrl+shift+o"] = "core:open-project-folder" },
    { ["ctrl+shift+r"] = "core:restart" },
    { ["ctrl+shift+return"] = "doc:newline-above" },
    { ["ctrl+shift+s"] = "doc:save-as" },
    { ["ctrl+shift+/"] = "sort:sort" },
    { ["ctrl+shift+tab"] = "root:move-tab-left" },
    { ["ctrl+shift+up"] = "doc:create-cursor-previous-line" },
    { ["ctrl+shift+w"] = "root:close-all-others" },
    { ["ctrl+shift+z"] = "doc:redo" },
    { ["ctrl+space"] = "core:find-command" },
    { ["ctrl+tab"] = "root:move-tab-right" },
    { ["ctrl+t"] = "find-replace:replace" },
    { ["ctrl+up"] = "doc:move-to-previous-page" },
    { ["ctrl+v"] = "doc:paste" },
    { ["ctrl+w"] = "root:close" },
    { ["ctrl+x"] = "doc:cut" },
    { ["ctrl+y"] = "doc:redo" },
    { ["ctrl+z"] = "doc:undo" },
    { ["escape"] = "doc:select-none" },
    { ["shift+tab"] = "doc:unindent" },
    { ["tab"] = "doc:indent" }
}) do
    keymap.add(binding, true)
end

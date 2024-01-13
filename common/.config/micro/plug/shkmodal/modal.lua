NAME = "shk-modal"
VERSION = "2.0.0"

local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")
local shell = import("micro/shell")
local util = import("micro/util")
local strings = import("strings")
local ioutil = import("io/ioutil")
local filepath = import("path/filepath")
local os = import("os")

local modals = {
    ["c"] = { "Center" },
	["C"] = { "CommandMode" },
	-- quit
	["QQ"] = { "ForceQuit" },
	["qq"] = { "Quit" },
	["qa"] = { "QuitAll" },
	["wq"] = { "Write", "Quit" },
	["WQ"] = { "WriteAll", "Quit!" },
	-- select
    ["se"] = { "SelectToEndOfLine" },
    ["sE"] = { "SelectToEnd" },
    ["ss"] = { "SelectToStartOfLine" },
    ["SS"] = { "SelectToStart" },
    ["sS"] = { "SelectToStartOfText" },
	["sA"] = { "SelectAll" },
	-- write
    ["wA"] = { "SaveAll" },
    ["wa"] = { "SaveAs" },
    ["ww"] = { "Save" },
	-- copy
    ["cc"] = { "Copy" },
    ["cC"] = { "CopyLine" },
	["cv"] = { "Paste" },
    ["cx"] = { "Cut" },
    ["cX"] = { "CutLine" },
    -- cursor
    ["cd"] = { "CursorDown" },
    ["ce"] = { "CursorEnd" },
    ["cl"] = { "CursorLeft" },
    ["cp"] = { "CursorPageDown" },
    ["cP"] = { "CursorPageUp" },
    ["cr"] = { "CursorRight" },
    ["cs"] = { "CursorStart" },
    ["cu"] = { "CursorUp" },
    ["cE"] = { "End" },
    ["cE"] = { "EndOfLine" },
    -- line
    ["ll"] = { "DuplicateLine" },
    ["ld"] = { "DeleteLine" },
    ["lD"] = { "MoveLineDown" },
    ["lU"] = { "MoveLineUp" },
    -- word
    ["wD"] = { "DeleteWordLeft" },
    ["wd"] = { "DeleteWordRight" },
    -- find
    ["ff"] = { "Find" },
    ["fn"] = { "FindNext" },
    ["fp"] = { "FindPrevious" },
    -- ...
    ["dn"] = { "DiffNext" },
    ["dp"] = { "DiffPrevious" },
	[" "] = { "Escape", "ClearStatus", "Deselect", "ClearInfo" },
	-- "HalfPageDown":              (*BufPane).HalfPageDown,
	-- "HalfPageUp":                (*BufPane).HalfPageUp,
	-- "HSplit":                    (*BufPane).HSplitAction,
    ["ii"] = { "IndentSelection", "IndentLine" },
	["io"] = { "OutdentSelection", "OutdentLine" },
	-- "JumpLine":                  (*BufPane).JumpLine,
	-- "JumpToMatchingBrace":       (*BufPane).JumpToMatchingBrace,
	["MM"] = { "PlayMacro" },
	["mm"] = { "ToggleMacro" },
	-- "NextSplit":                 (*BufPane).NextSplit,
	-- "NextTab":                   (*BufPane).NextTab,
	["of"] = { "OpenFile" },
	-- "PageDown":                  (*BufPane).PageDown,
	-- "PageUp":                    (*BufPane).PageUp,
    ["pn"] = { "ParagraphNext" },
    ["pp"] = { "ParagraphPrevious" },
	-- "PreviousSplit":             (*BufPane).PreviousSplit,
	-- "RemoveAllMultiCursors":     (*BufPane).RemoveAllMultiCursors,
	-- "RemoveMultiCursor":         (*BufPane).RemoveMultiCursor,
	-- "ScrollDown":                (*BufPane).ScrollDownAction,
	-- "ScrollUp":                  (*BufPane).ScrollUpAction,
	-- "SelectPageDown":            (*BufPane).SelectPageDown,
	-- "SelectPageUp":              (*BufPane).SelectPageUp,
	-- "SkipMultiCursor":           (*BufPane).SkipMultiCursor,
	-- "SpawnMultiCursor":          (*BufPane).SpawnMultiCursor,
	-- "SpawnMultiCursorDown":      (*BufPane).SpawnMultiCursorDown,
	-- "SpawnMultiCursorSelect":    (*BufPane).SpawnMultiCursorSelect,
	-- "SpawnMultiCursorUp":        (*BufPane).SpawnMultiCursorUp,
	["SS"] = { "ShellMode" },
	-- "Start":                     (*BufPane).Start,
	-- "StartOfLine":               (*BufPane).StartOfLine,
	-- "StartOfTextToggle":         (*BufPane).StartOfTextToggle,
	["st"] = { "StartOfText" },
	["ta"] = { "AddTab" },
	["tn"] = { "NextTab" },
	["hh"] = { "ToggleHelp" },
	["hH"] = { "ToggleKeyMenu" },
	["tp"] = { "PreviousTab" },
	-- "UnhighlightSearch":         (*BufPane).UnhighlightSearch,
	-- "Unsplit":                   (*BufPane).Unsplit,
	-- "VSplit":                    (*BufPane).VSplitAction,
    ["wl"] = { "WordLeft" },
    ["wr"] = { "WordRight" },
    ["zZ"] = { "Redo" },
	["ZZ"] = { "Suspend" },
    ["zz"] = { "Undo" },
}

function Modal(bp, args)
    local done = false
    micro.InfoBar():Prompt(":", "", "Modal", function (out, cancelled)
        if cancelled then return end
        for key, values in pairs(modals) do
            if key == out then
                micro.InfoBar():DonePrompt(false)
                for _, value in ipairs(values) do
                    micro.InfoBar():Message("modal=" .. key .. "->" .. table.concat(values, "+"))
                    -- FIXME Eval unsupported
                end
                done = true
                break
            end
        end
    end, function (out, cancelled)
        if cancelled then return end
        bp:HandleCommand(out)
    end)
end

function init()
    config.MakeCommand("modal", Modal, OptionComplete)
    --config.TryBindKey("Ctrl-Space", "command:modal", true)
end

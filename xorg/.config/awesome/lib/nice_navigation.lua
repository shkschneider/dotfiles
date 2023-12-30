assert(awesome and awful)

local function valid_direction(dir)
    return dir == "up" or dir == "right" or dir == "down" or dir == "left"
end

local function valid_screen_index(index)
    return index >= 1 and index <= screen.count()
end

local function valid_tag_index(index, screen)
    -- return index >= 1 and index <= #(screen or awful.screen.focused).tags
    return true
end

-- focus

local function focus_tag_indexed(index)
    assert(valid_tag_index(index))
    for screen = 1, screen.count() do
        local tag = awful.screen.focused().tags[index]
        if tag then tag:view_only() end
    end
end

local function focus_next_client()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
end

local function focus_previous_client()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
end

local function focus_relative(dir)
    assert(valid_direction(dir))
    local id = client.focus.window
    awful.client.focus.bydirection(dir)
    if id == client.focus.window then
        awful.client.focus.global_bydirection(dir)
        if id == client.focus.window then
            local screen = awful.screen.focused()
            if dir == "up" or dir == "right" then
                if screen.selected_tag.index < #screen.tags then
                    for t = screen.selected_tag.index + 1, #screen.tags, 1 do
                        if #screen.tags[t]:clients() > 0 then
                            screen.tags[t]:view_only()
                            return
                        end
                    end
                end
            elseif dir == "down" or dir == "left" then
                if screen.selected_tag.index > 1 then
                    for t = screen.selected_tag.index - 1, 0, -1 do
                        if #screen.tags[t]:clients() > 0 then
                            screen.tags[t]:view_only()
                            return
                        end
                    end
                end
            end
        end
    end
end

-- move

local function move_to_tag_indexed(index)
    assert(valid_tag_index(index))
    if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
            client.focus:move_to_tag(tag)
            focus_tag_indexed(index)
        end
    end
end

local function _move_relative_screen(dir)
    if screen.count() == 1 then return false end
    local index = client.focus.screen.index
    if dir == "up" or dir == "right" then
        index = index + 1
    elseif dir == "down" or dir == "left" then
        index = index - 1
    end
    if valid_screen_index(index) then
        client.focus:move_to_screen(index)
        client.focus:raise()
        return true
    end
    return false
end

local function _move_relative_tag(dir)
    local screen = awful.screen.focused()
    local index = screen.selected_tag.index
    if dir == "up" or dir == "right" then
        index = index + 1
    elseif dir == "down" or dir == "left" then
        index = index - 1
    end
    if valid_tag_index(index) then
        client.focus:tags({screen.tags[index]})
        focus_tag_indexed(index)
        return true
    end
    return false
end

local function move_relative(dir)
    assert(valid_direction(dir))
    if not _move_relative_screen(dir) then
        if not _move_relative_tag(dir) then
            nice.notify.critical(nil, "navigation", "move_relative failed!")
        end
    end
end

return {
    focus_tag_indexed = focus_tag_indexed,
    focus_next_client = focus_next_client,
    focus_previous_client = focus_previous_client,
    focus_relative = focus_relative,
    move_to_tag_indexed = move_to_tag_indexed,
    move_relative = move_relative
}

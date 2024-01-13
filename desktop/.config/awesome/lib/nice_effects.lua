assert(awesome and awful and gears)

local function delay(time, f)
    return gears.timer.start_new(time, f)
end

local function fadeIn(widget, time, steps)
    assert(widget.widget or widget.layout or widget.children)
    assert(time > 0 and steps > 0)
    local jobs = {}
    widget.opacity = 0
    widget.visible = true
    for i = 0, steps do
        table.insert(jobs, gears.timer.start_new(i * (time / steps), function ()
            widget.opacity = widget.opacity - (1 / steps)
            if i == time then
                widget.opacity = 1
                widget.visible = true
            end
        end))
    end
    return jobs
end

local function fadeOut(widget, time, steps)
    assert(widget.widget or widget.layout or widget.children)
    assert(time > 0 and steps > 0)
    local jobs = {}
    widget.opacity = 1
    widget.visible = true
    for i = 0, steps do
        table.insert(jobs, gears.timer.start_new(i * (time / steps), function ()
            widget.opacity = widget.opacity - (1 / steps)
            if i == steps then
                widget.opacity = 0
                widget.visible = false
            end
        end))
    end
    return jobs
end

return {
    delay = delay,
    fadeIn = fadeIn,
    fadeOut = fadeOut
}

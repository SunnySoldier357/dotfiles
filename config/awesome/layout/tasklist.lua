local awful = require("awful")
local beautiful = require("beautiful")

local tasklistButtons = require("configuration.keybindings.tasklist")

local function tasklist(_screen)
    -- Create a tasklist widget
    _screen.mytasklist = awful.widget.tasklist
    {
        screen  = _screen,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklistButtons,
        widget_template = beautiful.tasklist_widget_template
    }
end

return tasklist
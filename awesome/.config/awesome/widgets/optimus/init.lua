local awful = require("awful")
local watch = require("awful.widget.watch")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local iconDir = require("gears.filesystem").get_configuration_dir() .. "widgets/optimus/icons/"
local wibox = require("wibox")

local apps = require("configuration.apps")
local clickableContainer = require("widgets.clickableContainer")

local optimusMode = nil

local widget = wibox.widget
{
    {
        id = "icon",
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}

local widgetButton = clickableContainer(widget)

-- Create the menu to switch to a different mode
-- local menuWibox = wibox.widget(
    
-- );

-- optimus-manager --status sample outputs
--
-- Optimus Manager (Client) version 1.2.2
--
-- Current GPU mode : intel
-- GPU mode requested for next login : nvidia
-- GPU mode for next startup : nvidia
-- Temporary config path: no

-- Run optimus-manager --status & get its output
local naughty = require("naughty")
awful.spawn.easy_async("optimus-manager --status",
    function(stdout)
        for line in stdout:gmatch("[^\r\n]+") do
            local temp = string.match(line, "Current GPU mode : (%a+)")
            if (temp ~= nil) then
                optimusMode = temp
            end
        end

        widget.icon:set_image(iconDir .. optimusMode .. ".svg")
    end
)

return widgetButton
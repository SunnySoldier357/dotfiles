local awful = require("awful")
local watch = require("awful.widget.watch")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local iconDir = require("gears.filesystem").get_configuration_dir() .. "layout/widgets/optimus/icons/"
local wibox = require("wibox")

local apps = require("configuration.apps")
local clickableContainer = require("layout.widgets.material.clickableContainer")

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
local function switchMode(mode)
    local mode = function()
        awful.spawn.with_shell("optimus-manager --switch " .. mode .. " --no-confirm")
    end

    return mode
end

local menu = awful.menu(
    {
        items =
        {
            { "Nvidia",switchMode("nvidia"),iconDir .. "nvidia.svg" },
            { "Hybrid", switchMode("hybrid"), iconDir .. "hybrid.svg" },
            { "Intel", switchMode("intel"), iconDir .. "intel.svg" }
        }
    }
)

widgetButton:buttons(gears.table.join(
    awful.button(
        { }, 1, nil,
        function()
            menu:toggle()
        end
    )
))

-- optimus-manager --status sample outputs
--
-- Optimus Manager (Client) version 1.2.2
--
-- Current GPU mode : intel
-- GPU mode requested for next login : nvidia
-- GPU mode for next startup : nvidia
-- Temporary config path: no

-- Run optimus-manager --status & get its output
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
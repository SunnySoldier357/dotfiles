local awful = require("awful")
local watch = require("awful.widget.watch")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local iconDir = require("gears.filesystem").get_configuration_dir() .. "layout/widgets/update/icons/"
local wibox = require("wibox")

local apps = require("configuration.apps")
local clickableContainer = require("layout.widgets.material.clickableContainer")

local updateAvailable = false
local numOfUpdatesAvailable

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

widgetButton:buttons(gears.table.join(
    awful.button(
        { }, 1, nil,
        function()
            if updateAvailable then
                awful.spawn.with_shell(apps.default.terminal ..
                    " sh -c 'yay -Syyuu; echo; echo Press Enter to exit.; read'")
            else
                awful.spawn.with_shell("pamac-manager")
            end
        end
    )
))

-- Alternative to naughty.notify - tooltip.
awful.tooltip(
    {
        objects = { widgetButton },
        mode = "outside",
        align = "right",
        timer_function =
            function()
                if updateAvailable then
                    local plural = numOfUpdatesAvailable == 1 and " update is " or " updates are "

                    return numOfUpdatesAvailable .. plural .. "available"
                else
                    return "We are up-to-date!"
                end
            end,
        preferred_positions = { "right", "left", "top", "bottom" }
    }
)

watch("pamac checkupdates", 60,
    function(_, stdout)
        numOfUpdatesAvailable = tonumber(stdout:match(".-\n"):match("%d*"))

        local widgetIconName
        if (numOfUpdatesAvailable ~= nil) then
            updateAvailable = true
            widgetIconName = "package-up"
        else
            updateAvailable = false
            widgetIconName = "package"
        end

        widget.icon:set_image(iconDir .. widgetIconName .. ".svg")
        collectgarbage("collect")
    end,
    widget
)

return widgetButton

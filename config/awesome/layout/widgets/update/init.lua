local awful = require("awful")
local watch = require("awful.widget.watch")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local iconDir = require("gears.filesystem").get_configuration_dir() .. "layout/widgets/update/icons/"
local wibox = require("wibox")

local apps = require("configuration.apps")
local clickable_container = require("layout.widgets.material.clickable_container")

local checkUpdateCmd = "zsh -c 'checkupdates | wc -l'"
local updateAvailable = false
local numOfUpdatesAvailable = 0

local widget = wibox.widget
{
    {
        id = "icon",
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}

widget.icon:set_image(iconDir .. "package.svg")

local widgetButton = clickable_container(widget)

widgetButton:buttons(gears.table.join(
    awful.button(
        { }, awful.button.names.LEFT, nil,
        function()
            if updateAvailable then
                awful.spawn.with_shell(apps.default.terminal ..
                    " sh -c 'yay -Syyuu; echo; echo Press Enter to exit.; read'")
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

watch(checkUpdateCmd, 60,
    function(_, stdout)
        numOfUpdatesAvailable = tonumber(stdout:match(".-\n"):match("%d*"))

        local widgetIconName
        if (numOfUpdatesAvailable == 0) then
            updateAvailable = false
            widgetIconName = "package"
        else
            updateAvailable = true
            widgetIconName = "package-up"
        end

        widget.icon:set_image(iconDir .. widgetIconName .. ".svg")
        collectgarbage("collect")
    end,
    widget
)

return widgetButton

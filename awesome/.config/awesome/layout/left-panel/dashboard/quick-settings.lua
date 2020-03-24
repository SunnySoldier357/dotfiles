local wibox = require("wibox")

local matListItem = require("widget.material.list-item")
local volumeSliderWidget = require("widget.volume.volume-slider")

return wibox.widget
{
    wibox.widget
    {
        wibox.widget
        {
            text = "Quick settings",
            font = "Roboto medium 12",
            widget = wibox.widget.textbox
        },
        widget = matListItem
    },
    volumeSliderWidget,
    layout = wibox.layout.fixed.vertical
}
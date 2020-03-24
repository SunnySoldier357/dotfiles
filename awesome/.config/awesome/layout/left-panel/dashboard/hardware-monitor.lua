local wibox = require("wibox")

local cpuMeterWidget = require("widget.cpu.cpu-meter")
local harddriveMeterWidget = require("widget.harddrive.harddrive-meter")
local matListItem = require("widget.material.list-item")
local ramMeterWidget = require("widget.ram.ram-meter")
local tempMeterWidget = require("widget.temperature.temperature-meter")

return wibox.widget
{
    wibox.widget
    {
        wibox.widget
        {
            text = "Hardware monitor",
            font = "Roboto medium 12",
            widget = wibox.widget.textbox
        },
        widget = matListItem
    },
    cpuMeterWidget,
    ramMeterWidget,
    tempMeterWidget,
    harddriveMeterWidget,
    layout = wibox.layout.fixed.vertical
}
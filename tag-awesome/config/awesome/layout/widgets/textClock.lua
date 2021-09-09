local awful = require("awful")
local wibox = require("wibox")

local function textClock(_screen)
    local textClockWidget = wibox.widget.textclock("%d/%m/%Y - %H:%M ")

    local monthCalendar = awful.widget.calendar_popup.month(
        {
            position = "br",
            screen = _screen,
            start_sunday = false,
        }
    )
    monthCalendar:attach(textClockWidget)

    return textClockWidget
end

return textClock

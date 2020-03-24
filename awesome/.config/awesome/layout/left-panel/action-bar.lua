local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")

local icons = require("theme.icons")
local batteryWidget = require("widget.battery")
local clickableContainer = require("widget.material.clickable-container")
local matIcon = require("widget.material.icon")
local tagList = require("widget.tag-list")

return function(screen, panel, actionBarWidth)
    -- Clock / Calendar 24h format
    local textclock = wibox.widget.textclock(
        "<span font='Roboto Mono bold 11'>%H\n%M</span>")

    -- Add a calendar (credits to kylekewley for the original code)
    local monthCalendar = awful.widget.calendar_popup.month(
        {
            screen = s,
            start_sunday = false,
            week_numbers = true
        }
    )

    monthCalendar:attach(textclock)

    local clockWidget = wibox.container.margin(textclock, dpi(13), dpi(13),
        dpi(8), dpi(8))

    local systray = wibox.widget.systray()
    systray:set_horizontal(false)
    systray:set_base_size(24)

    local menu_icon = wibox.widget
    {
        icon = icons.menu,
        size = dpi(24),
        widget = matIcon
    }

    local home_button = wibox.widget
    {
        wibox.widget
        {
            menu_icon,
            widget = clickableContainer
        },
        bg = beautiful.primary.hue_500,
        widget = wibox.container.background
    }

    home_button:buttons(
        gears.table.join(
            awful.button(
                {}, 1, nil,
                function()
                    panel:toggle()
                end
            )
        )
    )

    panel:connect_signal(
        "opened",
        function()
            menu_icon.icon = icons.close
        end
    )

    panel:connect_signal(
        "closed",
        function()
            menu_icon.icon = icons.menu
        end
    )

    return wibox.widget
    {
        id = "action_bar",
        layout = wibox.layout.align.vertical,
        forced_width = actionBarWidth,
        {
            -- Left widgets
            layout = wibox.layout.fixed.vertical,
            home_button,
            -- Create a taglist widget
            tagList(screen)
        },
        nil,
        {
            -- Right widgets
            layout = wibox.layout.fixed.vertical,
            wibox.container.margin(systray, dpi(10), dpi(10)),
            batteryWidget
        }
    }
end
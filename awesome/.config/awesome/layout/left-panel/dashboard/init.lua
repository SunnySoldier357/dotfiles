local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local wibox = require("wibox")

local hardwareMonitor = require("layout.left-panel.dashboard.hardware-monitor")
local quickSettings = require("layout.left-panel.dashboard.quick-settings")
local icons = require("theme.icons")
local matIcon = require("widget.material.icon")
local matListItem = require("widget.material.list-item")

return function(_, panel)
    local searchButton = wibox.widget
    {
        wibox.widget
        {
            icon = icons.search,
            size = dpi(24),
            widget = matIcon
        },
        wibox.widget
        {
            text = "Search Applications",
            font = "Roboto medium 13",
            widget = wibox.widget.textbox
        },
        clickable = true,
        widget = matListItem
    }

    searchButton:buttons(
        awful.util.table.join(
            awful.button(
                {}, 1,
                function()
                    panel:run_rofi()
                end
            )
        )
    )

    local exitButton = wibox.widget
    {
        wibox.widget
        {
            icon = icons.logout,
            size = dpi(24),
            widget = matIcon
        },
        wibox.widget
        {
            text = "End work session",
            font = "Roboto medium 13",
            widget = wibox.widget.textbox
        },
        clickable = true,
        divider = true,
        widget = matListItem
    }

    exitButton:buttons(
        awful.util.table.join(
            awful.button(
                {}, 1,
                function()
                    panel:toggle()
                    _G.exit_screen_show()
                end
            )
        )
    )

    return wibox.widget
    {
        layout = wibox.layout.align.vertical,
        {
            layout = wibox.layout.fixed.vertical,
            {
                searchButton,
                bg = beautiful.background.hue_800,
                widget = wibox.container.background
            },
            wibox.widget
            {
                orientation = "horizontal",
                forced_height = 1,
                opacity = 0.08,
                widget = wibox.widget.separator
            },
            quickSettings,
            hardwareMonitor
        },
        nil,
        {
            layout = wibox.layout.fixed.vertical,
            {
                exitButton,
                bg = beautiful.background.hue_800,
                widget = wibox.container.background
            }
        }
    }
end
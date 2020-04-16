local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local client = require("configuration.keybindings.client")

awful.rules.rules =
{
    -- All clients will match this rule.
    {
        rule = {},
        properties =
        {
            above = false,
            below = false,
            border_color = beautiful.border_normal,
            border_width = beautiful.border_width,
            buttons = client.buttons,
            floating = false,
            focus = awful.client.focus.filter,
            keys = client.keybindings,
            maximized = false,
            maximized_horizontal = false,
            maximized_vertical = false,
            ontop = false,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
            raise = true,
            screen = awful.screen.preferred,
            sticky = false
        }
    },
    -- Floating clients
    {
        rule_any =
        {
            class =
            {
                "Blueman-adapters",
                "Blueman-manager",
            },
            role =
            {
                "AlarmWindow",  -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",  -- e.g. Google Chrome's (detached) Developer Tools.
            },
            type =
            {
                "dialog"
            },
        },
        properties =
        {
            floating = true
        }
    },
    -- Dialogs
    {
        rule_any =
        {
            type = { "dialog" },
        },
        properties =
        {
            drawBackdrop = true,
            ontop = true,
            placement = awful.placement.centered,
            skip_decoration = true
        }
    }
}
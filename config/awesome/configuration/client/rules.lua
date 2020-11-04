local awful = require("awful")
local beautiful = require("beautiful")
local ruled = require("ruled")

ruled.client.connect_signal("request::rules",
    function()
        -- All clients will match this rule.
        ruled.client.append_rule {
            id = "global",
            rule = { },
            properties =
            {
                above = false,
                below = false,
                border_color = beautiful.border_normal,
                border_width = beautiful.border_width,
                floating = false,
                focus = awful.client.focus.filter,
                maximized = false,
                maximized_horizontal = false,
                maximized_vertical = false,
                ontop = false,
                placement = awful.placement.no_overlap + awful.placement.no_offscreen,
                raise = true,
                screen = awful.screen.preferred,
                sticky = false
            }
        }

        -- Floating clients.
        ruled.client.append_rule {
            id = "floating",
            rule_any =
            {
                instance = { "copyq" },
                class =
                {
                    "Android Emulator - *",
                    "Blueman-adapters",
                    "Blueman-manager",
                    "Emulator",
                    "Eog",
                    "Galculator",
                    "Gcolor3",
                },
                -- Note that the name property shown in xprop might be set slightly after creation of the client
                -- and the name shown there might not match defined rules here.
                name =
                {
                    "Event Tester",  -- xev.
                },
                role =
                {
                    "AlarmWindow",    -- Thunderbird's calendar.
                    "ConfigManager",  -- Thunderbird's about:config.
                    "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
                },
                type = { "dialog" },
            },
            properties = { floating = true }
        }

        -- Dialogs
        ruled.client.append_rule {
            id = "dialog",
            rule_any =
            {
                type = { "dialog" },
            },
            properties = {
                drawBackdrop = true,
                ontop = true,
                placement = awful.placement.centered,
                skip_decoration = true
            }
        }
    end
)
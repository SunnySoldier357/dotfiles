local awful = require("awful")
local gears = require("gears")

local clientButtons = require("configuration.client.buttons")
local clientKeys = require("configuration.client.keys")

-- Rules
awful.rules.rules =
{
    -- All clients will match this rule.
    {
        rule = {},
        properties =
        {
            above = false,
            below = false,
            buttons = clientButtons,
            floating = false,
            focus = awful.client.focus.filter,
            keys = clientKeys,
            maximized = false,
            maximized_horizontal = false,
            maximized_vertical = false,
            ontop = false,
            placement = awful.placement.no_offscreen,
            raise = true,
            screen = awful.screen.preferred,
            sticky = false,
        }
    },
    -- Titlebars
    {
        rule_any =
        {
            type = {"dialog"},
        },
        properties =
        {
            drawBackdrop = true,
            floating = true,
            ontop = true,
            placement = awful.placement.centered,
            shape = function()
                return function(cr, w, h)
                    gears.shape.rounded_rect(cr, w, h, 8)
                end
            end,
            skip_decoration = true,
            titlebars_enabled = false
        }
    }
}
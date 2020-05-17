local awful = require("awful")
local gears = require("gears")

local modKey = require("configuration.keybindings.mod").modKey

local buttons = gears.table.join(
    awful.button(
        { }, 1,
        function(_tag)
            _tag:view_only()
        end
    ),

    awful.button(
        { }, 3,
        awful.tag.viewtoggle
    ),

    awful.button(
        { }, 4,
        function(_tag)
            awful.tag.viewnext(_tag.screen)
        end
    ),
    awful.button(
        { }, 5,
        function(_tag)
            awful.tag.viewprev(_tag.screen)
        end
    ),

    awful.button(
        { modKey }, 1,
        function(_tag)
            if client.focus then
                client.focus:move_to_tag(_tag)
            end
        end
    ),

    awful.button(
        { modKey }, 3,
        function(_tag)
            if client.focus then
                client.focus:toggle_tag(_tag)
            end
        end
    )
)

return buttons
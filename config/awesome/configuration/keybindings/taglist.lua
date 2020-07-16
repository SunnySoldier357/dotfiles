local awful = require("awful")

local modKey = require("configuration.keybindings.mod").modKey

local buttons = {
    awful.button(
        { }, awful.button.names.LEFT,
        function(_tag)
            _tag:view_only()
        end
    ),

    awful.button(
        { }, awful.button.names.RIGHT,
        awful.tag.viewtoggle
    ),

    awful.button(
        { modKey }, awful.button.names.LEFT,
        function(_tag)
            if client.focus then
                client.focus:move_to_tag(_tag)
            end
        end
    ),

    awful.button(
        { modKey }, awful.button.names.RIGHT,
        function(_tag)
            if client.focus then
                client.focus:toggle_tag(_tag)
            end
        end
    )
}

return buttons
local awful = require("awful")

local keys = require("configuration.keybindings.keys")

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
        { keys.super }, awful.button.names.LEFT,
        function(_tag)
            if client.focus then
                client.focus:move_to_tag(_tag)
            end
        end
    ),

    awful.button(
        { keys.super }, awful.button.names.RIGHT,
        function(_tag)
            if client.focus then
                client.focus:toggle_tag(_tag)
            end
        end
    )
}

return buttons
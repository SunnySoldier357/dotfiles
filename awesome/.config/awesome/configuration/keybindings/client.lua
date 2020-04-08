local awful = require("awful")
local gears = require("gears")

local modKey = require("configuration.keybindings.mod").modKey
local altKey = require("configuration.keybindings.mod").altKey

local buttons = gears.table.join(
    awful.button(
        { }, 1,
        function (client)
            client:emit_signal("request::activate", "mouse_click", { raise = true })
        end
    ),

    awful.button(
        { altKey }, 1,
        function (client)
            client:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.move(client)
        end
    ),

    awful.button(
        { modKey }, 3,
        function (client)
            client:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.resize(client)
        end
    )
)

local keybindings = gears.table.join(
    awful.key(
        { modKey }, "f",
        function(client)
            client.fullscreen = not client.fullscreen
            client:raise()
        end,
        {
            description = "toggle fullscreen",
            group = "client"
        }
    ),

    awful.key(
        { modKey }, "o",
        function (client)
            client:move_to_screen()
        end,
        {
            description = "move to next screen",
            group = "client"
        }),
    
    awful.key(
        { modKey }, "q",
        function(client)
            client:kill()
        end,
        {
            description = "close",
            group = "client"
        }
    ),

    awful.key(
        { modKey, "Control" }, "Return",
        function (client)
            client:swap(awful.client.getmaster())
        end,
        {
            description = "move to master",
            group = "client"
        }
    )
)

return
{
    buttons = buttons,
    keybindings = keybindings
}
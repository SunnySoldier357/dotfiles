local awful = require("awful")

local modKey = require("configuration.keybindings.mod").modKey
local altKey = require("configuration.keybindings.mod").altKey

-- Client Mouse Keybindings
client.connect_signal("request::default_mousebindings",
    function()
        awful.mouse.append_client_mousebindings({
            awful.button(
                { }, awful.button.names.LEFT,
                function (client)
                    client:activate { context = "mouse_click" }
                end
            ),

            awful.button(
                { altKey }, awful.button.names.LEFT,
                function (client)
                    client:activate { context = "mouse_click", action = "mouse_move"  }
                end
            ),

            awful.button(
                { altKey }, awful.button.names.RIGHT,
                function (client)
                    client:activate { context = "mouse_click", action = "mouse_resize"}
                end
            )
        })
    end
)

-- Client Keybindings
client.connect_signal("request::default_keybindings",
    function()
        awful.keyboard.append_client_keybindings({
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
            ),

            awful.key(
                { modKey, "Control" }, "space",
                awful.client.floating.toggle,
                {
                    description = "toggle floating",
                    group = "client"
                }
            ),
        })
    end
)
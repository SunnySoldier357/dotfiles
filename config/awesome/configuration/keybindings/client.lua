local awful = require("awful")

local keys = require("configuration.keybindings.keys")

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
                { keys.alt }, awful.button.names.LEFT,
                function (client)
                    client:activate { context = "mouse_click", action = "mouse_move"  }
                end
            ),

            awful.button(
                { keys.alt }, awful.button.names.RIGHT,
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
                { keys.super }, "f",
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
                { keys.super }, "o",
                function (client)
                    client:move_to_screen()
                end,
                {
                    description = "move to next screen",
                    group = "client"
                }),
            
            awful.key(
                { keys.super }, "q",
                function(client)
                    client:kill()
                end,
                {
                    description = "close",
                    group = "client"
                }
            ),

            awful.key(
                { keys.super, keys.control }, keys.enter,
                function (client)
                    client:swap(awful.client.getmaster())
                end,
                {
                    description = "move to master",
                    group = "client"
                }
            ),

            awful.key(
                { keys.super, keys.control }, keys.space,
                awful.client.floating.toggle,
                {
                    description = "toggle floating",
                    group = "client"
                }
            ),
        })
    end
)
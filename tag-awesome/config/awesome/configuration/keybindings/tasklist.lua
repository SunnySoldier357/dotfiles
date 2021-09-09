local awful = require("awful")

local buttons = {
    awful.button(
        { }, awful.button.names.LEFT,
        function (_client)
            _client:activate
            {
                context = "tasklist",
                action = "toggle_minimization"
            }
        end
    ),

    awful.button(
        { }, awful.button.names.RIGHT,
        function()
            awful.menu.client_list({ theme = { width = 250 } })
        end
    )
}

return buttons
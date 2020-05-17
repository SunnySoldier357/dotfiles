local awful = require("awful")
local gears = require("gears")

local buttons = gears.table.join(
    awful.button(
        { }, 1,
        function (_client)
            if _client == client.focus then
                _client.minimized = true
            else
                _client:emit_signal("request::activate", "tasklist", { raise = true })
            end
        end
    ),

    awful.button(
        { }, 3,
        function()
            awful.menu.client_list({ theme = { width = 250 } })
        end
    ),
    
    awful.button(
        { }, 4,
        function()
            awful.client.focus.byidx(1)
        end
    ),
    awful.button(
        { }, 5,
        function()
            awful.client.focus.byidx(-1)
        end
    )
)

return buttons
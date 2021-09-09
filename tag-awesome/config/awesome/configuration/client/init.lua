local awful = require("awful")

require("configuration.client.rules")

client.connect_signal("manage",
    function(client)
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        if not awesome.startup then
            awful.client.setslave(client)
        end

        if awesome.startup and
            not client.size_hints.user_position and
            not client.size_hints.program_position then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(client)
        end
    end
)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter",
    function(client)
        client:activate { context = "mouse_enter", raise = false }
    end
)
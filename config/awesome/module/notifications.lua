local awful = require("awful")
local naughty = require("naughty")
local ruled = require("ruled")

--* Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error",
    function(message, startup)
        naughty.notification
        {
            urgency = "critical",
            title   = "Oops, an error happened" .. (startup and " during startup!" or "!"),
            message = message
        }
    end
)

ruled.notification.connect_signal("request::rules",
    function()
        -- All notifications will match this rule.
        ruled.notification.append_rule
        {
            rule = { },
            properties =
            {
                screen = awful.screen.preferred,
                implicit_timeout = 5,
            }
        }
    end
)

naughty.connect_signal("request::display",
    function(notif)
        naughty.layout.box { notification = notif }
    end
)
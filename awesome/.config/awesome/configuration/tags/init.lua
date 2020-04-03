local awful = require("awful")

awful.layout.layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating
}

awful.screen.connect_for_each_screen(
    function(s)
        -- Each screen has its own tag table.
        awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.suit.tile)
    end
)
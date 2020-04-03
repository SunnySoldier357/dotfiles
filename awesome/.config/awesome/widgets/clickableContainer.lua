local wibox = require("wibox")

local normalBg = "#FFFFFF00"
local mouseHoverBg = "#FFFFFF11"
local mouseClickBg = "#FFFFFF22"

function build(widget)
    local container = wibox.widget
    {
        widget,
        widget = wibox.container.background
    }

    local oldCursor
    local oldWibox

    container:connect_signal("mouse::enter",
        function()
            container.bg = mouseHoverBg

            local box = _G.mouse.current_wibox
            if box then
                oldCursor = box.cursor
                oldWibox = box
                box.cursor = "hand1"
            end
        end
    )

    container:connect_signal("mouse::leave",
        function()
            container.bg = normalBg

            if oldWibox then
                oldWibox.cursor = oldCursor
                oldWibox = nil
            end
        end
    )

    container:connect_signal("button::press",
        function()
            container.bg = mouseClickBg
        end
    )

    container:connect_signal("button::release",
        function()
            container.bg = mouseHoverBg
        end
    )

    return container
end

return build
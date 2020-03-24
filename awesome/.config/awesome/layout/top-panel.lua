local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")

local icons = require("theme.icons")
local clickableContainer = require("widget.material.clickable-container")
local matIcon = require("widget.material.icon")
local matIconButton = require("widget.material.icon-button")
local taskList = require("widget.task-list")

-- Clock / Calendar 24h format
local textclock = wibox.widget.textclock(
    "<span font='Roboto Mono bold 9'>%d/%m/%Y\n     %H:%M</span>")

-- Add a calendar (credits to kylekewley for the original code)
local monthCalendar = awful.widget.calendar_popup.month(
    {
        screen = s,
        start_sunday = false,
        week_numbers = true
    }
)
monthCalendar:attach(textclock)

local clockWidget = wibox.container.margin(textclock, dpi(13), dpi(13),
    dpi(8), dpi(8))

local addButton = matIconButton(matIcon(icons.plus, dpi(24)))
addButton:buttons(
    gears.table.join(
        awful.button(
            {}, 1, nil,
            function()
                awful.spawn(
                    awful.screen.focused().selected_tag.defaultApp,
                    {
                        tag = _G.mouse.screen.selected_tag,
                        placement = awful.placement.bottom_right
                    }
                )
            end
        )
    )
)

-- Create an imagebox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
local LayoutBox = function(s)
    local layoutBox = clickableContainer(awful.widget.layoutbox(s))
    layoutBox:buttons(
        awful.util.table.join(
            awful.button(
                {}, 1,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {}, 3,
                function()
                    awful.layout.inc(-1)
                end
            ),
            awful.button(
                {}, 4,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {}, 5,
                function()
                    awful.layout.inc(-1)
                end
            )
        )
    )
    return layoutBox
end

local TopPanel = function(s, offset)
    local offsetx = 0
    if offset == true then
        offsetx = dpi(48)
    end
    local panel = wibox(
        {
            ontop = true,
            screen = s,
            height = dpi(48),
            width = s.geometry.width - offsetx,
            x = s.geometry.x + offsetx,
            y = s.geometry.y,
            stretch = false,
            bg = beautiful.background.hue_800,
            fg = beautiful.fg_normal,
            struts =
            {
                top = dpi(48)
            }
        }
    )

    panel:struts(
        {
            top = dpi(48)
        }
    )

    panel:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            -- Create a taglist widget
            taskList(s),
            addButton
        },
        nil,
        {
            layout = wibox.layout.fixed.horizontal,
            -- Clock
            clockWidget,
            -- Layout box
            LayoutBox(s)
        }
    }

    return panel
end

return TopPanel
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local taglistButtons = require("configuration.keybindings.taglist")

local function taglist(_screen)
    -- Create a taglist widget
    local taglist = awful.widget.taglist
    {
        screen  = _screen,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglistButtons
    }

    -- and apply shape to it
    if beautiful.taglist_shape_container then
        local backgroundShapeWrapper = wibox.container.background(taglist)
        backgroundShapeWrapper._do_taglist_update_now = update
        backgroundShapeWrapper._do_taglist_update = taglist._do_taglist_update

        backgroundShapeWrapper.shape = beautiful.taglist_shape_container
        backgroundShapeWrapper.shape_clip = beautiful.taglist_shape_clip_container
        backgroundShapeWrapper.shape_border_width =
            beautiful.taglist_shape_border_width_container
        backgroundShapeWrapper.shape_border_color =
            beautiful.taglist_shape_border_color_container

        _screen.mytaglist = backgroundShapeWrapper
    end
end

return taglist
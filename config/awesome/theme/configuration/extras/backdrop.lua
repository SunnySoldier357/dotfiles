local awful = require("awful")
local gears = require("gears")
local lgi = require("lgi")
local wibox = require("wibox")

local function update_backdrop(backdrop, client)
    local cairo = lgi.cairo
    local geo = client.screen.geometry

    backdrop.x = geo.x
    backdrop.y = geo.y
    backdrop.width = geo.width
    backdrop.height = geo.height

    -- Create an image surface that is as large as the wibox
    local shape = cairo.ImageSurface.create(cairo.Format.A1, geo.width, geo.height)
    local cr = cairo.Context(shape)

    -- Fill with "completely opaque"
    cr.operator = "SOURCE"
    cr:set_source_rgba(1, 1, 1, 1)
    cr:paint()

    -- Remove the shape of the client
    local clientGeo = client:geometry()
    local clientShape = gears.surface(client.shape_bounding)
    cr:set_source_rgba(0, 0, 0, 0)
    cr:mask_surface(clientShape, clientGeo.x + client.border_width - geo.x,
        clientGeo.y + client.border_width - geo.y)
    clientShape:finish()

    backdrop.shape_bounding = shape._native
    shape:finish()
    backdrop:draw()
end

local function backdrop(client)
    local function update()
        update_backdrop(client.backdrop, client)
    end

    if not client.backdrop then
        client.backdrop = wibox
        {
            bg = "#00000054",
            ontop = true,
            type = "splash"
        }

        client.backdrop:buttons(
            gears.table.join(
                awful.button(
                    { }, 1,
                    function()
                        client:kill()
                    end
                )
            )
        )

        client:connect_signal("property::geometry", update)
        client:connect_signal("property::shape_client_bounding",
            function()
                gears.timer.delayed_call(update)
            end
        )
        client:connect_signal("unmanage",
            function()
                client.backdrop.visible = false
            end
        )
        client:connect_signal("property::shape_bounding",
            function()
                gears.timer.delayed_call(update)
            end
        )
    end

    update()
    client.backdrop.visible = true
end

client.connect_signal("manage",
    function(client)
        if client.drawBackdrop == true then
            backdrop(client)
        end
    end
)
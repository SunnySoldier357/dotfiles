local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local wibox = require("wibox")

local apps = require("configuration.apps")
local actionBar = require("layout.left-panel.action-bar")
local dashboard = require("layout.left-panel.dashboard")

local leftPanel = function(screen)
    local actionBarWidth = dpi(48)
    local panelContentWidth = dpi(400)

    local panel = wibox
    {
        screen = screen,
        width = actionBarWidth,
        height = screen.geometry.height,
        x = screen.geometry.x,
        y = screen.geometry.y,
        ontop = true,
        bg = beautiful.background.hue_800,
        fg = beautiful.fg_normal
    }

    panel.opened = false

    panel:struts(
        {
            left = actionBarWidth
        }
    )

    local backdrop = wibox
    {
        ontop = true,
        screen = screen,
        bg = "#00000000",
        type = "dock",
        x = screen.geometry.x,
        y = screen.geometry.y,
        width = screen.geometry.width,
        height = screen.geometry.height
    }

    function panel:run_rofi()
        _G.awesome.spawn(
            apps.default.rofi,
            false,
            false,
            false,
            false,
            function()
                panel:toggle()
            end
        )
    end

    local openPanel = function(should_run_rofi)
        panel.width = actionBarWidth + panelContentWidth
        backdrop.visible = true
        panel.visible = false
        panel.visible = true
        panel:get_children_by_id("panel_content")[1].visible = true
        if should_run_rofi then
            panel:run_rofi()
        end
        panel:emit_signal("opened")
    end

    local closePanel = function()
        panel.width = actionBarWidth
        panel:get_children_by_id("panel_content")[1].visible = false
        backdrop.visible = false
        panel:emit_signal("closed")
    end

    function panel:toggle(should_run_rofi)
        self.opened = not self.opened
        if self.opened then
            openPanel(should_run_rofi)
        else
            closePanel()
        end
    end

    backdrop:buttons(
        awful.util.table.join(
            awful.button(
                {}, 1,
                function()
                    panel:toggle()
                end
            )
        )
    )

    panel:setup
    {
        layout = wibox.layout.align.horizontal,
        nil,
        {
            id = "panel_content",
            bg = beautiful.background.hue_900,
            widget = wibox.container.background,
            visible = false,
            forced_width = panelContentWidth,
            {
                dashboard(screen, panel),
                layout = wibox.layout.stack
            }
        },
        actionBar(screen, panel, actionBarWidth)
    }
    return panel
end

return leftPanel
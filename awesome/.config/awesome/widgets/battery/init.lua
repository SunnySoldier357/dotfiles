-------------------------------------------------
-- Battery Widget for Awesome Window Manager
-- Shows the battery status using the ACPI tool
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/battery-widget

-- @author Pavel Makhov
-- @copyright 2017 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local watch = require("awful.widget.watch")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local naughty = require("naughty")
local wibox = require("wibox")

local clickableContainer = require("widgets.clickableContainer")
local iconDir = require("gears.filesystem").get_configuration_dir() .. "widgets/battery/icons/"

local lastBatteryCheck = os.time()

local widget = wibox.widget
{
    {
        id = "icon",
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.fixed.horizontal
}

local widgetButton = clickableContainer(widget)

widgetButton:buttons(gears.table.join(
    awful.button(
        { }, 1, nil,
        function()
            awful.spawn("powerkit --config")
        end
    )
))

local batteryTooltip = awful.tooltip(
    {
        objects = { widgetButton },
        mode = "outside",
        align = "left",
        preferred_positions = { "right", "left", "top", "bottom" }
    }
)

local function showBatteryWarning()
    naughty.notify
    {
        bg = "#D32F2F",
        fg = "#EEE9EF",
        hover_timeout = 0.5,
        icon = iconDir .. "battery-alert.svg",
        icon_size = dpi(48),
        position = "bottom_right",
        text = "Please charge the device",
        timeout = 5,
        title = "Battery is dying",
        width = 248
    }
end

watch("acpi -i", 1,
    function(_, stdout)
        local batteryIconName = "battery"
        local batteryInfo = {}
        local capacities = {}

        -- acpi sample outputs
        -- Battery 0: Discharging, 75%, 01:51:38 remaining
        -- Battery 0: Charging, 53%, 00:57:43 until charged

        for s in stdout:gmatch("[^\r\n]+") do
            local status, chargeStr, time = string.match(s, ".+: (%a+), (%d?%d?%d)%%,?.*")
            if status ~= nil then
                table.insert(batteryInfo, { status = status, charge = tonumber(chargeStr) })
            else
                local capStr = string.match(s, ".+:.+last full capacity (%d+)")
                table.insert(capacities, tonumber(capStr))
            end
        end

        local capacity = 0
        for _, cap in ipairs(capacities) do
            capacity = capacity + cap
        end

        local charge = 0
        local status
        for i, batt in ipairs(batteryInfo) do
            if batt.charge >= charge then
                status = batt.status -- use most charged battery status
            -- this is arbitrary, and maybe another metric should be used
            end

            charge = charge + batt.charge * capacities[i]
        end
        charge = charge / capacity

        if (charge >= 0 and charge < 15) then
            if status ~= "Charging" and os.difftime(os.time(), lastBatteryCheck) > 300 then
                -- if 5 minutes have elapsed since the last warning
                lastBatteryCheck = _G.time()

                showBatteryWarning()
            end
        end

        if status == "Charging" or status == "Full" then
            batteryIconName = batteryIconName .. "-charging"
        end

        local roundedCharge = math.floor(charge / 10) * 10
        if (roundedCharge == 0) then
            batteryIconName = batteryIconName .. "-outline"
        elseif (roundedCharge ~= 100) then
            batteryIconName = batteryIconName .. "-" .. roundedCharge
        end

        widget.icon:set_image(iconDir .. batteryIconName .. ".svg")

        -- Update tooltip text
        batteryTooltip.text = string.gsub(stdout, "\n$", "")
        collectgarbage("collect")
    end,
    widget
)

return widgetButton
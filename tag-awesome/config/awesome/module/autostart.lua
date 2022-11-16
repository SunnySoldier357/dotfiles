-- MODULE autostart
-- Run all the apps listed in configuration/apps.lua as autostart only
--     once when awesome start

local awful = require("awful")
local configDir = require("gears.filesystem").get_configuration_dir()

local apps = require("configuration.apps")

local autostart =
{
    "numlockx on", -- Enable numlock
    "xbindkeys --file $XDG_CONFIG_HOME/xbindkeys/config &", -- Disable middle click pasting
    "/usr/lib/geoclue-2.0/demos/agent", -- Geolocation for redshift
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1", -- GUI authentication agent

    "autorandr --change && nitrogen --restore",
    "picom -b",

    -- "libinput-gestures-setup start",

    "blueman-applet", -- BLuetooth
    "cbatticon --update-interval 20 --command-critical-level 'systemctl hibernate' --low-level 15",
    "nm-applet", -- Wifi
    -- "indicator-kdeconnect", --KDEConnect

    "pcmanfm --daemon-mode" -- Start PCManFM as a daemon to automatically mount removable media
}

local function runOnce(cmd)
    local findme = cmd
    local firstspace = cmd:find(" ")
    if firstspace then
        findme = cmd:sub(0, firstspace - 1)
    end
    awful.spawn.with_shell(
        string.format("pgrep --euid $USER --exact %s > /dev/null || (%s)", findme, cmd))
end

for _, app in ipairs(autostart) do
    runOnce(app)
end

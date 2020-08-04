-- MODULE autostart
-- Run all the apps listed in configuration/apps.lua as autostart only
--     once when awesome start

local awful = require("awful")
local configDir = require("gears.filesystem").get_configuration_dir()

local apps = require("configuration.apps")

local autostart =
{
    -- Add applications that need to be killed between reloads
    -- to avoid multipled instances, inside the awspawn script
    configDir .. "configuration/awspawn", -- Spawn "dirty" apps that can linger between sessions

    "libinput-gestures-setup start",
    "xss-lock -- " .. apps.default.lock,

    "picom --experimental-backends --config " .. configDir ..
        "configuration/picom.conf",

    "redshift-gtk", -- Night Light
    "nm-applet", -- Wifi
    "blueman-applet", -- BLuetooth
    "copyq", -- Clipboard Manager

    "xbindkeys -f ~/.config/xbindkeysrc", -- Disable middle click pasting

    "numlockx on", -- Enable numlock
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1" -- GUI authentication agent
}

local function runOnce(cmd)
    local findme = cmd
    local firstspace = cmd:find(" ")
    if firstspace then
        findme = cmd:sub(0, firstspace - 1)
    end
    awful.spawn.with_shell(
        string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
end

for _, app in ipairs(autostart) do
    runOnce(app)
end
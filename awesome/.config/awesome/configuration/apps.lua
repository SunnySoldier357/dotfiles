local beautiful = require("beautiful")
local configDir = require("gears.filesystem").get_configuration_dir()

-- Make rofi dpi aware (github:jo148)
local with_dpi = beautiful.xresources.apply_dpi
local get_dpi = beautiful.xresources.get_dpi
local rofi_command =
    "rofi -dpi " .. get_dpi() ..
    " -width " .. with_dpi(800) ..
    " -theme " .. configDir .. "configuration/rofi.rasi"

return
{
    default =
    {
        -- List of defaults applications
        browser = "brave",
        editor = "kate",
        filemanager = "index",
        game = "steam",
        ide = "code",
        lock = "light-locker",
        music = "cantata",
        social = "caprine",
        terminal = "kitty",

        -- Rofi
        activeClients = rofi_command .. " -show window",
        launcher = rofi_command .. " -show drun",
        runner = rofi_command .. " -show run",

        -- Screenshot
        screenshotDesktop = configDir .. "scripts/screenshot -m",
        screenshotRegion = configDir .. "scripts/screenshot -r",
        screenshotWindow = configDir .. "scripts/screenshot -a"
    },

    -- List of apps to start once on start-up
    autostart =
    {
        "light-locker",

        "picom --experimental-backends --config " .. configDir ..
            "configuration/picom.conf",

        "nm-applet", -- Wifi
        "blueman-applet", -- BLuetooth
        "powerkit", -- Power Manager

        "numlockx on", -- Enable numlock
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1", -- GUI authentication agent

        -- Add applications that need to be killed between reloads
        -- to avoid multipled instances, inside the awspawn script
        configDir .. "configuration/awspawn" -- Spawn "dirty" apps that can linger between sessions
    }
}
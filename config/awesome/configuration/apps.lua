local beautiful = require("beautiful")
local configDir = require("gears.filesystem").get_configuration_dir()

-- Make rofi dpi aware (github:jo148)
local getDpi = beautiful.xresources.get_dpi
local withDpi = beautiful.xresources.apply_dpi
local rofiCommand =
    "rofi -dpi " .. getDpi() ..
    " -width " .. withDpi(800)

local lockCommand = "i3lock-fancy -f Open-Sans-SemiBold"

return
{
    default =
    {
        -- List of defaults applications
        browser = "brave",
        browserPrivate = "brave --incognito",
        editor = "kate",
        filemanager = "nautilus -w",
        game = "steam",
        ide = "code",
        lock = lockCommand,
        music = "cantata",
        social = "caprine",
        terminal = "kitty",

        -- Rofi
        activeClients = rofiCommand .. " -show window" ..
            " -theme " .. configDir .. "configuration/rofi/windows.rasi",
        launcher = rofiCommand .. " -show drun" ..
            " -theme " .. configDir .. "configuration/rofi/launcher.rasi",
        runner = rofiCommand .. " -show run" ..
            " -theme " .. configDir .. "configuration/rofi/runner.rasi",

        -- Screenshot
        screenshotDesktop = configDir .. "scripts/screenshot -m",
        screenshotRegion = configDir .. "scripts/screenshot -r",
        screenshotWindow = configDir .. "scripts/screenshot -a"
    },

    -- List of apps to start once on start-up
    autostart =
    {
        -- Add applications that need to be killed between reloads
        -- to avoid multipled instances, inside the awspawn script
        configDir .. "configuration/awspawn", -- Spawn "dirty" apps that can linger between sessions

        "libinput-gestures-setup start",
        "xss-lock -- " .. lockCommand,

        "picom --experimental-backends --config " .. configDir ..
            "configuration/picom.conf",

        "redshift-gtk", -- Night Light
        "nm-applet", -- Wifi
        "blueman-applet", -- BLuetooth

        "numlockx on", -- Enable numlock
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1" -- GUI authentication agent
    }
}
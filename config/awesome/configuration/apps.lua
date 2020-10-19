local beautiful = require("beautiful")
local configDir = require("gears.filesystem").get_configuration_dir()

-- Make rofi dpi aware (github:jo148)
local getDpi = beautiful.xresources.get_dpi
local withDpi = beautiful.xresources.apply_dpi
local rofiCommand =
    "rofi -dpi " .. getDpi() ..
    " -width " .. withDpi(800)

return
{
    default =
    {
        -- List of defaults applications
        browser = "brave",
        browserPrivate = "brave --incognito",
        editor = "kate",
        filemanager = "pcmanfm -n",
        game = "steam",
        ide = "code",
        lock = "i3lock-fancy -f Open-Sans-SemiBold",
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
    }
}
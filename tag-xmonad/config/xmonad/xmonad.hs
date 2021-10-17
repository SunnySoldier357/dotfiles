-- Default configuration from https://xmonad.org/TUTORIAL.html

import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Layout.Magnifier
import XMonad.Layout.Renamed
import XMonad.Layout.ThreeColumns

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce
import XMonad.Util.Ungrab

main :: IO ()
main = xmonad
    . ewmhFullscreen
    . ewmh
    . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
    $ myConfig

myConfig = def
    {
        modMask = mod4Mask,   -- Rebind Mod to the super key
        layoutHook = myLayout, -- Use custom layouts
        manageHook = myManageHook, -- Match on certain windows
        startupHook = myStartup,
        terminal = "kitty"
    }
    `additionalKeysP`
    [
        ("M-S-z", spawn "xscreensaver-command -lock"),
        ("M-S-=", unGrab *> spawn "scrot -s"),
        ("M-]"  , spawn "brave")
    ]

myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
    where
        threeCol = renamed [Replace "ThreeCol"]
            $ magnifiercz' 1.3
            $ ThreeColMid nmaster delta ratio
        tiled    = Tall nmaster delta ratio
        nmaster  = 1     -- Default number of windows in the master pane
        ratio    = 1/2   -- Default proportion of screen occupied by master pane
        delta    = 3/100 -- Percent of screen to increment by when resizing panes

myStartup = do
    spawnOnce "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --tint 0x5f5f5f --height 18 &"
    spawnOnce "xsetroot -cursor_name left_ptr"
    spawnOnce "feh --bg-fill --no-fehbg ~/Pictures/Wallpapers/'3019 - City of Bright Lights.jpg'"
    spawnOnce "xscreensaver -no-splash &"
    spawnOnce "xfce4-power-manager &"
    spawnOnce "nm-applet --sm-disable &"

myManageHook :: ManageHook
myManageHook = composeAll
    [
        className =? "Gimp" --> doFloat,
        isDialog            --> doFloat
    ]

myXmobarPP :: PP
myXmobarPP = def
    {
        ppSep             = magenta " • ",
        ppTitleSanitize   = xmobarStrip,
        ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2,
        ppHidden          = white . wrap " " "",
        ppHiddenNoWindows = lowWhite . wrap " " "",
        ppUrgent          = red . wrap (yellow "!") (yellow "!"),
        ppOrder           = \[ws, l, _, wins] -> [ws, l, wins],
        ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""
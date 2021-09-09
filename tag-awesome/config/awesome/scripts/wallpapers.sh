if [[ -z "$(xrandr | grep 'DVI-I-1-1')" ]]; then
    DVI="DVI-I-2-1"
else
    DVI="DVI-I-1-1"
fi

if [[ -z "$(xrandr | grep 'HDMI-1-1')" ]]; then
    HDMI="HDMI-1"
else
    HDMI="HDMI-1-1"
fi

if [[ -z "$(xrandr | grep 'eDP-1-1')" ]]; then
    eDP="eDP-1"
else
    eDP="eDP-1-1"
fi

Wallpaper16_9="/home/sandeepsingh/Pictures/Wallpapers/3019 - City of Bright Lights (2560x1440).jpg"
Wallpaper16_10="/home/sandeepsingh/Pictures/Wallpapers/3019 - City of Bright Lights (2560x1600).jpg"

xwallpaper --daemon \
    --output "$HDMI" --maximize "$Wallpaper16_10" \
    --output "$DVI" --maximize "$Wallpaper16_10" \
    --output "$eDP" --maximize "$Wallpaper16_9"
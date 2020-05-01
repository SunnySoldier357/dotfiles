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

xrandr --output $eDP --off \
    --output $HDMI --primary --mode 1680x1050 --pos 0x0 --rotate normal \
    --output $DVI --mode 1680x1050 --pos 1680x152 --rotate normal ||\

    xrandr --output $eDP --primary --mode 1920x1080 --pos 0x0 --rotate normal \
        --output $HDMI --off \
        --output $DVI --off

unset DVI
unset HDMI
unset eDP
numlockx on # Enable numlock
# xbindkeys --file $XDG_CONFIG_HOME/xbindkeys/config & # Disable middle click pasting
# xfce4-power-manager &
# xsetroot -cursor_name left_ptr
# /usr/lib/geoclue-2.0/demos/agent # Geolocation for redshift
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 # GUI authentication agent

autorandr --change && nitrogen --restore
picom --experimental-backends -b

blueman-applet &
nm-applet --sm-disable &
volumeicon &

pcmanfm --daemon-mode
#!/usr/bin/env bash

# Set up monitors
~/.screenlayout/apartment.sh

# Enable numlock
numlockx on

# GUI authentication agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

nitrogen --restore
picom -b

blueman-applet &
nm-applet --sm-disable &
volumeicon &
cbatticon &

# Start PCManFM as a daemon to automatically mount removable media
pcmanfm --daemon-mode &
#!/bin/bash

# MAIN
echo "Uninstalling Guomak"

rm -rf /usr/share/X11/xkb/*
cp -R xkb_clean/* /usr/share/X11/xkb

rm /etc/default/keyboard
cp etc_default_keyboard_colemak /etc/default/keyboard

function gset {
    gsettings set "org.gnome.${1}" "$2" "$3"
}

function gsetd {
    gset "desktop.${1}" "$2" "$3"
}

# Keyboard
gsetd input-sources mru-sources "[('xkb', 'us+colemak')]"
gsetd input-sources sources "[('xkb', 'us+colemak')]"

echo "Success"

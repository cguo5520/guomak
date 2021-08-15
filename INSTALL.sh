#!/bin/bash

# MAIN
echo "Installing Guomak"

rm -rf /usr/share/X11/xkb/*
cp -R xkb_guomak/* /usr/share/X11/xkb

rm /etc/default/keyboard
cp etc_default_keyboard_guomak /etc/default/keyboard

function gset {
    gsettings set "org.gnome.${1}" "$2" "$3"
}

function gsetd {
    gset "desktop.${1}" "$2" "$3"
}

# Keyboard
gsetd input-sources mru-sources "[('xkb', 'us+guomak')]"
gsetd input-sources sources "[('xkb', 'us+guomak')]"

echo "Success"

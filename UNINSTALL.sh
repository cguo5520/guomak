#!/bin/bash

# MAIN
echo "Uninstalling Guomak"

rm -rf /usr/share/X11/xkb/*
cp -R xkb_clean/* /usr/share/X11/xkb

rm /etc/default/keyboard
cp etc_default_keyboard_colemak /etc/default/keyboard

echo "Success"

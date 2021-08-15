#!/bin/bash

# MAIN
echo "Installing Guomak"

rm -rf /usr/share/X11/xkb/*
cp -R xkb_guomak/* /usr/share/X11/xkb

rm /etc/default/keyboard
cp etc_default_keyboard_guomak /etc/default/keyboard

echo "Success"

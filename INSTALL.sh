#!/bin/bash

# MAIN
echo "Installing Guomak"

rm -rf /usr/share/X11/xkb/*
cp -R xkb_guomak/* /usr/share/X11/xkb

rm -rf /usr/share/X11/xkb/symbols
cp -R xkb_clean_with_guomak/symbols /usr/share/X11/xkb/symbols
rm /usr/share/X11/xkb/symbols/us
cp -R xkb_guomak/symbols/us /usr/share/X11/xkb/symbols/us

rm -rf /usr/share/X11/xkb/compat
cp -R xkb_clean_with_guomak/compat /usr/share/X11/xkb/compat

#find /usr/share/X11/xkb/symbols -name 'a*' -delete
#find /usr/share/X11/xkb/symbols -name 'b*' -delete
#find /usr/share/X11/xkb/symbols -name 'c*' -delete
#find /usr/share/X11/xkb/symbols -name 'd*' -delete
#find /usr/share/X11/xkb/symbols -name 'e*' -delete
#find /usr/share/X11/xkb/symbols -name 'f*' -delete
###find /usr/share/X11/xkb/symbols -name 'g*' -delete
#find /usr/share/X11/xkb/symbols -name 'h*' -delete
#find /usr/share/X11/xkb/symbols -name 'i*' -delete
#find /usr/share/X11/xkb/symbols -name 'j*' -delete
#find /usr/share/X11/xkb/symbols -name 'k*' -delete
###find /usr/share/X11/xkb/symbols -name 'l*' -delete
#find /usr/share/X11/xkb/symbols -name 'm*' -delete
#find /usr/share/X11/xkb/symbols -name 'n*' -delete

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

# guomak
Modified Colemak Linux for Developers

## Linux
To install:
```
cd guomak
sudo bash INSTALL.sh
```

To uninstall:
```
cd guomak
sudo bash UNINSTALL.sh
```

### Debugging

See the xkb dir:
```
cd /usr/share/X11/xkb
```

To see what the current settings are:
```
setxkbmap -print -verbose 10
```

To print keyboard map as a PDF:
```
setxkbmap guomak -print | xkbcomp - - | xkbprint - - | ps2pdf - > map_keyboard.pdf
```

### XKB quickstart
* Compat (usually complete) has the modifier map

## Mac
Generate karabiner.json with `cd mac; node karabiner.generator`
Install karabiner, then move the karabiner.json file to ~/.config/karabiner/karabiner.json

TODO:
Unit tests with test files
Installing and then uninstalling creates empty lines
Polish up the mac setup. Probably need to add level2?

## FAQ
Can I restart my keyboard without restarting my computer/display manager?

I don't think so. I think you would have to restart the display to do so. Most threads I've seen say that Wayland breaks hot-reloading X Server.

This does not work:
```
udevadm trigger --subsystem-match=input --action=change
```

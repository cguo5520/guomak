# guomak
Modified Colemak Linux for Developers

## Linux
To install:
```
cd guomak
sudo bash INSTALL.sh

# restart your keyboard with
sudo udevadm trigger --subsystem-match=input --action=change
```

To uninstall:
```
cd guomak
sudo bash UNINSTALL.sh
```

## Mac
Generate karabiner.json with `cd mac; node karabiner.generator`
Install karabiner, then move the karabiner.json file to ~/.config/karabiner/karabiner.json

TODO:
Unit tests with test files
Installing and then uninstalling creates empty lines
Polish up the mac setup. Probably need to add level2?
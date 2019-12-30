#!/bin/bash

# needs one filename arg
function fileHasGuomak {
    guomakCount="$(grep --count 'guomak' $1)"
    hasGuomak="$((guomakCount < 1))"
    return $hasGuomak
}

function installEvdev {
    xRulesEvdev='/usr/share/X11/xkb/rules/evdev.xml'
    
    if fileHasGuomak "$xRulesEvdev"
    then
        # Do nothing
        echo "Already installed in rules. Skipping"
    else
        echo 'Installing in rules'
        
        # Replace dvorak intl as a hack to make this more robust (hopefully)
        originalName='<name>dvorak-intl<\/name>'
        newName='<name>guomak<\/name>'
        
        # / and . need escaping. Parens do not
        originalDesc='<description>English (Dvorak, intl\., with dead keys)<\/description>'
        newDesc='<description>English (Guomak)<\/description>'
        
        # use + as delimeter because text contains /
        # -i means edit in place
        sed -i "s+${originalName}+${newName}+" "$xRulesEvdev"
        sed -i "s+${originalDesc}+${newDesc}+" "$xRulesEvdev"
    fi
}

function installSymbols {
    gSymbols='/usr/share/X11/xkb/symbols/guomak'
    cp 'symbols_guomak' "$gSymbols"
    
    xSymbolsUs='/usr/share/X11/xkb/symbols/us'
    
    if fileHasGuomak "$xSymbolsUs"
    then
        # Do nothing
        echo "Already installed in symbols. Skipping"
    else
        echo 'Installing in us'
        
        echo -e '\n// Guomak symbols modified to include an additional layer for software development\n// modified from 2006-01-01 Shai Coleman, http://colemak.com/\n// created 2019-12-09 Charles Guo\npartial alphanumeric_keys xkb_symbols "guomak" { include "guomak(guomak)" };\n' >> "$xSymbolsUs"
    fi
}

function installTypes {
    gTypes='/usr/share/X11/xkb/types/guomak'
    cp 'types_guomak' "$gTypes"
    
    xTypes='/usr/share/X11/xkb/types/complete'
    
    if fileHasGuomak "$xTypes"
    then
        # Do nothing
        echo "Already installed in types. Skipping"
    else
        echo 'Installing in types/complete'
        numpadPattern='numpad'
        # cut off everything except for the line number
        numpadLine="$(grep -n $numpadPattern $xTypes | cut -f1 -d: )"
        # escape spaces
        includeGuomak='\ \ \ \ include "guomak"'
        sed -i "$numpadLine a ${includeGuomak}" "$xTypes"
    fi
}

# MAIN
echo "Installing Guomak"

installSymbols
installTypes
installEvdev

# Restart keyboard
udevadm trigger --subsystem-match=input --action=change
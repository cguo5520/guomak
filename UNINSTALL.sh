#!/bin/bash

# needs one filename arg
function fileHasGuomak {
    guomakCount="$(grep --count 'guomak' $1)"
    hasGuomak="$((guomakCount < 1))"
    return $hasGuomak
}

function uninstallEvdev {
    xRulesEvdev='/usr/share/X11/xkb/rules/evdev.xml'
    
    if fileHasGuomak "$xRulesEvdev"
    then
        echo 'Uninstalling in rules'
        
        replacedName='<name>guomak<\/name>'
        originalName='<name>dvorak-intl<\/name>'
        
        replacedDesc='<description>English (Guomak)<\/description>'
        originalDesc='<description>English (Dvorak, intl\., with dead keys)<\/description>'
        
        # use + as delimeter because text contains /
        # -i means edit in place
        sed -i "s+${replacedName}+${originalName}+" "$xRulesEvdev"
        sed -i "s+${replacedDesc}+${originalDesc}+" "$xRulesEvdev"
    else
        echo "Not installed in rules. Skipping"
        # Do nothing
    fi
}

function uninstallSymbols {
    gSymbols='/usr/share/X11/xkb/symbols/guomak'
    rm "$gSymbols"
    
    xSymbolsUs='/usr/share/X11/xkb/symbols/us'
    
    if fileHasGuomak "$xSymbolsUs"
    then
        echo 'Uninstalling in us'
        
        # only capital Guomak is in the first line
        guomakPattern='Guomak'
        
        guomakStartLine="$(grep -n $guomakPattern $xSymbolsUs | cut -f1 -d: )"
        guomakEndLine=$((guomakStartLine + 4))
        
        # delete from start to end
        sed -i "${guomakStartLine},${guomakEndLine}d" "$xSymbolsUs"
    else
        # Do nothing
        echo "Not installed in symbols. Skipping"
    fi
}

function uninstallTypes {
    gTypes='/usr/share/X11/xkb/types/guomak'
    rm "$gTypes"
    
    xTypes='/usr/share/X11/xkb/types/complete'
    
    if fileHasGuomak "$xTypes"
    then
        echo 'Uninstalling in types/complete'
        
        # cut off everything except for the line number
        numpadLine="$(grep -n guomak $xTypes | cut -f1 -d: )"
        sed -i "${numpadLine}d" "$xTypes"
    else
        # Do nothing
        echo "Already installed in types. Skipping"
    fi
}

# MAIN
echo "Uninstalling Guomak"

uninstallSymbols
uninstallTypes
uninstallEvdev

# Restart keyboard
udevadm trigger --subsystem-match=input --action=change

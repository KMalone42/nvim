#!/usr/bin/env bash


ON_FLAG=false
SELECTION="$1"

case "$SELECTION" in
    on)
        $ON_FLAG = true
        ;;
    off)
        $ON_FLAG = false
        ;;
    *)
        echo "Unknown toggle: ${SELECTION}"
        exit 1
        ;;
esac

if [[ $ON_FLAG == true ]]; then
    mv "nvim/lua/plugins/mason.lua.disabled" "nvim/lua/plugins/mason.lua"
else
    mv "nvim/lua/plugins/mason.lua" "nvim/lua/plugins/mason.lua.disabled" 
fi

#!/usr/bin/env bash

set -euo pipefail

CONFIG_FILE="nvim/lua/plugins/mason.lua"
DISABLED_FILE="nvim/lua/plugins/mason.lua.disabled"

if [[ $# -ne 1 ]]; then
   echo "Usage: $0 on|off"
   exit 1
fi

case "$1" in
   on)
       if [[ -f "$DISABLED_FILE" ]]; then
           mv "$DISABLED_FILE" "$CONFIG_FILE"
           echo "Enabled: $CONFIG_FILE"
       elif [[ -f "$CONFIG_FILE" ]]; then
           echo "$CONFIG_FILE is already enabled"
       else
           echo "Error: $CONFIG_FILE does not exist"
           exit 1
       fi
       ;;
   off)
       if [[ -f "$CONFIG_FILE" ]]; then
           mv "$CONFIG_FILE" "$DISABLED_FILE"
           echo "Disabled: $CONFIG_FILE -> $DISABLED_FILE"
       elif [[ -f "$DISABLED_FILE" ]]; then
           echo "Error: $DISABLED_FILE already enabled, use 'on' to re-enable first"
           exit 1
       else
           echo "Error: $CONFIG_FILE does not exist to disable"
           exit 1
       fi
       ;;
   *)
       echo "Unknown toggle: $1 (use on|off)"
       exit 1
       ;;
esac

#!/usr/bin/env bash

CONF="$HOME/.config/cava/panel.conf"
LATEST="/tmp/cava-latest"

pkill -f "cava -p $CONF" 2>/dev/null

cava -p "$CONF" 2>/dev/null |
while IFS= read -r line; do
    printf '%s\n' "$line" > "$LATEST"
done

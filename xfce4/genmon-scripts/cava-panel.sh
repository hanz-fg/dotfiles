#!/usr/bin/env bash

FILE="/tmp/cava-latest"
BLOCKS=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)

COLORS=(
    "#00d7ff"
    "#00e5ff"
    "#00ffaa"
    "#7cff00"
    "#d7ff00"
    "#ffd700"
    "#ff9d00"
    "#ff5f00"
    "#ff4500"
    "#ff3366"
    "#cc33ff"
    "#7f5fff"
)

frame=$(cat "$FILE" 2>/dev/null)

IFS=';' read -ra vals <<< "$frame"

bars=""

for i in {0..11}; do
    n="${vals[$i]:-0}"

    [[ "$n" =~ ^[0-7]$ ]] || n=0

    bars+="<span foreground=\"${COLORS[$i]}\">${BLOCKS[$n]}</span>"
done

echo "<txt>$bars</txt>"
echo "<tool>Live audio spectrum</tool>"
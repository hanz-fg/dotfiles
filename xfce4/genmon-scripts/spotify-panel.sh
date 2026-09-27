#!/usr/bin/env bash

readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if pidof spotify &> /dev/null; then

    ARTIST=$(bash "${DIR}/spotify.sh" artist | sed 's/&/&#38;/g')
    TITLE=$(bash "${DIR}/spotify.sh" title | sed 's/&/&#38;/g')
    ALBUM=$(bash "${DIR}/spotify.sh" album | sed 's/&/&#38;/g')

    ARTIST_TITLE="${ARTIST} - ${TITLE}"

    # Limit title length
    MAX_CHARS=52

    if [ "${#ARTIST_TITLE}" -gt "$MAX_CHARS" ]; then
        ARTIST_TITLE="${ARTIST_TITLE:0:$MAX_CHARS} …"
    fi

    # Find existing Spotify window
    WINDOW_ID=$(wmctrl -lx | grep -i spotify | head -n1 | awk '{print $1}')

    if [ -n "$WINDOW_ID" ]; then
        CLICK="wmctrl -ia $WINDOW_ID"
    else
        CLICK="spotify"
    fi
    # XFCE GenMon output
    echo "<txt>${ARTIST_TITLE}</txt>"
    echo "<click>${CLICK}</click>"
    echo "<tool>Artist: ${ARTIST}
Album: ${ALBUM}
Title: ${TITLE}

Click to open Spotify</tool>"

else
    echo "<txt>Spotify</txt>"
    echo "<click>spotify</click>"
    echo "<tool>Click to open Spotify</tool>"
fi

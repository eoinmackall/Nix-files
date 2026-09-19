#!/usr/bin/env bash

# 1. Choose Mode
MODE=$(echo -e "Region\nWindow\nFull Screen" | noctalia dmenu -p "Screenshot Mode")
[ -z "$MODE" ] && exit 0

# 2. Choose Action
ACTION=$(echo -e "Save to File & Clipboard\nClipboard Only" | noctalia dmenu -p "Action")
[ -z "$ACTION" ] && exit 0

# Map selected options to hyprshot flags
case "$MODE" in
    "Region")      M_FLAG="region" ;;
    "Window")      M_FLAG="window" ;;
    "Full Screen") M_FLAG="output" ;;
esac

FLAGS="-m $M_FLAG"
if [ "$ACTION" = "Clipboard Only" ]; then
    FLAGS="$FLAGS --clipboard-only"
else
    FLAGS="$FLAGS -o $HOME/Pictures/Screenshots"
fi

hyprshot $FLAGS

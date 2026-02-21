#!/bin/bash

# --- Colors (Must match sketchybarrc) ---
BAR_COLOR=0xff1e1e2e
ITEM_BG_COLOR=0xff313244
ACCENT_COLOR=0xffcba6f7
TEXT_COLOR=0xffcdd6f4

TARGET_WORKSPACE=$1
CURRENT_WORKSPACE=$(aerospace list-workspaces --focused)

if [ "$TARGET_WORKSPACE" = "$CURRENT_WORKSPACE" ]; then
    sketchybar --set "$NAME" \
        background.color="$ACCENT_COLOR" \
        background.drawing=on \
        label.color="$BAR_COLOR" \
        icon.color="$BAR_COLOR"
else
    sketchybar --set "$NAME" \
        background.color="$ITEM_BG_COLOR" \
        background.drawing=on \
        label.color="$TEXT_COLOR" \
        icon.color="$TEXT_COLOR"
fi

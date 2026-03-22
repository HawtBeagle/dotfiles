#!/bin/bash

# --- Source Active Theme ---
source "$CONFIG_DIR/theme.sh"

TARGET_WORKSPACE=$1
CURRENT_WORKSPACE=$(aerospace list-workspaces --focused)

# Static Workspace Configuration
case "$TARGET_WORKSPACE" in
  "Q") ICON="󰈞" LABEL="Query" ;;
  "T") ICON="󰆍" LABEL="Terminal" ;;
  "S") ICON="󰒱" LABEL="Socials" ;;
  "D") ICON="󱇐" LABEL="Data" ;;
  "C") ICON="󰅩" LABEL="Code" ;;
  "B") ICON="󰖟" LABEL="Browser" ;;
  *)   ICON="󰣆" LABEL="Work" ;;
esac

if [ "$TARGET_WORKSPACE" = "$CURRENT_WORKSPACE" ]; then
    sketchybar --set "$NAME" \
        background.color="$ACCENT_COLOR" \
        background.drawing=on \
        icon="$ICON" \
        label="$LABEL" \
        label.color="$BAR_COLOR" \
        icon.color="$BAR_COLOR"
else
    sketchybar --set "$NAME" \
        background.color="$ITEM_BG_COLOR" \
        background.drawing=on \
        icon="$ICON" \
        label="$LABEL" \
        label.color="$TEXT_COLOR" \
        icon.color="$TEXT_COLOR"
fi

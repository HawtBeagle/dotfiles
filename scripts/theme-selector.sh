#!/bin/bash

# --- Get the dotfiles directory ---
DOTFILES_DIR="$HOME/Desktop/Personal/dotfiles"
THEMES=("gruvbox" "catppuccin")

# --- Use fzf to pick a theme ---
# Set the title for WezTerm so AeroSpace can detect and float it
echo -ne "\033]0;Theme Selector\007"

SELECTED_THEME=$(printf "%s\n" "${THEMES[@]}" | fzf --height 100% --layout=reverse --border --prompt="Select Theme: ")

# --- If a theme was selected, switch to it ---
if [ -n "$SELECTED_THEME" ]; then
    "$DOTFILES_DIR/scripts/switch-theme.sh" "$SELECTED_THEME"
fi

#!/bin/bash

# --- Get the dotfiles directory ---
DOTFILES_DIR="$HOME/Desktop/Personal/dotfiles"
THEME_FILE="$DOTFILES_DIR/.theme_mode"

# --- Validate the theme argument ---
THEME=$1
if [ "$THEME" != "gruvbox" ] && [ "$THEME" != "catppuccin" ]; then
  echo "Usage: ./switch-theme.sh [gruvbox|catppuccin]"
  exit 1
fi

# --- Update the theme mode file ---
printf "%s" "$THEME" > "$THEME_FILE"

# --- Update Symlinks ---
# Starship
ln -sf "$DOTFILES_DIR/themes/$THEME/starship.toml" "$DOTFILES_DIR/starship/starship.toml"

# LazyGit
ln -sf "$DOTFILES_DIR/themes/$THEME/lazygit.yml" "$DOTFILES_DIR/lazygit/config.yml"

# Yazi
ln -sf "$DOTFILES_DIR/themes/$THEME/yazi_theme.toml" "$DOTFILES_DIR/yazi/theme.toml"

# Git
ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/themes/$THEME/gitconfig" "$DOTFILES_DIR/git/theme.gitconfig"

# Tmux Theme
ln -sf "$DOTFILES_DIR/themes/$THEME/tmux.conf" "$DOTFILES_DIR/tmux/theme.tmux"

# Sketchybar Theme
ln -sf "$DOTFILES_DIR/themes/$THEME/sketchybar.sh" "$DOTFILES_DIR/sketchybar/theme.sh"
ln -sf "$DOTFILES_DIR/themes/$THEME/sketchybar.sh" "$HOME/.config/sketchybar/theme.sh"

# --- Trigger Reloads ---
# Sketchybar
sketchybar --reload

# Tmux
tmux source-file "$DOTFILES_DIR/tmux/tmux.conf" 2>/dev/null || true
for session in $(tmux list-sessions -F "#{session_name}" 2>/dev/null); do
  tmux source-file -t "$session" "$DOTFILES_DIR/tmux/tmux.conf" 2>/dev/null || true
done

# WezTerm
touch "$HOME/.wezterm.lua"
touch "$DOTFILES_DIR/wezterm/wezterm.lua"

# AeroSpace
aerospace reload-config

# Navi
mkdir -p "$HOME/Library/Application Support/navi"
ln -sf "$DOTFILES_DIR/navi/config.yaml" "$HOME/Library/Application Support/navi/config.yaml"

# Zsh (Update all running shells)
if [ -n "$ZSH_VERSION" ]; then
    source "$HOME/.zshrc"
fi

echo "Theme switched to $THEME"

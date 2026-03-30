#!/bin/bash

# --- Get the current directory ---
DOTFILES_DIR=$(pwd)

# --- 1. Create Symlinks (Tell macOS to use our dotfiles) ---
echo "Linking configurations..."
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/aerospace"
mkdir -p "$HOME/Library/Application Support/navi"

# Core Shell & Terminal
ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/starship/starship.toml" "$DOTFILES_DIR/themes/gruvbox/starship.toml" # Ensure initial state
ln -sf "$DOTFILES_DIR/wezterm/wezterm.lua" "$HOME/.wezterm.lua"

# Git
ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# Tools
ln -sf "$DOTFILES_DIR/aerospace/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"
ln -sf "$DOTFILES_DIR/sketchybar" "$HOME/.config/sketchybar"
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
ln -sf "$DOTFILES_DIR/borders" "$HOME/.config/borders"
ln -sf "$DOTFILES_DIR/tmuxinator" "$HOME/.config/tmuxinator"
ln -sf "$DOTFILES_DIR/yazi" "$HOME/.config/yazi"
ln -sf "$DOTFILES_DIR/lazygit/config.yml" "$DOTFILES_DIR/themes/gruvbox/lazygit.yml" # Ensure initial state
ln -sf "$DOTFILES_DIR/navi/config.yaml" "$HOME/Library/Application Support/navi/config.yaml"

# Tmux
ln -sf "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

# --- 2. Initialize Theme ---
if [ ! -f "$DOTFILES_DIR/.theme_mode" ]; then
    echo "Initializing theme to gruvbox..."
    "$DOTFILES_DIR/scripts/switch-theme.sh" gruvbox
else
    echo "Refreshing current theme symlinks..."
    "$DOTFILES_DIR/scripts/switch-theme.sh" $(cat "$DOTFILES_DIR/.theme_mode")
fi

# --- 3. Install TPM (Tmux Plugin Manager) ---
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# --- 4. Final Touches ---
echo "--------------------------------------------------"
echo "Setup Complete!"
echo "1. Restart WezTerm"
echo "2. In tmux, press 'Ctrl+Space' then 'I' to install plugins"
echo "3. Open nvim and wait for 'Lazy' to finish"
echo "4. Use 'Alt + Shift + E' to switch themes anytime"
echo "--------------------------------------------------"

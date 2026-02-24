#!/bin/bash

# --- 1. Create Symlinks (Tell macOS to use our dotfiles) ---
echo "Linking configurations..."
mkdir -p ~/.config

ln -sf ~/Desktop/Personal/dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/Desktop/Personal/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/Desktop/Personal/dotfiles/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml
ln -sf ~/Desktop/Personal/dotfiles/sketchybar ~/.config/sketchybar
ln -sf ~/Desktop/Personal/dotfiles/nvim ~/.config/nvim
ln -sf ~/Desktop/Personal/dotfiles/wezterm ~/.config/wezterm
ln -sf ~/Desktop/Personal/dotfiles/borders ~/.config/borders
ln -sf ~/Desktop/Personal/dotfiles/tmuxinator ~/.config/tmuxinator
ln -sf ~/Desktop/Personal/dotfiles/yazi ~/.config/yazi

# --- 2. Install TPM (Tmux Plugin Manager) ---
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# --- 3. Final Touches ---
echo "Setup Complete!"
echo "1. Restart WezTerm"
echo "2. In tmux, press 'Ctrl+Space' then 'I' to install plugins"
echo "3. Open nvim and wait for 'Lazy' to finish installing plugins"

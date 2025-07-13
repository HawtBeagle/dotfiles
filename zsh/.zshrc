#######################################
# 🌟 Basic Shell Configuration
#######################################

# Set Zsh as the default shell path
export SHELL=$(which zsh)

# Set Neovim as the default text editor
export EDITOR="nvim"

# Enable tab completion
autoload -Uz compinit && compinit

# Enable extended globbing (e.g., **/*.js)
setopt extended_glob

#######################################
# ⌨️ Key Bindings
#######################################

# Use vim-style key bindings
bindkey -v

# Ctrl-R to search command history (incrementally)
bindkey '^r' history-incremental-search-backward

#######################################
# 🧪 Plugins with Zinit (Plugin Manager)
#######################################

# Install Zinit if not already present
if [[ ! -f ${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git/zinit.zsh ]]; then
  mkdir -p ~/.local/share/zinit
  git clone https://github.com/zdharma-continuum/zinit.git ~/.local/share/zinit/zinit.git
fi

# Source Zinit to use its plugin features
source ~/.local/share/zinit/zinit.git/zinit.zsh

# Zsh Vi Mode (shows visual mode indicator like -- NORMAL --)
zinit light jeffreytse/zsh-vi-mode

# --- Plugins ---
# Autosuggest commands based on history
zinit light zsh-users/zsh-autosuggestions

# Faster syntax highlighting (alternative to above)
zinit light zdharma-continuum/fast-syntax-highlighting

# Search command history with arrow keys (Up/Down)
zinit light zsh-users/zsh-history-substring-search

# Git plugin (shortcuts like `gst`, `gco`, `gl`)
zinit snippet OMZ::plugins/git/git.plugin.zsh

#######################################
# 🚀 Prompt Setup using Starship
#######################################

# Starship is a fast, customizable prompt
# Learn more: https://starship.rs
eval "$(starship init zsh)"

#######################################
# 🧠 Smart Directory Navigation with Zoxide
#######################################

# Zoxide is a smarter cd command
# Learn more: https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

# Use zoxide (`z`) in place of cd
alias cd='z'

# Shortcut to jump to a recent directory using fzf
unalias zi 2>/dev/null
zi() {
  cd "$(zoxide query -l | fzf)"
}


#######################################
# 🕹 History Settings
#######################################

# Save long command history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# Avoid duplicate entries and share history across tabs
setopt hist_ignore_dups share_history

#######################################
# 📦 Atuin: Better Shell History
#######################################

# Atuin replaces history with a searchable, syncable database
# Learn more: https://github.com/atuinsh/atuin
eval "$(atuin init zsh)"


#######################################
# 🧩 Aliases — Smarter CLI Tools
#######################################

# Use modern replacements for Unix commands
alias ls='eza'                            # ls replacement with better visuals
alias ll='eza -lah --icons'              # long format with hidden files
alias tree='eza --tree'                  # directory tree view

alias cat='bat'                          # syntax-highlighted cat
alias find='fd'                          # better find
alias grep='rg'                          # ripgrep = faster grep

# Git Shortcuts
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias lg='lazygit'                       # TUI for Git

# System Tools
alias top='btop'                         # better top

# Navigation Shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias zshconfig='nvim ~/.zshrc'
alias starshipconfig='nvim ~/.config/starship.toml'
alias tmuxconfig='nvim ~/.tmux.conf'
alias vimconfig='cd ~/.config/nvim/ && nvim .'
alias reload='source ~/.zshrc'

alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tls='tmux ls'
alias tk='tmux kill-session -t'

# Auto-start or attach to a tmux session named "main"
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach-session -t default 2>/dev/null || tmux new-session -s default 
fi

#######################################
# 💡 Optional: Local Overrides
#######################################

# Load custom machine-specific or private config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local


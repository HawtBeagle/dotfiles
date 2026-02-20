# --- Path Configuration ---
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/mysql/bin:$PATH"
export PATH="$PATH:/Users/licious/Library/Application Support/JetBrains/Toolbox/scripts"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/ganti/licious/.lmstudio/bin"

# --- Global Environment ---
export EDITOR='nvim'
export VISUAL='nvim'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Colorize more tools
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# --- History ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# Arrow Key History Search
# (Type a command and use up/down to search only that command history)
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search # Up Arrow
bindkey '^[[B' down-line-or-beginning-search # Down Arrow

# --- Autocompletion & Correction ---
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
setopt CORRECT # Enable auto-correction for typos

# --- Prompt (Starship) ---
eval "$(starship init zsh)"

# --- Aliases ---
alias ls='eza --icons=always'
alias ll='eza -lh --icons=always'
alias la='eza -a --icons=always'
alias lt='eza --tree --icons=always'
alias doc='open ~/Desktop/Personal/dotfiles-docs/index.html'
alias reload='source ~/.zshrc'
alias cd='z'
alias lg='lazygit'
alias cat='bat'
alias top='btm'
export BAT_THEME="Catppuccin Mocha"

# --- SDKMAN (if installed) ---
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# --- Plugins (Homebrew) ---
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#585b70"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- Modern UI (fzf-tab, zoxide, fzf) ---
source "/opt/homebrew/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# fzf-tab styling
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'

# Local Run Tool
alias localrun='~/Desktop/Personal/dotfiles/scripts/localrun.py'

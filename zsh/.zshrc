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

# Explicitly set vi mode early
bindkey -v

# Colorize more tools
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
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

# JDTLS troubleshooting: Clear cache for the CURRENT project only
function jdtls-clear() {
    local project_name=$(basename "$PWD")
    local workspace_dir="$HOME/.local/share/nvim/jdtls-workspace/$project_name"
    local cache_dir="$HOME/.cache/nvim/jdtls"
    
    echo "Clearing JDTLS cache for project: $project_name..."
    rm -rf "$workspace_dir"
    rm -rf "$cache_dir"
    echo "Done. Please restart Neovim to re-index."
}
alias mux-spring='tmuxinator start spring-boot'
alias cat='bat'
# --- Dynamic Themes ---
theme=$(cat ~/Desktop/Personal/dotfiles/.theme_mode 2>/dev/null || echo "gruvbox")
if [ "$theme" = "gruvbox" ]; then
    export BAT_THEME="gruvbox-dark"
else
    export BAT_THEME="Catppuccin Mocha"
fi

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

# --- Key Bindings (vi mode) ---
# Accept autosuggestions with Ctrl-f (This is the "completing the word" behavior)
bindkey -M viins '^F' autosuggest-accept
bindkey -M vicmd '^F' autosuggest-accept

# Note: fzf file search is still available on Ctrl-T (default fzf binding)

# Local Run Tool
alias localrun='~/Desktop/Personal/dotfiles/scripts/localrun.py'

# Yazi wrapper to change directory on exit
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# nvm configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# --- Git Aliases ---
alias status='git status'
alias log="git log --graph --pretty=format:'%C(bold #b4befe)%h%Creset %C(#cdd6f4)%s%Creset %C(#94e2d5)(%cr)%Creset %C(bold #cba6f7)<%an>%Creset %C(#fab387)%d%Creset%n%C(#a6adc8)%b%Creset'"
alias check='git checkout'
alias createb='git checkout -b'
alias push='git push origin'
alias pull='git pull origin'
alias save='git stash save'
alias slist='git stash list'
alias apply='git stash apply'
alias add='git add .'
alias commit='git commit -m'
alias reset='git reset'
alias hreset='git reset --hard'
alias squash='git rebase --interactive'
alias merge='git merge'
alias reset='git reset --soft'
alias hreset='git reset --hard'
alias branch='git branch'
alias fetch='git fetch origin'

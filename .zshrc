#!/usr/bin/env zsh

# ============================================================================
# Oh My Zsh Configuration
# ============================================================================

export ZSH=$HOME/.oh-my-zsh

# Set theme (starship will override this)
ZSH_THEME="robbyrussell"

# Plugins to load
plugins=(
    git
    npm
    node
    jsontools
    bun
    golang
    fzf
    fzf-tab
    zoxide
    common-aliases
    zsh-autosuggestions
    zsh-syntax-highlighting
    docker
    docker-compose
    vscode
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ============================================================================
# Environment Variables
# ============================================================================

# Set default editor
export EDITOR='vim'
export VISUAL='code'

# Colorize style
export ZSH_COLORIZE_STYLE="colorful"

# History settings
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# ============================================================================
# Path Configuration
# ============================================================================

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# ============================================================================
# Bun Configuration
# ============================================================================

if [ -f "$HOME/.bun/bin/bun" ]; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
    
    # Bun completions
    [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
fi

# ============================================================================
# Node.js (fnm) Configuration
# ============================================================================

if [ -d "$HOME/.local/share/fnm" ]; then
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env --use-on-cd)"
fi

# ============================================================================
# FZF Configuration
# ============================================================================

if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
    
    # FZF default options
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info"
    
    # Use fd instead of find if available
    if command -v fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
    
    # Use bat for preview if available
    if command -v bat &> /dev/null; then
        export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
    fi
fi

# ============================================================================
# SSH Agent Configuration
# ============================================================================

# Start SSH agent if not running
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    
    # Add SSH key if it exists
    if [ -f "$HOME/.ssh/id_ed25519" ]; then
        ssh-add ~/.ssh/id_ed25519 2>/dev/null
    fi
fi

# ============================================================================
# Aliases
# ============================================================================

# General aliases
alias cls="clear"
alias c="clear"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Config file shortcuts
alias zshconfig="code ~/.zshrc"
alias starconfig="code ~/.config/starship.toml"
alias ohmyzsh="code ~/.oh-my-zsh"

# Better ls with exa (if installed)
if command -v exa &> /dev/null; then
    alias ls="exa --icons"
    alias ll="exa -l --icons --git"
    alias la="exa -la --icons --git"
    alias lt="exa --tree --level=2 --icons"
else
    alias ll="ls -lh"
    alias la="ls -lha"
fi

# Better cat with bat (if installed)
if command -v bat &> /dev/null; then
    alias cat="bat"
fi

# Git aliases (additional to oh-my-zsh git plugin)
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"
alias glog="git log --oneline --graph --decorate"

# Docker aliases
alias dps="docker ps"
alias dpsa="docker ps -a"
alias di="docker images"
alias dex="docker exec -it"
alias dcu="docker-compose up -d"
alias dcd="docker-compose down"
alias dcl="docker-compose logs -f"

# System maintenance
alias update="sudo pacman -Syu"
alias install="sudo pacman -S"
alias remove="sudo pacman -Rns"
alias search="pacman -Ss"

# Quick navigation with zoxide
alias cd="z"

# ============================================================================
# Starship Prompt
# ============================================================================

if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# ============================================================================
# Zoxide (Better cd)
# ============================================================================

if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# ============================================================================
# Custom Functions
# ============================================================================

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract any archive
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Find and kill process by port
killport() {
    if [ -z "$1" ]; then
        echo "Usage: killport <port>"
        return 1
    fi
    
    local pid=$(lsof -ti:$1)
    if [ -n "$pid" ]; then
        kill -9 $pid
        echo "Killed process on port $1"
    else
        echo "No process found on port $1"
    fi
}

# Quick git commit and push
gcp() {
    git add .
    git commit -m "$1"
    git push
}

# ============================================================================
# Welcome Message
# ============================================================================

# Display system info on shell start (optional - comment out if not wanted)
# if command -v neofetch &> /dev/null; then
#     neofetch
# fi

# ============================================================================
# End of Configuration
# ============================================================================

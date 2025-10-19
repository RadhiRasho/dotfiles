export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

# Always start in home directory
cd $HOME

plugins=(git npm node jsontools bun golang fzf fzf-tab zoxide common-aliases zsh-autosuggestions zsh-syntax-highlighting vscode  starship)

source $ZSH/oh-my-zsh.sh


ZSH_COLORIZE_STYLE="colorful"

alias cls="clear"
alias zshconfig="code ~/.zshrc"
alias starconfig="code ~/.config/starship.toml"
alias cd="z"

# bun
if [ -f "$HOME/.bun/bin/bun" ]; then
    # bun completions
    [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
fi

# fzf - Check for Arch Linux pacman installation first, then fallback to manual install
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
    source /usr/share/fzf/key-bindings.zsh
fi

if [ -f /usr/share/fzf/completion.zsh ]; then
    source /usr/share/fzf/completion.zsh
fi

# Fallback to manual fzf installation
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

# SSH Agent setup
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/id_ed25519 2>/dev/null
fi

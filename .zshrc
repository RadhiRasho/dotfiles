export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="devcontainers"

plugins=(git npm yarn rust jsontools bun man golang fzf fzf-tab zoxide colored-man-pages gnu-utils colorize command-not-found safe-paste common-aliases gitignore nvm npm node zsh-autosuggestions vscode web-search zsh-syntax-highlighting starship)

source $ZSH/oh-my-zsh.sh

DISABLE_AUTO_UPDATE=true
DISABLE_UPDATE_PROMPT=true
ZSH_COLORIZE_STYLE="colorful"

alias cls="clear"
alias zshconfig="code ~/.zshrc"
alias starconfig="code ~/.config/starship.toml"
alias cd="z"

# bun
if [ -f "$HOME/.bun/bin/bun" ]; then
    # bun completions
    [ -s "/home/vscode/.bun/_bun" ] && source "/home/vscode/.bun/_bun"

    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
else
    echo "bun executable not found in $HOME/.bun/bin. Please check your bun installation."
fi

if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
    enable-fzf-tab
else
    echo "fzf not found, please install"
fi

# fnm
FNM_PATH="/home/vscode/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/vscode/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# SSH Agent setup
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/id_ed25519 2>/dev/null
fi

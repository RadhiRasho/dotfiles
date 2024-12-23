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

if [ -f "/usr/local/go/bin/go" ]; then
    export PATH="$PATH:/usr/local/go/bin"
    export PATH="$PATH:$HOME/go/bin"
else
    echo "Go executable not found in /usr/local/go/bin. Please check your Go installation."
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
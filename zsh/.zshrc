export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="devcontainers"

plugins=(git ssh-agent npm yarn rust jsontools man colored-man-pages gnu-utils colorize command-not-found safe-paste common-aliases gitignore nvm npm node zsh-autosuggestions vscode web-search zsh-syntax-highlighting starship)

export NPMRC_AUTH_TOKEN="bjZtbmhyeWV2bzYzZmZvN2t5ZmJhdWx6Nnl6MzZuemNuaDZwMjZ6bGd5dG1uMmlxZ3RkcQ=="

source $ZSH/oh-my-zsh.sh

DISABLE_AUTO_UPDATE=true
DISABLE_UPDATE_PROMPT=true
ZSH_COLORIZE_STYLE="colorful"
export HISTFILE=/dc/shellhistory/.zsh_history
export PROMPT_COMMAND='history -a'

sudo chown -R vscode /dc/shellhistory

alias cls="clear"
alias zshconfig="code ~/.zshrc"
alias starconfig="code ~/.config/starship.toml"

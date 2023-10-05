export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="devcontainers"

function cls() clear

plugins=(git yarn rust jsontools man colored-man-pages gnu-utils colorize command-not-found safe-paste common-aliases gitignore nvm npm node zsh-autosuggestions vscode web-search zsh-syntax-highlighting starship)

source $ZSH/oh-my-zsh.sh

DISABLE_AUTO_UPDATE=true
DISABLE_UPDATE_PROMPT=true
export HISTFILE=/dc/shellhistory/.zsh_history
export PROMPT_COMMAND='history -a'
sudo chown -R vscode /dc/shellhistory

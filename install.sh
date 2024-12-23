#!/usr/bin/env bash

# Define ZSH_CUSTOM if not already defined
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# Install zsh-syntax-highlighting
echo "Installing zsh-syntax-highlighting..."
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
else
  echo "zsh-syntax-highlighting already installed."
fi

echo "================================================================================================================================="

# Install zsh-autosuggestions
echo "Installing zsh-autosuggestions..."
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
else
  echo "zsh-autosuggestions already installed."
fi

echo "================================================================================================================================="

# Install zoxide
echo "Installing zoxide..."
if [ ! -f "$HOME/.local/bin/zoxide" ]; then
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
else
  echo "zoxide already installed."
fi

echo "================================================================================================================================="

# Install fzf
echo "Installing fzf..."
if [ ! -d "$HOME/.fzf" ]; then
  yes | git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
else
  echo "fzf already installed."
fi

echo "================================================================================================================================="

# Install fzf-tab
echo "Installing fzf-tab..."
if [ ! -d "$ZSH_CUSTOM/plugins/fzf-tab" ]; then
  git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
else
  echo "fzf-tab already installed."
fi

echo "================================================================================================================================="

# Install Bun
echo "Installing Bun..."
if [ ! -f "$HOME/.bun/bin/bun" ]; then
  curl -fsSL https://bun.sh/install | bash
else
  echo "Bun already installed."
fi

echo "================================================================================================================================="

# Install FNM
echo "Installing FNM..."
if [ ! -d "$HOME/.local/share/fnm" ]; then
  curl -fsSL https://fnm.vercel.app/install | bash
else
  echo "FNM already installed."
fi

echo "================================================================================================================================="

echo "All tools installed successfully!"


echo "================================================================================================================================="

echo "Setting up .zshrc..."

echo "Copying .zshrc..."

curl -sSfL https://raw.githubusercontent.com/RadhiRasho/dotfiles/refs/heads/master/.zshrc > ~/.zshrc

echo "Setting up .zshrc... Done!"

echo "================================================================================================================================="

echo "Setting up starship..."

echo "Creating .config directory..."
if [ ! -d "$HOME/.config" ]; then
  mkdir $HOME/.config
else
  echo ".config directory already exists."
fi

echo "================================================================================================================================="

echo "Copying starship.toml..."

curl -sSfL https://raw.githubusercontent.com/RadhiRasho/dotfiles/refs/heads/master/starship.toml > ~/.config/starship.toml

echo "Setting up starship... Done!"

echo "================================================================================================================================="

echo "All done! Please restart your terminal to see the changes."
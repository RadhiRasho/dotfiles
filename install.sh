#!/usr/bin/env bash

# Install zsh-syntax-highlighting
echo "Installing zsh-syntax-highlighting..."
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
  echo "zsh-syntax-highlighting already installed."
fi

# Install zsh-autosuggestions
echo "Installing zsh-autosuggestions..."
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
  echo "zsh-autosuggestions already installed."
fi

# Install zoxide
echo "Installing zoxide..."
if ! command -v zoxide &> /dev/null; then
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
else
  echo "zoxide already installed."
fi

# Install fzf
echo "Installing fzf..."
if [ ! -d "~/.fzf" ]; then
  yes | git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
else
  echo "fzf already installed."
fi

# Install fzf-tab
echo "Installing fzf-tab..."
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab" ]; then
  git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
else
  echo "fzf-tab already installed."
fi

# Install Bun
echo "Installing Bun..."
if ! command -v bun &> /dev/null; then
  curl -fsSL https://bun.sh/install | bash
else
  echo "Bun already installed."
fi

# Install FNM
echo "Installing FNM..."
if ! command -v fnm &> /dev/null; then
  curl -fsSL https://fnm.vercel.app/install | bash
else
  echo "FNM already installed."
fi

echo "All tools installed successfully!"
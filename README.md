# Dotfiles for Arch Linux

A comprehensive dotfiles repository for setting up a new Arch Linux installation with Zsh, Oh My Zsh, and various development tools.

## 🚀 Quick Start

### Initial System Setup (Fresh Arch Linux)

1. **Run the Arch Linux setup script:**

   ```bash
   bash <(curl -fsSL https://raw.githubusercontent.com/RadhiRasho/dotfiles/master/archlinux/arch-install.sh)
   ```

   This will install:
   - Essential system packages
   - Zsh and shell utilities
   - Development tools (Python, Docker, Go, Rust, VS Code)
   - Oh My Zsh
   - Node.js (via fnm)
   - Bun runtime
   - yay (AUR helper)

2. **Logout and login again** (or reboot) to apply group changes (especially for Docker)

3. **Run the dotfiles installation script:**

   ```bash
   bash <(curl -fsSL https://raw.githubusercontent.com/RadhiRasho/dotfiles/master/install.sh)
   ```

   This will install:
   - Oh My Zsh plugins (syntax highlighting, autosuggestions, fzf-tab)
   - Zoxide (better cd)
   - Your custom .zshrc configuration
   - Starship prompt configuration

4. **Restart your terminal** to see all changes take effect

## 📦 What's Included

### System Packages

- **Base tools**: git, wget, curl, vim, neovim, htop, btop, tree
- **Shell**: zsh, zsh-autosuggestions, zsh-syntax-highlighting, fzf, bat, exa, ripgrep, fd
- **Development**: python, docker, go, rust, VS Code
- **Prompt**: starship

### Oh My Zsh Plugins

- git - Git aliases and functions
- npm - NPM aliases
- node - Node.js support
- jsontools - JSON tools
- bun - Bun runtime support
- golang - Go support
- fzf - Fuzzy finder
- fzf-tab - Tab completion with fzf
- zoxide - Smarter cd command
- common-aliases - Common shell aliases
- zsh-autosuggestions - Command suggestions
- zsh-syntax-highlighting - Syntax highlighting
- docker & docker-compose - Docker support
- vscode - VS Code integration

### Custom Features

- **Smart FZF integration** with bat preview
- **Auto SSH agent** management
- **Zoxide** for smart directory jumping
- **Starship prompt** for a beautiful terminal
- **Useful aliases** for git, docker, system management
- **Custom functions** (mkcd, extract, killport, gcp)

## 🛠️ Manual Installation

If you prefer to run scripts locally:

1. **Clone this repository:**

   ```bash
   git clone https://github.com/RadhiRasho/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Run the Arch setup script:**

   ```bash
   chmod +x archlinux/arch-install.sh
   ./archlinux/arch-install.sh
   ```

3. **Logout and login again**

4. **Run the dotfiles setup:**

   ```bash
   chmod +x install.sh
   ./install.sh
   ```

## ⚙️ Configuration Files

- `.zshrc` - Zsh configuration with plugins, aliases, and functions
- `starship.toml` - Starship prompt configuration
- `archlinux/arch-install.sh` - System-level Arch Linux setup
- `install.sh` - User-level dotfiles and tools installation

## 📝 Custom Aliases

### General

- `cls`, `c` - Clear terminal
- `..`, `...`, `....` - Navigate up directories
- `zshconfig` - Edit .zshrc
- `starconfig` - Edit starship config

### File Management (with exa)

- `ls` - List files with icons
- `ll` - Long list with git status
- `la` - List all files including hidden
- `lt` - Tree view

### Git

- `gs` - git status
- `ga` - git add
- `gc` - git commit
- `gp` - git push
- `gl` - git pull
- `glog` - Pretty git log

### Docker

- `dps` - docker ps
- `dpsa` - docker ps -a
- `dcu` - docker-compose up -d
- `dcd` - docker-compose down
- `dcl` - docker-compose logs -f

### System

- `update` - Update system packages
- `install` - Install package
- `remove` - Remove package
- `search` - Search for package

## 🎯 Custom Functions

- `mkcd <dir>` - Create directory and cd into it
- `extract <file>` - Extract any archive format
- `killport <port>` - Kill process running on specified port
- `gcp <message>` - Quick git add, commit, and push

## 🔧 Post-Installation

### Set up Git

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Generate SSH Key (if needed)

```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
cat ~/.ssh/id_ed25519.pub  # Copy this to GitHub/GitLab
```

### Install Node.js with fnm

```bash
fnm install --lts
fnm use lts-latest
```

### Customize Starship

Edit `~/.config/starship.toml` to customize your prompt

## 🎨 Customization

### Adding More Packages

Edit `archlinux/arch-install.sh` and add packages to the appropriate section

### Adding Oh My Zsh Plugins

Edit `.zshrc` and add plugin names to the `plugins=()` array

### Modifying Aliases

Edit `.zshrc` in the "Aliases" section

## 📚 Resources

- [Oh My Zsh](https://ohmyz.sh/)
- [Starship Prompt](https://starship.rs/)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [fzf](https://github.com/junegunn/fzf)
- [exa](https://github.com/ogham/exa)
- [bat](https://github.com/sharkdp/bat)

## 📄 License

Feel free to use and modify these dotfiles for your own setup!

## 🤝 Contributing

Feel free to submit issues or pull requests if you have suggestions for improvements!

## FNM

```bash
curl -fsSL https://fnm.vercel.app/install | bash
```

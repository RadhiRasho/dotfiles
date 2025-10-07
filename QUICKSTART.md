# Quick Start Guide

## Fresh Arch Linux Installation

### Step 1: Run System Setup

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/RadhiRasho/dotfiles/master/archlinux/arch-install.sh)
```

**What it does:**

- Updates system packages
- Installs essential tools (git, btop, etc.)
- Installs Zsh and shell enhancements (fzf, bat, exa, ripgrep, starship)
- Installs development tools (Go, Rust)
- Installs AUR helper (yay)
- Installs Oh My Zsh
- Installs fnm (Fast Node Manager) and Bun
- Changes default shell to zsh

### Step 2: Logout and Login

```bash
logout
# or
reboot
```

This is required for group changes (especially Docker) to take effect.

### Step 3: Install Dotfiles and Plugins

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/RadhiRasho/dotfiles/master/install.sh)
```

**What it does:**

- Installs Oh My Zsh plugins (syntax highlighting, autosuggestions, fzf-tab)
- Installs zoxide (smarter cd)
- Downloads your custom .zshrc configuration
- Downloads your starship.toml configuration

### Step 4: Restart Terminal

```bash
exec zsh
# or just open a new terminal window
```

## Post-Setup Configuration

### Git Setup

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### SSH Key (for GitHub/GitLab)

```bash
# Generate key
ssh-keygen -t ed25519 -C "your.email@example.com"

# Start SSH agent and add key
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copy public key to clipboard
cat ~/.ssh/id_ed25519.pub
# Then paste it on GitHub/GitLab
```

### Install Node.js

```bash
fnm install --lts
fnm use lts-latest
node --version
```

## Useful Commands After Setup

### Package Management

```bash
update          # Update system packages
install <pkg>   # Install a package
remove <pkg>    # Remove a package
search <pkg>    # Search for a package
yay <pkg>       # Install from AUR
```

### Navigation

```bash
z <dir>         # Jump to directory (zoxide)
..              # Go up one directory
...             # Go up two directories
ls              # List files (using exa with icons)
ll              # Long list with git status
la              # List all including hidden
lt              # Tree view
```

### Git Shortcuts

```bash
gs              # git status
ga .            # git add all
gc -m "msg"     # git commit with message
gp              # git push
gl              # git pull
glog            # Pretty git log
gcp "message"   # Add, commit, and push in one command
```

### Docker

```bash
dps             # docker ps
dpsa            # docker ps -a
dcu             # docker-compose up -d
dcd             # docker-compose down
dcl             # docker-compose logs -f
```

### Custom Functions

```bash
mkcd mydir      # Create directory and cd into it
extract file    # Extract any archive
killport 3000   # Kill process on port 3000
```

## Troubleshooting

### Zsh plugins not working

```bash
# Reinstall Oh My Zsh plugins
rm -rf ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
rm -rf ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
rm -rf ~/.oh-my-zsh/custom/plugins/fzf-tab

# Run install script again
bash <(curl -fsSL https://raw.githubusercontent.com/RadhiRasho/dotfiles/master/install.sh)
```

### Docker permission denied

```bash
# Make sure you logged out and back in after running arch-install.sh
# Or run manually:
sudo usermod -aG docker $USER
# Then logout and login
```

### Starship not showing

```bash
# Make sure starship is installed
starship --version

# If not, install it
sudo pacman -S starship

# Check if it's in .zshrc
grep starship ~/.zshrc
```

### fnm not found

```bash
# Reinstall fnm
curl -fsSL https://fnm.vercel.app/install | bash

# Reload zsh
exec zsh
```

## Customization

### Edit Zsh Config

```bash
zshconfig       # Opens .zshrc in VS Code
```

### Edit Starship Prompt

```bash
starconfig      # Opens starship.toml in VS Code
```

### Add More Packages

Edit `archlinux/arch-install.sh` and add packages to the installation sections.

### Add More Aliases

Edit `.zshrc` in the "Aliases" section.

## Resources

- [Oh My Zsh Documentation](https://github.com/ohmyzsh/ohmyzsh/wiki)
- [Starship Configuration](https://starship.rs/config/)
- [Arch Wiki](https://wiki.archlinux.org/)

#!/usr/bin/env bash

set -e  # Exit on error

echo "=========================================="
echo "Arch Linux Setup Script"
echo "=========================================="
echo ""

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}==>${NC} ${GREEN}$1${NC}"
}

print_separator() {
    echo "================================================================================================================================="
}

# Update system
print_status "Updating system packages..."
sudo pacman -Syu --noconfirm
print_separator

# Detect if running in WSL
IS_WSL=false
if grep -qi microsoft /proc/version 2>/dev/null || grep -qi wsl /proc/version 2>/dev/null; then
    IS_WSL=true
fi

# Create new user (optional)
print_status "User setup..."
if [ "$(whoami)" = "root" ]; then
    if [ "$IS_WSL" = true ]; then
        echo "WSL detected. Running as root."
    else
        echo "Running as root."
    fi
    
    echo "Would you like to create a new user? (y/n)"
    read -r create_user
    if [[ "$create_user" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo "Enter username for the new user:"
        read -r new_username
        
        # Create user with home directory
        useradd -m -G wheel -s /bin/bash "$new_username"
        
        # Set password
        echo "Set password for $new_username:"
        passwd "$new_username"
        
        # Enable sudo for wheel group if not already enabled
        if ! grep -q "^%wheel ALL=(ALL:ALL) ALL" /etc/sudoers; then
            echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
        fi
        
        print_status "User $new_username created and added to wheel group (sudo access)"
        
        # If WSL, set default user in wsl.conf
        if [ "$IS_WSL" = true ]; then
            print_status "Configuring WSL default user..."
            
            # Create or update /etc/wsl.conf
            if [ ! -f /etc/wsl.conf ]; then
                cat > /etc/wsl.conf <<EOF
[user]
default=$new_username
EOF
            else
                # Check if [user] section exists
                if grep -q "^\[user\]" /etc/wsl.conf; then
                    # Update existing default line or add it
                    if grep -q "^default=" /etc/wsl.conf; then
                        sed -i "s/^default=.*/default=$new_username/" /etc/wsl.conf
                    else
                        sed -i "/^\[user\]/a default=$new_username" /etc/wsl.conf
                    fi
                else
                    # Add [user] section
                    echo -e "\n[user]\ndefault=$new_username" >> /etc/wsl.conf
                fi
            fi
            
            print_status "WSL default user set to $new_username"
            echo ""
            echo "IMPORTANT (WSL): Exit this WSL session completely, then from Windows run:"
            echo "  wsl --terminate Arch"
            echo "  (or whatever your WSL distro name is)"
            echo "Then reopen WSL and it will login as $new_username automatically."
            echo "After that, run this script again to complete the setup."
        else
            echo ""
            echo "IMPORTANT: Please logout and login as $new_username, then run this script again."
            echo "Command: su - $new_username"
        fi
        exit 0
    fi
else
    if [ "$IS_WSL" = true ]; then
        print_status "Running in WSL as user: $(whoami)"
    else
        print_status "Running as user: $(whoami)"
    fi
fi
print_separator

# Install essential packages
print_status "Installing essential packages..."
sudo pacman -S --noconfirm --needed \
    git \
    wget \
    curl \
    base-devel \
    btop \
    tree \
    unzip \
    zip \
    tar \
    openssh \
    man-db \
    man-pages \
    tldr
print_separator

# Install Zsh and shell tools
print_status "Installing Zsh and shell tools..."
sudo pacman -S --noconfirm --needed \
    zsh \
    fzf \
    bat \
    starship
print_separator

# Install development tools
print_status "Installing development tools..."
sudo pacman -S --noconfirm --needed \
    go \
    jq \
    github-cli
print_separator

# Install AUR helper (yay)
print_status "Installing yay (AUR helper)..."
if ! command -v yay &> /dev/null; then
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay
    print_status "yay installed successfully"
else
    print_status "yay already installed"
fi
print_separator

# Install Oh My Zsh
print_status "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_status "Oh My Zsh installed successfully"
else
    print_status "Oh My Zsh already installed"
fi
print_separator

# Install Oh My Zsh custom plugins
print_status "Installing Oh My Zsh custom plugins..."
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# Install zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    print_status "zsh-syntax-highlighting installed"
else
    print_status "zsh-syntax-highlighting already installed"
fi

# Install zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    print_status "zsh-autosuggestions installed"
else
    print_status "zsh-autosuggestions already installed"
fi

# Install fzf-tab
if [ ! -d "$ZSH_CUSTOM/plugins/fzf-tab" ]; then
    git clone https://github.com/Aloxaf/fzf-tab $ZSH_CUSTOM/plugins/fzf-tab
    print_status "fzf-tab installed"
else
    print_status "fzf-tab already installed"
fi
print_separator

# Install zoxide
print_status "Installing zoxide..."
if ! command -v zoxide &> /dev/null; then
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    print_status "zoxide installed"
else
    print_status "zoxide already installed"
fi
print_separator

# Install Node Version Manager (fnm)
print_status "Installing fnm (Fast Node Manager)..."
if [ ! -d "$HOME/.local/share/fnm" ]; then
    curl -fsSL https://fnm.vercel.app/install | bash
    print_status "fnm installed successfully"
else
    print_status "fnm already installed"
fi
print_separator

# Install Bun
print_status "Installing Bun..."
if [ ! -f "$HOME/.bun/bin/bun" ]; then
    curl -fsSL https://bun.sh/install | bash
    print_status "Bun installed successfully"
else
    print_status "Bun already installed"
fi
print_separator

# Change default shell to zsh
print_status "Setting zsh as default shell..."
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh)
    print_status "Default shell changed to zsh (restart required)"
else
    print_status "zsh is already the default shell"
fi
print_separator

# Setup Docker (if not in WSL, as WSL handles Docker differently)
if [ "$IS_WSL" != true ]; then
    print_status "Configuring Docker..."
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo usermod -aG docker $USER
    print_status "Docker enabled and started. You'll need to logout/login for group changes to take effect"
else
    print_status "WSL detected - skipping Docker service setup (use Docker Desktop for Windows)"
fi
print_separator

# SSH key generation (optional)
print_status "SSH key setup..."
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    echo "No SSH key found. Would you like to generate one? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo "Enter your email for SSH key:"
        read -r email
        ssh-keygen -t ed25519 -C "$email"
        print_status "SSH key generated"
    fi
else
    print_status "SSH key already exists"
fi
print_separator

echo ""
echo -e "${GREEN}=========================================="
echo "Setup Complete!"
echo "==========================================${NC}"
echo ""
echo "Next steps:"
echo "1. Logout and login again (or reboot) for shell changes to take effect"
echo "2. (Optional) Run install.sh to download your custom .zshrc and starship.toml from GitHub"
echo "3. Or manually configure your prompt by editing ~/.config/starship.toml"
echo ""
echo "Installed:"
echo "  ✓ Oh My Zsh with plugins (syntax-highlighting, autosuggestions, fzf-tab)"
echo "  ✓ zoxide (smart cd)"
echo "  ✓ fnm (Node.js version manager)"
echo "  ✓ Bun runtime"
echo "  ✓ Development tools (Go)"
echo ""
echo "Enjoy your new Arch Linux setup! 🚀"


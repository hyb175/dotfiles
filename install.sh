#!/usr/bin/env bash

# Dotfiles Installation Script
# Supports both macOS and Linux

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# Detect OS
OS="$(uname -s)"
case "${OS}" in
    Linux*)     OS_TYPE=linux;;
    Darwin*)    OS_TYPE=macos;;
    *)          error "Unsupported OS: ${OS}";;
esac

info "Detected OS: ${OS_TYPE}"

# Get dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
info "Dotfiles directory: ${DOTFILES_DIR}"

# Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for this session
    if [[ "${OS_TYPE}" == "linux" ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    else
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    info "Homebrew already installed"
fi

# Install packages from Brewfile
info "Installing packages from Brewfile..."
brew bundle --file="${DOTFILES_DIR}/homebrew/Brewfile" || warn "Some packages failed to install"

# Backup existing configs
backup_if_exists() {
    local target=$1
    if [[ -e "$target" && ! -L "$target" ]]; then
        local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
        info "Backing up existing ${target} to ${backup}"
        mv "$target" "$backup"
    fi
}

# Create symlinks
create_symlink() {
    local source=$1
    local target=$2
    
    # Remove existing symlink if it points elsewhere
    if [[ -L "$target" ]]; then
        local current_source="$(readlink "$target")"
        if [[ "$current_source" != "$source" ]]; then
            warn "Removing existing symlink: ${target} -> ${current_source}"
            rm "$target"
        else
            info "Symlink already correct: ${target} -> ${source}"
            return
        fi
    fi
    
    # Backup existing file/directory
    backup_if_exists "$target"
    
    # Create parent directory if needed
    mkdir -p "$(dirname "$target")"
    
    # Create symlink
    ln -sf "$source" "$target"
    info "Created symlink: ${target} -> ${source}"
}

# Setup configuration symlinks
info "Setting up configuration symlinks..."

# Ensure .config directory exists
mkdir -p "${HOME}/.config"

# Core configs
create_symlink "${DOTFILES_DIR}/tmux" "${HOME}/.config/tmux"
create_symlink "${DOTFILES_DIR}/nvim" "${HOME}/.config/nvim"
create_symlink "${DOTFILES_DIR}/fish" "${HOME}/.config/fish"
create_symlink "${DOTFILES_DIR}/vim/.vimrc" "${HOME}/.vimrc"
create_symlink "${DOTFILES_DIR}/starship.toml" "${HOME}/.config/starship.toml"

# Set up Fish shell
if command -v fish &> /dev/null; then
    # Add fish to valid shells if not already there
    if ! grep -q "$(which fish)" /etc/shells; then
        info "Adding fish to /etc/shells (may require password)..."
        echo "$(which fish)" | sudo tee -a /etc/shells
    fi
    
    # Set fish as default shell if user wants
    read -p "Set fish as your default shell? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        info "Setting fish as default shell..."
        chsh -s "$(which fish)"
    fi
else
    warn "Fish shell not installed"
fi

# Setup secrets file if it doesn't exist
SECRETS_FILE="${HOME}/.config/fish/secrets.fish"
if [[ ! -f "${SECRETS_FILE}" ]]; then
    info "Creating secrets file template..."
    cat > "${SECRETS_FILE}" << 'EOF'
#!/usr/bin/env fish
# This file contains sensitive environment variables
# DO NOT commit this file to version control

# Example: OpenAI API Key
# set -gx OPENAI_API_KEY "your-api-key-here"

# Add other sensitive environment variables below
EOF
    chmod 600 "${SECRETS_FILE}"
    warn "Please edit ${SECRETS_FILE} to add your API keys and secrets"
fi

# Install tmux plugins
if command -v tmux &> /dev/null; then
    info "Installing tmux plugins..."
    if [[ ! -d "${HOME}/.config/tmux/plugins/tpm" ]]; then
        git clone https://github.com/tmux-plugins/tpm "${HOME}/.config/tmux/plugins/tpm"
    fi
    # Install plugins (this will fail if tmux server is not running, which is fine)
    "${HOME}/.config/tmux/plugins/tpm/bin/install_plugins" 2>/dev/null || true
fi

# Neovim setup
if command -v nvim &> /dev/null; then
    info "Neovim will install plugins on first launch"
fi

# Git configuration
read -p "Configure git with your email? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p "Enter your git email: " git_email
    git config --global user.email "${git_email}"
    info "Git email set to: ${git_email}"
fi

# Final checks
info "Running health checks..."

check_command() {
    if command -v "$1" &> /dev/null; then
        echo -e "  ${GREEN}✓${NC} $1 installed"
    else
        echo -e "  ${RED}✗${NC} $1 not found"
    fi
}

echo "Essential tools:"
check_command git
check_command nvim
check_command tmux
check_command fish
check_command starship
check_command zoxide
check_command ripgrep
check_command fzf

echo ""
info "Installation complete! 🎉"
info "Please restart your terminal or run: exec fish"
info "In tmux, press prefix+I to install plugins"
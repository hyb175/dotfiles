#!/usr/bin/env bash

# Dotfiles Health Check Script
# Verifies all configurations are properly set up

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
pass() { echo -e "  ${GREEN}✓${NC} $1"; }
fail() { echo -e "  ${RED}✗${NC} $1"; }
warn() { echo -e "  ${YELLOW}⚠${NC} $1"; }
info() { echo -e "${BLUE}$1${NC}"; }

echo -e "${BLUE}═══════════════════════════════════════${NC}"
echo -e "${BLUE}     Dotfiles Health Check${NC}"
echo -e "${BLUE}═══════════════════════════════════════${NC}"
echo

# Check symlinks
info "Checking configuration symlinks:"
check_symlink() {
    local target=$1
    local expected_source=$2
    local name=$3
    
    if [[ -L "$target" ]]; then
        local actual_source="$(readlink "$target")"
        if [[ "$actual_source" == "$expected_source" ]]; then
            pass "$name symlink correct"
        else
            fail "$name symlink points to wrong location: $actual_source"
        fi
    elif [[ -e "$target" ]]; then
        fail "$name exists but is not a symlink"
    else
        fail "$name symlink missing"
    fi
}

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

check_symlink "${HOME}/.config/tmux" "${DOTFILES_DIR}/tmux" "tmux"
check_symlink "${HOME}/.config/nvim" "${DOTFILES_DIR}/nvim" "neovim"
check_symlink "${HOME}/.config/fish" "${DOTFILES_DIR}/fish" "fish"
check_symlink "${HOME}/.vimrc" "${DOTFILES_DIR}/vim/.vimrc" "vim"
check_symlink "${HOME}/.config/starship.toml" "${DOTFILES_DIR}/starship.toml" "starship"

echo

# Check installed tools
info "Checking required tools:"
check_command() {
    local cmd=$1
    local name=${2:-$1}
    
    if command -v "$cmd" &> /dev/null; then
        local version=$($cmd --version 2>/dev/null | head -n 1 || echo "unknown")
        pass "$name ($(echo $version | cut -d' ' -f2- | head -c 30))"
    else
        fail "$name not installed"
    fi
}

check_command brew "Homebrew"
check_command git "Git"
check_command nvim "Neovim"
check_command tmux "tmux"
check_command fish "Fish shell"
check_command starship "Starship prompt"
check_command zoxide "Zoxide"
check_command eza "Eza"
check_command rg "Ripgrep"
check_command fzf "FZF"
check_command lazygit "LazyGit"
check_command sesh "Sesh"

echo

# Check fish configuration
info "Checking Fish shell configuration:"
if [[ -f "${HOME}/.config/fish/secrets.fish" ]]; then
    pass "Secrets file exists"
    # Check if it has content (not just template)
    if grep -q "your-api-key-here\|YOUR-API-KEY-HERE" "${HOME}/.config/fish/secrets.fish" 2>/dev/null; then
        warn "Secrets file appears to contain template values"
    fi
else
    fail "Secrets file missing (copy from secrets.fish.example)"
fi

# Check if fish is default shell
if [[ "$SHELL" == *"fish"* ]]; then
    pass "Fish is default shell"
else
    warn "Fish is not default shell (current: $SHELL)"
fi

echo

# Check tmux plugins
info "Checking tmux plugins:"
if [[ -d "${HOME}/.config/tmux/plugins/tpm" ]]; then
    pass "TPM (tmux plugin manager) installed"
    
    # Count installed plugins
    plugin_count=$(ls -1 "${HOME}/.config/tmux/plugins" 2>/dev/null | wc -l)
    if [[ $plugin_count -gt 1 ]]; then
        pass "$((plugin_count - 1)) tmux plugins installed"
    else
        warn "No tmux plugins installed (run prefix+I in tmux)"
    fi
else
    fail "TPM not installed"
fi

echo

# Check Neovim plugins
info "Checking Neovim setup:"
if [[ -d "${HOME}/.local/share/nvim/lazy" ]]; then
    plugin_count=$(ls -1 "${HOME}/.local/share/nvim/lazy" 2>/dev/null | wc -l)
    pass "$plugin_count Neovim plugins installed"
else
    warn "Neovim plugins not installed (will install on first launch)"
fi

echo

# Check git configuration
info "Checking Git configuration:"
if git config --global user.email &> /dev/null; then
    email=$(git config --global user.email)
    pass "Git email configured: $email"
else
    warn "Git email not configured"
fi

if git config --global user.name &> /dev/null; then
    name=$(git config --global user.name)
    pass "Git name configured: $name"
else
    warn "Git name not configured"
fi

echo
echo -e "${BLUE}═══════════════════════════════════════${NC}"

# Summary
errors=$(grep -c "✗" <<< "$0" 2>/dev/null || echo 0)
warnings=$(grep -c "⚠" <<< "$0" 2>/dev/null || echo 0)

if [[ -t 1 ]]; then  # If running in terminal
    if [[ $errors -eq 0 ]]; then
        if [[ $warnings -eq 0 ]]; then
            echo -e "${GREEN}All checks passed! 🎉${NC}"
        else
            echo -e "${GREEN}Setup complete with minor warnings${NC}"
        fi
    else
        echo -e "${RED}Some checks failed. Run ./install.sh to fix.${NC}"
    fi
fi
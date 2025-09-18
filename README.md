# Dotfiles Configuration

Modern development environment setup with tmux, neovim (LazyVim), and fish shell.

## Prerequisites

Install Homebrew if not already installed:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Quick Setup

Clone the repository and set up symlinks:

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles

# Create symlinks (this will backup your existing configs)
ln -sf $PWD/tmux ~/.config/tmux
ln -sf $PWD/nvim ~/.config/nvim  
ln -sf $PWD/fish ~/.config/fish
```

## Shell (Fish)

### Installation
```bash
brew install fish
```

### Configuration
The fish configuration includes:
- **starship** prompt
- **zoxide** for smart directory jumping
- **asdf** for version management
- Custom aliases and PATH setup

### Required tools:
```bash
# Starship prompt
brew install starship

# Zoxide for directory navigation  
brew install zoxide

# Eza for better ls
brew install eza

# LazyGit
brew install lazygit
```

## Terminal Multiplexer (Tmux)

### Installation
```bash
brew install tmux
```

### Features
- **Prefix**: `Ctrl-a` (changed from default `Ctrl-b`)
- **Theme**: Everforest color scheme with tmux2k
- **Session management**: Integrated with sesh for fast switching
- **Automatic restore**: Sessions persist across restarts
- **Status bar**: Minimal, positioned at top

### Key Bindings
- `prefix + |`: Split horizontally
- `prefix + -`: Split vertically  
- `prefix + o`: Open session switcher (sesh)
- `prefix + r`: Reload config
- `prefix + h/j/k/l`: Navigate panes (vim-style)

### Plugin Management
Plugins are managed with TPM. After setup, install plugins:
```bash
# In tmux, press prefix + I to install plugins
```

## Editor (Neovim with LazyVim)

### Installation
```bash
brew install neovim
```

### Features
- **LazyVim**: Modern Neovim configuration framework
- **Plugin management**: Lazy.nvim with locked versions
- **LSP**: Language servers via Mason
- **AI integration**: Claude Code, Kulala for REST APIs
- **Database**: vim-dadbod for database management

### Plugin Version Management
The `nvim/lazy-lock.json` file is version controlled to ensure consistent plugin versions across machines. To update:

1. Update plugins: `:Lazy update` 
2. Commit the updated lazy-lock.json file

## Version Management (asdf)

Follow [official instructions](https://asdf-vm.com/#/core-manage-asdf-vm) to install asdf.

Common plugins:
```bash
asdf plugin-add ruby
asdf plugin-add nodejs  
asdf plugin-add python
```

## Search and File Tools

```bash
# Ripgrep for fast searching
brew install ripgrep

# FZF for fuzzy finding
brew install fzf

# File navigation
brew install zoxide
```

## Homebrew Packages

Install all recommended packages:
```bash
brew bundle --file=homebrew/Brewfile
```

## Configuration Structure

```
dotfiles/
├── fish/           # Fish shell configuration
│   ├── config.fish
│   ├── conf.d/     # Configuration snippets
│   └── functions/  # Custom fish functions
├── nvim/           # Neovim LazyVim configuration  
│   ├── init.lua
│   ├── lazy-lock.json
│   └── lua/        # Lua configuration files
├── tmux/           # Tmux configuration
│   ├── tmux.conf
│   ├── scripts/    # Custom tmux scripts
│   └── plugins/    # TPM plugins
└── homebrew/       # Package definitions
    └── Brewfile
```

## Troubleshooting

### Fish shell errors
If you see OMF-related errors, the legacy Oh My Fish configuration has been removed. Restart your shell.

### Tmux plugins not working
Make sure TPM is installed:
```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```
Then press `prefix + I` in tmux.

### Neovim plugins not loading
LazyVim will automatically install plugins on first launch. If issues persist:
```bash
rm -rf ~/.local/share/nvim
nvim  # Will reinstall everything
```
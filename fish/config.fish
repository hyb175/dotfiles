#!/usr/bin/env fish

# Set nvim as editor
set -gx EDITOR nvim

# common tools
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH /opt/homebrew/sbin $PATH
set -gx PATH /run/current-system/sw/bin $PATH

set -gx PATH $HOME/.local/bin $PATH
# asdf
source /opt/homebrew/opt/asdf/libexec/asdf.fish

# starship prompt
starship init fish | source

# zoxide init
zoxide init fish | source

# autojump
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

# buildpack cli
source (pack completion --shell fish)

# Source secrets file if it exists (contains API keys and sensitive data)
if test -f ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end

set -gx PATH /opt/homebrew/opt/mysql-client@8.0/bin $PATH

set -gx ANDROID_HOME $HOME/Library/Android/sdk/
set -gx PATH $ANDROID_HOME/platform-tools $PATH
set -gx PATH $ANDROID_HOME/tools $PATH
set -gx PATH $HOME/.kubescape/bin $PATH

set -gx GPG_TTY tty

# Fix PATH order specifically in tmux
if set -q TMUX
    fish_add_path --move --prepend ~/.asdf/shims
end

alias lg=lazygit
alias ll="eza -l"
alias ta="tmux attach"

string match -q "$TERM_PROGRAM" "kiro" and . (kiro --locate-shell-integration-path fish)
fish_add_path $HOME/.local/bin

#!/bin/bash

# Tmux Development Environment Setup Script
# Usage: ~/.config/tmux/scripts/dev-env.sh [session-name]

SESSION_NAME="${1:-dev}"
MYCASE_BASE="$HOME/mycase"

# Check if session already exists
tmux has-session -t "$SESSION_NAME" 2>/dev/null
if [ $? -eq 0 ]; then
    echo "Session '$SESSION_NAME' already exists. Attaching..."
    tmux attach-session -t "$SESSION_NAME"
    exit 0
fi

# Create new session with mycase_app window - 3 panes
tmux new-session -d -s "$SESSION_NAME" -n mycase_app -c "$MYCASE_BASE/mycase_app"

# Split - logs on left (main), services on right
tmux split-window -t "$SESSION_NAME:mycase_app" -h -p 30 -c "$MYCASE_BASE/mycase_app"
tmux split-window -t "$SESSION_NAME:mycase_app.1" -v -p 50 -c "$MYCASE_BASE/mycase_app"

# Run commands in each pane
tmux send-keys -t "$SESSION_NAME:mycase_app.0" 'tail -f log/development.log' C-m
tmux send-keys -t "$SESSION_NAME:mycase_app.1" 'env PORT=3002 env LOCAL_SSL_ENABLED=false bundle exec puma -C config/puma.rb' C-m
tmux send-keys -t "$SESSION_NAME:mycase_app.2" 'foreman start' C-m

# Create mycase_login window - 3 panes
tmux new-window -t "$SESSION_NAME" -n mycase_login -c "$MYCASE_BASE/mycase_login"

# Split - logs on left (main), services on right
tmux split-window -t "$SESSION_NAME:mycase_login" -h -p 30 -c "$MYCASE_BASE/mycase_login"
tmux split-window -t "$SESSION_NAME:mycase_login.1" -v -p 50 -c "$MYCASE_BASE/mycase_login"

# Run commands in each pane
tmux send-keys -t "$SESSION_NAME:mycase_login.0" 'tail -f log/development.log' C-m
tmux send-keys -t "$SESSION_NAME:mycase_login.1" 'env PORT=3001 bundle exec puma -C config/puma.rb' C-m
tmux send-keys -t "$SESSION_NAME:mycase_login.2" 'foreman start' C-m

# Select first window and attach
tmux select-window -t "$SESSION_NAME:mycase_app"
tmux attach-session -t "$SESSION_NAME"
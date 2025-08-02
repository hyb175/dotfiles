#!/bin/bash

# Node.js Development Environment
# Usage: ~/.config/tmux/scripts/dev-node.sh [session-name] [project-path]

SESSION_NAME="${1:-node-dev}"
PROJECT_PATH="${2:-$PWD}"

# Check if session exists
tmux has-session -t "$SESSION_NAME" 2>/dev/null
if [ $? -eq 0 ]; then
    echo "Session '$SESSION_NAME' already exists. Attaching..."
    tmux attach-session -t "$SESSION_NAME"
    exit 0
fi

# Main editor window
tmux new-session -d -s "$SESSION_NAME" -n editor -c "$PROJECT_PATH"
tmux send-keys -t "$SESSION_NAME:editor" 'nvim .' C-m

# Services window - 4 panes for different services
tmux new-window -t "$SESSION_NAME" -n services -c "$PROJECT_PATH"
tmux split-window -t "$SESSION_NAME:services" -h -p 50 -c "$PROJECT_PATH"
tmux split-window -t "$SESSION_NAME:services.0" -v -p 50 -c "$PROJECT_PATH"
tmux split-window -t "$SESSION_NAME:services.2" -v -p 50 -c "$PROJECT_PATH"

# Run different services in each pane
tmux send-keys -t "$SESSION_NAME:services.0" 'npm run dev' C-m
tmux send-keys -t "$SESSION_NAME:services.1" 'npm run test:watch' C-m
tmux send-keys -t "$SESSION_NAME:services.2" 'docker-compose logs -f' C-m
tmux send-keys -t "$SESSION_NAME:services.3" 'htop' C-m

# Git/Terminal window
tmux new-window -t "$SESSION_NAME" -n git -c "$PROJECT_PATH"
tmux send-keys -t "$SESSION_NAME:git" 'git status' C-m

# Attach to session
tmux select-window -t "$SESSION_NAME:editor"
tmux attach-session -t "$SESSION_NAME"
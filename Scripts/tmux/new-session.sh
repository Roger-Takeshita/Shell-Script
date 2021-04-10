#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

TMUX_RUNNING=$(tmux ls 2>&1 | grep 'no server running' | xargs)

if [ "$1" == "" ]; then
    SESSION_NAME="Roger-That"
else
    SESSION_NAME=$1
fi

if [ "$TMUX_RUNNING" == "" ]; then
    # echo "TMUX is Running"
    tmux new -s $SESSION_NAME
else
    # echo "No TMUX Running"
    tmux new-session -s $SESSION_NAME
fi

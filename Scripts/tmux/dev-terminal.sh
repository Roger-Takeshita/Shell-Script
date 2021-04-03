#!/bin/bash

# tmux clear-history
# tmux new-session -s Dev -n DevOne
# tmux select-window -t Dev:DevOne
tmux rename-session Dev
tmux rename-window DevOne
tmux split-window -v
tmux split-window -h

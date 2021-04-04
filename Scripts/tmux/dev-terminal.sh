#!/bin/bash

# tmux clear-history
# tmux new-session -s Dev -n One
# tmux select-window -t Dev:One
tmux rename-session Dev
tmux rename-window One
tmux split-window -v
tmux split-window -h

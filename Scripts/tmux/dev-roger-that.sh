#!/bin/bash

tmux rename-session Roger-That
tmux rename-window Terminal
tmux send 'cd ~/Desktop' ENTER
tmux send 'clear' ENTER
cd ~/Documents/Codes
tmux new-window -n Dev
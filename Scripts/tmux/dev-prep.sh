#!/bin/bash

tmux rename-session PrepAnywhere
tmux rename-window Terminal
tmux send 'cd ~/Desktop' ENTER
tmux send 'clear' ENTER
cd ~/Documents/Codes/PrepAnywhere_Notes
tmux new-window -n Notes
cd ~/Documents/Codes/PrepAnywhere/Prepanywhere_Tutor_City
tmux new-window -n PrepAnywhere
cd ~/Documents/Codes/PrepAnywhere/Engines
tmux split-window -v
cd ~/Documents/Codes/PrepAnywhere/CloudFormation
tmux split-window -h
tmux new-window -n TeacherSeat
cd ~/Documents/Codes/TeacherSeat/Playground
tmux split-window -v
cd ~/Documents/Codes/TeacherSeat/Documentation/ts_standards
tmux split-window -h
cd ~/Documents/Codes/TeacherSeat/CloudFormation
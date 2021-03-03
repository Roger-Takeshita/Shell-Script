#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

NUM=$1

if [ ! $NUM ]; then
    git reset HEAD~1
else
    git reset HEAD~$NUM
fi
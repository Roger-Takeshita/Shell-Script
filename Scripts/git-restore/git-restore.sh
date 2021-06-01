#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

FILES=$@

if [ -z $FILES ]; then
    git restore .
else
    for FILE in $@; do
        git restore $FILE
    done
fi
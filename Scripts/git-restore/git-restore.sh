#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

FILE=$1

if [ "$FILE" = "" ]; then
    git restore .
else
    git restore $FILE
fi
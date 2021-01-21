#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'      # reset color
lRD=$'\e[38;5;1m'   # light red

name=$@

if [ "$name" != "" ]; then
    # + Removes the timestamps
    # defaults write com.apple.screencapture "include-date" 0
    # + Adds back the timestamps
    # defaults write com.apple.screencapture "include-date" 1
    # + Removes shadows
    # defaults write com.apple.screencapture disable-shadow -bool true
    # + Changes the filename
    defaults write com.apple.screencapture name "$name"
    killall SystemUIServer
else
    echo "${lRD}Output filename is missing${RSTC}"
fi
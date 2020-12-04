#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

red=$'\e[31m'
default=$'\e[39m'

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
    echo "${red}Output filename is missing${default}"
fi
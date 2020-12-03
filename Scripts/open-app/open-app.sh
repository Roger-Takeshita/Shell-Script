#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

orange=$'\e[38;5;202m'
default=$'\e[39m'

app=$@
foundApp=$(ls "/Applications/" | grep -i "$app")

if [ "$foundApp" != "" ]; then
    open -n -a "$foundApp"
else
    echo "Unable to find application named ${orange}$app${default}"
fi
#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'       # reset color
CLOG=$'\e[38;5;215m' # light orange

app=$@
foundApp=$(ls "/Applications/" | grep -i "$app")

if [ "$foundApp" != "" ]; then
    echo "Opening $foundApp..."
    open -n -a "$foundApp"
else
    echo "Unable to find application named ${CLOG}${app}${RSTC}"
fi
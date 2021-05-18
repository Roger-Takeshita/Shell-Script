#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

ARG=$1

if [ -z $ARG ]; then
    BRANCH_NAME=$(git branch --show-current)
    echo "${BRANCH_NAME}" | tr -d '\n'| pbcopy
else
    if [ "$ARG" = "m" ]; then
        BRANCH="maintenance"
    elif [ "$ARG" = "f" ]; then
        BRANCH="feature"
    elif [ "$ARG" = "b" ]; then
        BRANCH="bug"
    else
        exit 1
    fi

    echo "git checkout -b ${BRANCH}/PREP-" | tr -d '\n' | pbcopy
fi
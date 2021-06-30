#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

ARG=$1
JIRA=$2

if [ -z $ARG ]; then
    git branch -a
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

    echo "git checkout -b ${BRANCH}/${JIRA}-" | tr -d '\n' | pbcopy
fi
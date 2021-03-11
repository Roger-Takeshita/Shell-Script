#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script


ARGS=$@
HARD=0
NUM=0

if [[ "$@" =~ -+hard($| )|-+HARD($| )|-+h($| ) ]]; then
    HARD=1;
fi

if [[ "$@" =~ .*([0-9]+).* ]]; then
    NUM=${BASH_REMATCH[1]}
fi

if [ $NUM -eq 0 ] && [ $HARD -eq 0 ]; then
    git reset
elif [ $NUM -eq 0 ] && [ $HARD -eq 1 ]; then
    git reset HEAD~1 --hard
elif [ $NUM -eq 1 ] && [ $HARD -eq 1 ]; then
    git reset HEAD~$NUM --hard
else
    git reset HEAD~$NUM
fi
#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script


ARGS=$@
HARD=0
NUM=1

if [[ "$@" =~ -+hard($| )|-+HARD($| )|-+h($| ) ]]; then
    HARD=1;
fi

if [[ "$@" =~ .*([0-9]+).* ]]; then
    NUM=${BASH_REMATCH[1]}
fi

if [ $HARD -eq 1 ]; then
    git reset HEAD~$NUM --hard
else
    git reset HEAD~$NUM
fi
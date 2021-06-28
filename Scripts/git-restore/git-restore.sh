#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

ARGS=$@

if [ -z $ARGS ]; then
    git restore .
else
    ARGS_ARRARY=($(echo "$ARGS" | sed -E 's/[ ]*[ ](M|D)[ ][ ]*/ /g' | xargs))

    for ITEM in ${ARGS_ARRARY[*]}; do
        git restore $ITEM
    done
fi
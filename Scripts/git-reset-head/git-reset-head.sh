#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script


ARGS=$@
HARD=0
NUM=0

[[ "$@" =~ -+hard($| )|-+HARD($| )|-+h($| ) ]] && HARD=1
[[ "$@" =~ .*([0-9]+).* ]] && NUM=${BASH_REMATCH[1]}

if [ $NUM -eq 0 ] && [ $HARD -eq 0 ]; then
    if [ $# -gt 0 ]; then
        ARGS_ARRARY=($(echo "$ARGS" | sed -E 's/[ ]*(\?|M|D|N new file:)[ ]*/ /g' | xargs))
        for ITEM in ${ARGS_ARRARY[*]}; do
            git reset $ITEM 1>/dev/null
        done
    else
        git reset 1>/dev/null
    fi
elif [ $NUM -eq 0 ] && [ $HARD -eq 1 ]; then
    git reset HEAD~1 --hard
elif [ $NUM -gt 0 ] && [ $HARD -eq 1 ]; then
    git reset HEAD~$NUM --hard
else
    git reset HEAD~$NUM
fi
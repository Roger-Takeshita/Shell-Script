#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'       # reset color
CBL=$'\e[38;5;27m'   # blue
CLGN=$'\e[38;5;2m'   # light green
CLOG=$'\e[38;5;215m' # light orange
CLRD=$'\e[38;5;1m'   # light red

RSTF=$'\e[0m'        # reset format
Bold=$'\e[1m'
Blink=$'\e[5m'
NoBlink=$'\e[25m'

gitPull() {
    if [ -d "$1/.git" ]; then
        BRANCH=`cd $1; git branch --show-current`
        echo "${Bold}${CBL}——————› $(basename $1)${RST}${RSTF}"

        if [ -n $BRANCH ]; then
            RESPONSE=`cd $1; git pull origin $BRANCH`
            if [[ $RESPONSE =~ '.*Fast-forward.*' ]] || [[ $RESPONSE == 'Already up to date.' ]]; then
                echo "${CLGN}${RESPONSE}${RSTC}"
            else
                echo "${Blink}${CLRD}${Bold}ATTENTION!${RSTF}${RSTC}${NoBlink} ${CLOG}Something went wrong.${RSTC}"
            fi
        fi
    elif [ -d "$1" ]; then
        COUNT_FILES=`ls $1 | wc -l`

        if [ $COUNT_FILES -gt 0 ]; then
            for FILE in $1/*; do
                NEXT_FOLDER=`basename "$FILE"`

                if [ "$NEXT_FOLDER" != ".rmv" ] && [ "$NEXT_FOLDER" != ".vscode" ] && [ "$NEXT_FOLDER" != ".git" ] && [ "$NEXT_FOLDER" != "node_modules" ] && [ "$NEXT_FOLDER" != "node_modules.nosync" ]; then
                    gitPull $FILE
                fi
            done
        fi
    fi
}

gitPull `pwd`
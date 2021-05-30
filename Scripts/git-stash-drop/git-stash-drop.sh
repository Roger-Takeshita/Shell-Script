#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'         # reset color
CLGY=$'\e[38;5;240m'   # gray
CLBL=$'\e[38;5;117m'   # light blue
CLGN=$'\e[38;5;2m'     # light green
CLOG=$'\e[38;5;215m'   # light orange
CLRD=$'\e[38;5;1m'     # light red
RSTF=$'\e[0m'
Dim=$'\e[2m'
Bold=$'\e[1m'

NUM=$1

[ -z $NUM ] && NUM=0

errorMsg() {
    local MSG=$1
    local errorCode=$2

    echo "${CLRD}${MSG}${RSTC}"
    echo ""
    exit $errorCode
}

stashDrop() {
    echo ""
    ERROR=$(git stash show stash@{$NUM} 2>&1 > /dev/null)
    [ "$ERROR" != "" ] && errorMsg "${ERROR}\n${CLBL}stash@{${CLOG}${Bold}${NUM}${RSTF}${CLBL}}${CLRD} doesn't exist!" 22

    FILES=$(git stash show stash@{$NUM} | sed -E "s/([+]+)/${CLGN}\1${RSTC}/g" | sed -E "s/([-]+)/${CLRD}\1${RSTC}/g")
    echo $FILES
    echo ""

    echo -n "Are you sure you want to drop stash ${CLOG}${Bold}${NUM}${RSTC}${RSTF}: ${Dim}${CLGY}(Y/n)${RSTC}${RSTF} "
    read ANSWER

    if [ -z $ANSWER ] || [ "$ANSWER" = "y" ] || [ "$ANSWER" = "Y" ]; then
        echo "$CLGN$(git stash drop stash@{$NUM})$RSTC"
    else
        errorMsg "Operation canceled!" 125
    fi
    echo ""
}

stashDrop
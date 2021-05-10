#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'         # reset color
CLGY=$'\e[38;5;240m'   # gray
CLGN=$'\e[38;5;2m'     # light green
CLOG=$'\e[38;5;215m'   # light orange
CLRD=$'\e[38;5;1m'     # light red
RSTF=$'\e[0m'
Dim=$'\e[2m'
Bold=$'\e[1m'

NUM=$1

if [ ! $NUM ]; then
    NUM=0
fi

echo ""
FILES=$(git stash show stash@{$NUM} | sed -E "s/([+]+)/${CLGN}\1${RSTC}/g" | sed -E "s/([-]+)/${CLRD}\1${RSTC}/g")
echo $FILES
echo ""
echo -n "Are you sure you want to drop stash ${CLOG}${Bold}${NUM}${RSTC}${RSTF}: ${Dim}${CLGY}(Y/n)${RSTC}${RSTF} "
read ANSWER

if [ "$ANSWER" = "" ] || [ "$ANSWER" = "Y" ] || [ "$ANSWER" = "y" ] || [ "$ANSWER" = "Yes" ] || [ "$ANSWER" = "yes" ]; then
    echo $CLGN$(git stash drop stash@{$NUM})$RSTC
else
    echo "${CLRD}Process aborted!${RSTC}"
fi

echo ""

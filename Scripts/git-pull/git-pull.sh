#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

dir=`pwd`
RSTC=$'\e[39m'      # reset color
BL=$'\e[38;5;27m'   # blue
lGN=$'\e[38;5;2m'   # light green
lOG=$'\e[38;5;215m' # light orange
lRD=$'\e[38;5;1m'   # light red

RSTF=$'\e[0m'       # reset format
Bold=$'\e[1m'
Blink=$'\e[5m'
NoBlink=$'\e[25m'
regex='^Updating .*$'

gitPull() {
    if [ -d "$1/.git" ]; then
        main=`cd $1; git show-ref refs/heads/main`
        master=`cd $1; git show-ref refs/heads/master`
        branch=''

        echo "$Bold$BL——————› $(basename $1)$RST$RSTF"

        if [ -n "$main" ]; then
            branch="main"
        elif [ -n "$master" ]; then
            branch="master"
        fi

        if [ -n $branch ]; then
            response=`cd $1; git pull origin $branch`
            if [[ $response =~ '.*Fast-forward.*' ]] || [[ $response == 'Already up to date.' ]]; then
                echo "${lGN}${response}${RST}"
            else
                echo "${Blink}${lRD}${Bold}ATTENTION!${RSTF}${RST}${NoBlink} ${lOG}Uncommited changes.${RST}"
            fi
        fi
    fi
}

gitPull $dir/

for f in $dir/*
do
    gitPull $f
done
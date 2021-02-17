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
        # main=`cd $1; git show-ref refs/heads/main`
        # master=`cd $1; git show-ref refs/heads/master`
        branch=`cd $1; git branch --show-current`

        echo "${Bold}${CBL}——————› $(basename $1)${RST}${RSTF}"

        # if [ -n "$main" ]; then
        #     branch="main"
        # elif [ -n "$master" ]; then
        #     branch="master"
        # fi

        if [ -n $branch ]; then
            response=`cd $1; git pull origin $branch`
            if [[ $response =~ '.*Fast-forward.*' ]] || [[ $response == 'Already up to date.' ]]; then
                echo "${CLGN}${response}${RSTC}"
            else
                echo "${Blink}${CLRD}${Bold}ATTENTION!${RSTF}${RSTC}${NoBlink} ${CLOG}Uncommited changes.${RSTC}"
            fi
        fi
    elif [ -d "$1" ]; then
        for file2 in $1/*; do
            gitPull $file2
        done
    fi
}

gitPull `pwd`
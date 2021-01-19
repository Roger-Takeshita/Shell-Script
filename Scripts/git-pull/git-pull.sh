#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

dir=`pwd`
RST=$'\e[39m'      # reset color
RD=$'\e[31m'       # red
GN=$'\e[32m'       # green
BL=$'\e[34m'       # blue
OG=$'\e[38;5;202m' # orange
Bold=$'\e[1m'
End=$'\e[0m'       # reset format
Blink=$'\e[5m'
NoBlink=$'\e[25m'
regex='^Updating .*$'

gitPull() {
    if [ -d "$1/.git" ]; then
        main=`cd $1; git show-ref refs/heads/main`
        master=`cd $1; git show-ref refs/heads/master`
        branch=''

        echo "$Bold$BL→ $(basename $1)$RST$End"

        if [ -n "$main" ]; then
            branch="main"
        elif [ -n "$master" ]; then
            branch="master"
        fi

        if [ -n $branch ]; then
            response=`cd $1; git pull origin $branch | xargs`
            if [[ $response =~ '(Updating .*)' ]]; then
                echo "${Blink}${RD}${Bold}Aborted!${End}${RST}${NoBlink} ${OG}Uncommited changes.${RST}"
            else
                echo "${GN}${response}${RST}"
            fi
        fi
    fi
}

gitPull $dir/

for f in $dir/*
do
    gitPull $f
done
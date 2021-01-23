#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

# tput reset

DIR="`pwd`"
RSTC=$'\e[39m'       # reset color
CGY=$'\e[38;5;240m'  # gray
CLGN=$'\e[38;5;2m'   # light green
CLRD=$'\e[38;5;1m'   # light red
RSTF=$'\e[0m'
Bold=$'\e[1m'
mode='single-folder'

echoFolderName() {
    if [ "$mode" = "single-folder" ]; then
        echo "${CLRD}Modified/Untracked"
    else if
        # echo "${CLRD}Modified/Untracked --> ${1##*/}${RST}"
        echo "${CLRD}${Bold}——————› ${1##*/}${RSTF}${RST}"
    fi
}

gitStatus() {
    if [ -d "$1/.git" ]; then
        statusFlag=0
        cd $1

        if [ $(git status | grep modified -c) -ne 0 ]; then
            if [ $statusFlag -eq 0 ]; then
                echoFolderName $1
                statusFlag=1
            fi
        fi

        if [ $(git status | grep Untracked -c) -ne 0 ]; then
            if [ $statusFlag -eq 0 ]; then
                echoFolderName $1
                statusFlag=1
            fi
        fi

        unpushedCommit=$(git status | grep 'Your branch is ahead' -c)
        if [ $unpushedCommit -ne 0 ]; then
            if [ $statusFlag -eq 0 ]; then
                echoFolderName $1
                statusFlag=1
            fi

            if [ $unpushedCommit -eq 1 ]; then
                echo "${CLGN}   $unpushedCommit Unpushed Commit"
            else
                echo "${CLGN}   $unpushedCommit Unpushed Commits"
            fi
        fi

        # if [ $statusFlag -eq 0 ]; then
        #     if [ "$mode" = "single-folder" ]; then
        #         echo "${CGY}Nothing to Commit"
        #     else if
        #         echo "${CGY}Nothing to Commit  --> ${1##*/}${RST}"
        #     fi
        # fi

        git status -s
        cd ../
    fi
}

gitStatus $DIR/

for f in $DIR/*
do
    mode='nested-folder'
    gitStatus $f
done
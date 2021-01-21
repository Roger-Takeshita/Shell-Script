#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

tput reset

dir="`pwd`"
RSTC=$'\e[39m'      # reset color
GY=$'\e[38;5;240m'  # gray
lGN=$'\e[38;5;2m'   # light green
lRD=$'\e[38;5;1m'   # light red
RSTF=$'\e[0m'
Bold=$'\e[1m'
mode='single-folder'

echoFolderName() {
    if [ "$mode" = "single-folder" ]; then
        echo "${lRD}Modified/Untracked"
    else if
        # echo "${lRD}Modified/Untracked --> ${1##*/}${RST}"
        echo "${lRD}${Bold}——————› ${1##*/}${RSTF}${RST}"
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
                echo "${lGN}   $unpushedCommit Unpushed Commit"
            else
                echo "${lGN}   $unpushedCommit Unpushed Commits"
            fi
        fi

        # if [ $statusFlag -eq 0 ]; then
        #     if [ "$mode" = "single-folder" ]; then
        #         echo "${GY}Nothing to Commit"
        #     else if
        #         echo "${GY}Nothing to Commit  --> ${1##*/}${RST}"
        #     fi
        # fi

        git status -s
        cd ../
    fi
}

gitStatus $dir/

for f in $dir/*
do
    mode='nested-folder'
    gitStatus $f
done
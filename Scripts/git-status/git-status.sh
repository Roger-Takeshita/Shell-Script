#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

tput reset

dir="`pwd`"
RST=$'\e[0m'
RD=$'\e[31m'
GN=$'\e[32m'
GY=$'\e[2m'
Bold=$'\e[1m'
End=$'\e[0m'
mode='single-folder'

echoFolderName() {
    if [ "$mode" = "single-folder" ]; then
        echo "${RD}Modified/Untracked"
    else if
        # echo "${RD}Modified/Untracked --> ${1##*/}${RST}"
        echo "${RD}${Bold}→ ${1##*/}${End}${RST}"
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
                echo "${GN}   $unpushedCommit Unpushed Commit"
            else
                echo "${GN}   $unpushedCommit Unpushed Commits"
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
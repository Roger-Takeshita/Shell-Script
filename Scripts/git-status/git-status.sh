#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

tput reset

dir="`pwd`"
red=$'\e[0;31m'
yel=$'\e[0;33m'
gry=$'\e[0;2m'
end=$'\e[0m'
mode='single-folder'

echoFolderName() {
    if [ "$mode" = "single-folder" ]; then
        echo "${red}Modified/Untracked"
    else if
        echo "${red}Modified/Untracked --> ${1##*/}${end}"
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
                echo "${yel}  $unpushedCommit Unpushed Commit"
            else
                echo "${yel}  $unpushedCommit Unpushed Commits"
            fi
        fi

        if [ $statusFlag -eq 0 ]; then
            if [ "$mode" = "single-folder" ]; then
                echo "${gry}Nothing to Commit"
            else if
                echo "${gry}Nothing to Commit  --> ${1##*/}${end}"
            fi
        fi

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
#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'       # reset color
CLGN=$'\e[38;5;2m'   # light green
CLRD=$'\e[38;5;1m'   # light red

DIR=''
OPEN_FILE=1
JOIN_FLAG=0

if [ $# -eq 0 ]; then
    echo "${CLRD}ERROR:${RSTC} I need a file"
    exit 1
fi

if [[ "$@" =~ .*"-n".* ]]; then
    OPEN_FILE=0;
fi

function tFile () {
    local DIRECTORY=$1
    local FILE=$2
    local FILE_PATH="${DIRECTORY}${FILE}"

    if [ ! -f $FILE_PATH ]; then
        touch $FILE_PATH
    else
        printf "%s\n" "${DIRECTORY}${CLGN}${FILE}${RSTC} - ${CLRD}Already Exists${RSTC}"
    fi

    if [ $OPEN_FILE -eq 1 ]; then
        code $FILE_PATH
    fi
}

function mDir () {
    local FOLDER=$1

    if [ ! -d "$FOLDER" ]; then
        mkdir -p "$FOLDER"
    fi
}

function touchFiles () {
    local FILES=$@

    for item1 in $FILES; do
        IFS='/' read -ra FOLDER <<< "$item1"

        if [ $item1 == "+" ]; then
            JOIN_FLAG=1
            continue
        elif [ $item1 == "-n" ]; then
            continue
        elif [ $JOIN_FLAG -eq 1 ]; then
            JOIN_FLAG=0
        else
            DIR=''
        fi

        for item2 in ${FOLDER[@]}; do
            if [ "$item2" == "Dockerfile" ] || [ "$item2" == "Procfile" ] || [ "$item2" == "LICENSE" ]; then
                tFile $DIR $item2
                continue
            elif [ "$item2" == ".ssh" ] || [ "$item2" == ".ssl" ] || [ "$item2" == ".vscode" ]; then
                DIR="${DIR}${item2}/"
                mDir $DIR
                continue
            fi

            if [[ ${item2%.*} == ${item2##*.} ]]; then
                DIR="${DIR}${item2}/"
                mDir $DIR
            else
                tFile $DIR $item2
            fi
        done
    done
}

touchFiles $@

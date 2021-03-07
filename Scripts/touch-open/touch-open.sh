#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'       # reset color
CLGN=$'\e[38;5;2m'   # light green
CLRD=$'\e[38;5;1m'   # light red

DIR=''
OPEN_FILE=1
USE_PREV_DIR=1

rm -rf test/

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
        echo "exists"
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
    for item1 in $1
    do
        IFS='/' read -ra FOLDER <<< "$item1"

        if [ $item1 == "+" ]; then
            USE_PREV_DIR=1
            continue
        elif [ $item1 == "-n" ]; then
            continue
        elif [ $item1 == " " ]; then
            USE_PREV_DIR=0
            DIR=''
        fi

        for item2 in ${FOLDER[@]}; do
            if [[ ${item2%.*} == ${item2##*.} ]]; then
                if [ "$item2" == "Dockerfile" ] || [ "$item2" == "Procfile" ] || [ "$item2" == "LICENSE" ]; then
                    tFile $DIR $item2
                else
                    DIR="${DIR}${item2}/"
                fi
                mDir $DIR
            else
                tFile $DIR $item2
            fi
        done
    done
}

touchFiles $@

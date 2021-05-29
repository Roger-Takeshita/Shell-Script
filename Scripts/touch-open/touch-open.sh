#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'       # reset color
CLGN=$'\e[38;5;2m'   # light green
CLRD=$'\e[38;5;1m'   # light red

DIR=''
PREV_DIR=''
OPEN_FILE=0
JOIN_FLAG=0

if [ $# -eq 0 ]; then
    echo "${CLRD}ERROR:${RSTC} I need a file"
    exit 22
fi

touchFile () {
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

makeDir () {
    local FOLDER=$1

    if [ ! -d "$FOLDER" ]; then
        mkdir -p "$FOLDER"
    fi
}

touchFiles () {
    local FILES=$@
    if [[ "$FILES" =~ (.*[ ]?-y[ $]?) ]]; then
        OPEN_FILE=1
    fi

    for ITEM1 in $FILES; do
        IFS='/' read -ra FOLDER <<< "$ITEM1"
        LEN=${#FOLDER[@]}

        if [ $JOIN_FLAG -eq 0 ]; then
            DIR=''
        fi

        if [ $LEN -gt 1 ]; then
            for ITEM2 in ${FOLDER[@]}; do
                if [ "$ITEM2" == "Dockerfile" ] || [ "$ITEM2" == "Procfile" ] || [ "$ITEM2" == "LICENSE" ]; then
                    touchFile $DIR $ITEM2
                    continue
                elif [ "$ITEM2" == ".ssh" ] || [ "$ITEM2" == ".ssl" ] || [ "$ITEM2" == ".vscode" ]; then
                    DIR="${DIR}${ITEM2}/"
                    makeDir $DIR
                    continue
                fi

                if [[ "$ITEM2" =~ .*\..* ]]; then
                    touchFile $DIR $ITEM2
                else
                    DIR="${DIR}${ITEM2}/"

                    if [ "$ITEM2" != "${FOLDER[$LEN-1]}" ]; then
                        PREV_DIR=$DIR
                    fi

                    makeDir $DIR
                fi
            done
        else
            if [ $ITEM1 == "+" ]; then
                DIR="${PREV_DIR}/"
                JOIN_FLAG=1
                continue
            elif [ $ITEM1 == "-y" ]; then
                continue
            fi

            if [[ "$ITEM1" =~ .*\..* ]]; then
                if [ $JOIN_FLAG -eq 1 ]; then
                    JOIN_FLAG=0
                else
                    DIR=''
                fi

                touchFile $DIR $ITEM1
            else
                if [ $JOIN_FLAG -eq 1 ]; then
                    JOIN_FLAG=0
                    makeDir "${DIR}${ITEM1}/"
                else
                    makeDir $ITEM1
                fi
            fi
        fi
    done
}

touchFiles $@

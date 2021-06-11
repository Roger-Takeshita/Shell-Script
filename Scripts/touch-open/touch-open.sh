#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'       # reset color
CLGN=$'\e[38;5;2m'   # light green
CLRD=$'\e[38;5;1m'   # light red

DIR=''
PREV_DIR=''
OPEN_FILE=1
JOIN_FLAG=0
NORMAL_TOUCH=0

[ $# -eq 0 ] && echo "${CLRD}ERROR:${RSTC} I need a file" && exit 22

touchFile () {
    local DIRECTORY=$1
    local FILE=$2
    local FILE_PATH="${DIRECTORY}${FILE}"

    [[ "$FILE_PATH" =~ ^-[^\s]* ]] && FILE_PATH="./${FILE_PATH}"
    [ -f $FILE_PATH ] && printf "%s\n" "${DIRECTORY}${CLGN}${FILE}${RSTC} - ${CLRD}Already Exists${RSTC}"
    [ ! -f $FILE_PATH ] && touch $FILE_PATH
    [ $OPEN_FILE -eq 1 ] && [ ! -z $EDITOR ] && $EDITOR $FILE_PATH
}

makeDir () {
    local FOLDER=$1

    [[ "$FOLDER" =~ ^-[^\s]* ]] && FOLDER="./${FOLDER}"
    [ ! -d $FOLDER ] && mkdir -p $FOLDER
}

touchFiles () {
    local FILES=$@

    [[ "$FILES" =~ ( -n[ $]?) ]] && OPEN_FILE=0
    [[ "$FILES" =~ ( -d[ $]?) ]] && NORMAL_TOUCH=1

    if [ $NORMAL_TOUCH -eq 0 ]; then
        FILES=$(echo "$FILES" | sed -E 's/-(n|d)//g' | xargs)
        for ITEM1 in $FILES; do
            IFS='/' read -ra FOLDER <<< "$ITEM1"
            LEN=${#FOLDER[@]}

            [ $JOIN_FLAG -eq 0 ] && DIR=''

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
                        [ "$ITEM2" != "${FOLDER[$LEN-1]}" ] && PREV_DIR=$DIR
                        makeDir $DIR
                    fi
                done
            else
                if [ $ITEM1 == "+" ]; then
                    DIR="${PREV_DIR}/"
                    JOIN_FLAG=1
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
    else
        UPDATE_FILES=$(echo "$FILES" | sed -E 's/\s-(n|d)//g' | xargs)
        touch $UPDATE_FILES
        [ $OPEN_FILE -eq 1 ] && [ ! -z $EDITOR ] && $EDITOR $UPDATE_FILES
    fi
}

touchFiles $@

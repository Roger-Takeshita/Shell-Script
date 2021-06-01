#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

FGRST=$'\e[39m'       # reset color
FGLOG=$'\e[38;5;215m' # light orange
FGLRD=$'\e[38;5;1m'   # light red

NORMAL_REMOVE=0

[ $# -eq 0 ] && echo "${FGLRD}ERROR:${FGRST} I need a file" && exit 22

moveToTrash () {
  local FILES
  local FILE_FOLDER

  for FILE in "$@"; do
    if [[ "$FILE" =~ -[a-zA-Z0-9]+ ]]; then :
    else
        if [ -d $FILE ]; then
            FILE=$(echo $FILE | sed -E 's/\/$//g' | xargs)
            NEW_FILE="${FILE##*/} $(date +%H-%M-%S)"
        elif [ -f $FILE ]; then
            EXT="${FILE##*.}"
            FILE_NAME=${FILE%.*}
            FILENAME="${FILE_NAME##*/}"
            NEW_FILE="${FILENAME} $(date +%H-%M-%S).${EXT}"
        fi

        mv $FILE ~/.Trash/"${NEW_FILE}" 2>/dev/null
    fi
  done
}

removeFiles() {
    # echo "${FGLOG}Please enter the files:${FGRST}"
    # read -rp "" -d $'\04' FILES
    # UPDATE_FILES=$(echo "$FILES" | sed -E 's/[ ]*\?[ ]*/ /g' | xargs)
    # rm -rf $UPDATE_FILES

    local FILES=$@
    [[ "$FILES" =~ (.*[ ]?-n[ $]?) ]] && NORMAL_REMOVE=1

    UPDATE_FILES=$(echo "$FILES" | sed -E 's/[ ]*(\?|M|N new file:)[ ]*/ /g' | sed -E 's/-n[ $]?//g' | xargs)

    if [ $NORMAL_REMOVE -eq 0 ]; then
        moveToTrash $UPDATE_FILES
    else
        rm $UPDATE_FILES
    fi
}

removeFiles $@
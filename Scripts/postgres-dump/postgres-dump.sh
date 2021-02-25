#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'        # reset color
CBL=$'\e[38;5;27m'    # blue
CWHT=$'\e[38;5;15m'   # white
CLGN=$'\e[38;5;2m'    # light green
CLOG=$'\e[38;5;215m'  # light orange
CLRD=$'\e[38;5;1m'    # light red
BGRSTC=$'\e[49m'      # bg reset color
BGCGN=$'\e[48;5;34m'  # bg green

HOME_DIR=$(eval echo "~$USER")
DESKTOP_DIR="${HOME_DIR}/Desktop"
YEAR=$(date +"%Y")
MONTH=$(date +"%m")
DAY=$(date +"%d")
DATABASE_FILE=$@

function simpleErrorMsg () {
    local STATUS=$1

    if [[ "$STATUS" =~ .*"skipping".* ]]; then
    elif [ "${STATUS}" != "" ]; then
        echo "   ${CLRD}${STATUS}${RSTC}"
        echo ""
        exit 1
    fi
}

function deleteFolder () {
    local FOLDER=$1

    if [ -d "$FOLDER" ]; then
        rm -rf $FOLDER
    fi
}

if [ ${#DATABASE_FILE} -eq 0 ]; then
    echo ""
    echo "   ${CLRD}Process aborted: ${CLOG}please provide a database name.${RSTC}"
    echo ""
    exit 1
fi

if [ $# -gt 1 ]; then
    echo ""
    echo "   ${CLRD}Process aborted: ${CLOG}please provide only one argument.${RSTC}"
    echo ""
    exit 1
fi

POSTGRES_KEY_PATH="/Users/roger-that/Documents/Roger-That/Dev/1-Config/PostgreSQL/${DATABASE_FILE}.txt"

if [ ! -f "$POSTGRES_KEY_PATH" ]; then
    echo ""
    echo "   ${CLRD}Process aborted: ${CLOG}file doesn't exist.${RSTC}"
    echo "   ${CBL}${POSTGRES_KEY_PATH}${RSTC}"
    echo ""
    exit 1
fi

POSTGRES_KEY=$(cat "${POSTGRES_KEY_PATH}")
DUMP_FOLDER="${DESKTOP_DIR}/${YEAR}-${MONTH}-${DAY}_dump"
DATABASE_NAME="prepanywhere_dev_${DAY}_${MONTH}_${YEAR}"
deleteFolder $DUMP_FOLDER

echo ""
echo "   ${CLGN}Dumping remote database into ${CBL}${DUMP_FOLDER}${RSTC}"
pg_dump -j 8 -Fd $POSTGRES_KEY -f $DUMP_FOLDER
zip -r "$DUMP_FOLDER/${YEAR}-${MONTH}-${DAY}_dump" "${DUMP_FOLDER}" > /dev/null 2>&1
STATUS1=$(dropdb $DATABASE_NAME --if-exists 2>&1 1>/dev/null)
simpleErrorMsg $STATUS1
STATUS2=$(createdb $DATABASE_NAME 2>&1 1>/dev/null)
simpleErrorMsg $STATUS2
echo "   ${CLGN}Restoring local database ${CBL}${DATABASE_NAME}${RSTC}"
pg_restore -j 8 -d $DATABASE_NAME $DUMP_FOLDER
echo ""
echo "${BGCGN}${CWHT}All Done!${RSTC}${BGRSTC}"
echo ""

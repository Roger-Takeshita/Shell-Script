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
BGCOG=$'\e[48;5;166m' # bg orange

HOME_DIR=$(eval echo "~$USER")
DESKTOP_DIR="${HOME_DIR}/Desktop"
YEAR=$(date +"%Y")
MONTH=$(date +"%m")
DAY=$(date +"%d")
DATABASE_NAME=$@
SCRIPT_DIR=$(dirname "$0")
DATABASE_FILE="${SCRIPT_DIR}/database_connection.json"

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

if [ ${#DATABASE_NAME} -eq 0 ]; then
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

if [ ! -f "$DATABASE_FILE" ]; then
    echo ""
    echo "   ${CLRD}Process aborted: ${CLOG}file doesn't exist.${RSTC}"
    echo "   ${CBL}${DATABASE_FILE}${RSTC}"
    echo ""
    exit 1
fi

POSTGRES_URL=$(cat $DATABASE_FILE | grep "\"${DATABASE_NAME}\":" | sed 's/[\",]//g' | sed -e "s/\(${DATABASE_NAME}:\) \(.*\)/\2/" | xargs)

if [ "$POSTGRES_URL" = "" ]; then
    echo ""
    echo "   ${CLRD}Process aborted: ${BGCOG}${CWHT}${DATABASE_NAME}${BGRSTC}${CLOG} connection URL not found. Please double check if you have a field named ${BGCOG}${CWHT}${DATABASE_NAME}${BGRSTC} ${CLOG}in ${CBL}${DATABASE_FILE}${RSTC}"
    echo ""
    exit 1
fi

DUMP_FOLDER="${DESKTOP_DIR}/${YEAR}-${MONTH}-${DAY}_${DATABASE_NAME}_dump"
LOCAL_DATABASE_NAME="${DATABASE_NAME}_dev_${YEAR}_${MONTH}_${DAY}"
deleteFolder $DUMP_FOLDER

echo ""
echo "   ${CLGN}Dumping remote database into ${CBL}${DUMP_FOLDER}${RSTC}"
pg_dump -j 8 -Fd $POSTGRES_URL -f $DUMP_FOLDER
zip -r "$DUMP_FOLDER/${YEAR}-${MONTH}-${DAY}_${DATABASE_NAME}_dump" "${DUMP_FOLDER}" > /dev/null 2>&1
STATUS1=$(dropdb $LOCAL_DATABASE_NAME --if-exists 2>&1 1>/dev/null)
simpleErrorMsg $STATUS1
STATUS2=$(createdb $LOCAL_DATABASE_NAME 2>&1 1>/dev/null)
simpleErrorMsg $STATUS2
echo "   ${CLGN}Restoring local database ${CBL}${LOCAL_DATABASE_NAME}${RSTC}"
pg_restore -j 8 -d $LOCAL_DATABASE_NAME $DUMP_FOLDER
echo ""
echo "${BGCGN}${CWHT}All Done!${RSTC}${BGRSTC}"
echo ""
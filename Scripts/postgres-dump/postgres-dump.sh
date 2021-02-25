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

if [ -d "$DUMP_FOLDER" ]; then
    rm -rf $DUMP_FOLDER
fi

echo ""
echo "   ${CLGN}Dumping the database into ${CBL}${DUMP_FOLDER}${CLGN}...${RSTC}"
pg_dump -j 8 -Fd $POSTGRES_KEY -f $DUMP_FOLDER
echo "   ${CLGN}Dropping the database ${CBL}${DATABASE_NAME}${CLGN}...${RSTC}"
dropdb $DATABASE_NAME
echo "   ${CLGN}Creating the database ${CBL}${DATABASE_NAME}${CLGN}...${RSTC}"
createdb $DATABASE_NAME
echo "   ${CLGN}Restoring the database ${CBL}${DATABASE_NAME}${CLGN}...${RSTC}"
pg_restore -j 8 -d $DATABASE_NAME $DUMP_FOLDER
zip -r $DUMP_FOLDER $DUMP_FOLDER
echo ""
echo "${BGCGN}${CWHT}All Done!${RSTC}${BGRSTC}"
echo ""

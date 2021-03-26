#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script


RSTC=$'\e[39m'        # reset color
CWHT=$'\e[38;5;15m'   # white
CLBL=$'\e[38;5;117m'  # light blue
CLGN=$'\e[38;5;2m'    # light green
CLRD=$'\e[38;5;1m'    # light red
BGRSTC=$'\e[49m'      # bg reset color
BGCGN=$'\e[48;5;34m'  # bg green

USERNAME=$(whoami)
DIR=$(dirname "$0")
ROOT="/Users/${USERNAME}"
DATE_AND_TIME=$(date +%Y-%m-%d_%H-%M-%S)
ZIP_FILE="MAC_BKP_${DATE_AND_TIME}"
BKP_FOLDER="/Users/${USERNAME}/Desktop/${ZIP_FILE}"
BKP_CONFIG=($(<${DIR}/bkp_config.txt))
BKP_APPS=($(<${DIR}/bkp_app.txt))

bkpConfig () {
    local FILE=$1
    local DESTINATION_FOLDER=$2

    if [ ! -d "${BKP_FOLDER}/Config" ]; then
        mkdir "${BKP_FOLDER}/Config"
    fi

    if [ -d "${FILE}" ]; then
        cp -r "${FILE}" "${BKP_FOLDER}/${DESTINATION_FOLDER}"
    elif [ -f "${FILE}" ]; then
        cp "${FILE}" "${BKP_FOLDER}/${DESTINATION_FOLDER}"
    fi
}

bkpAppConfig () {
    local APP=$1
    local DESTINATION_FOLDER=$2

    if [ ! -d "${BKP_FOLDER}/${DESTINATION_FOLDER}" ]; then
        mkdir "${BKP_FOLDER}/${DESTINATION_FOLDER}"
    fi

    PLISTS=($(ls /Users/${USERNAME}/Library/Preferences/ | grep -i "${APP}"))
    for line in $PLISTS; do
        defaults export $line "${BKP_FOLDER}/${DESTINATION_FOLDER}/${line}"
        # defaults import com.manytricks.Moom ~/Desktop/com.manytricks.Moom.plist
    done
}

bkp () {
    mkdir "${BKP_FOLDER}"

    for item in $BKP_CONFIG; do
        bkpConfig "${ROOT}/${item}" "Config"
    done

    for app in $BKP_APPS; do
        bkpAppConfig "${app}" "App"
    done

    echo ""
    echo "    ${BGCGN}${CWHT}DONE!${RSTC}${BGRSTC} ${CLGN}Your backup has been saved in ${CLBL}${BKP_FOLDER}${RSTC}"
    echo ""
}

bkp
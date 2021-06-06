#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script


FGWT=$'\e[38;5;15m'    # fg white
FGLBL=$'\e[38;5;117m'  # fg light blue
FGLGN=$'\e[38;5;2m'    # fg light green
FGRST=$'\e[39m'        # fg reset color
BGGN=$'\e[48;5;34m'    # bg green
BGRST=$'\e[49m'        # bg reset color

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

    [ ! -d "${BKP_FOLDER}/Config" ] && mkdir "${BKP_FOLDER}/Config"

    if [ -d "${FILE}" ]; then
        cp -r "${FILE}" "${BKP_FOLDER}/${DESTINATION_FOLDER}"
    elif [ -f "${FILE}" ]; then
        cp "${FILE}" "${BKP_FOLDER}/${DESTINATION_FOLDER}"
    fi
}

bkpAppConfig () {
    local APP=$1
    local DESTINATION_FOLDER=$2

    [ ! -d "${BKP_FOLDER}/${DESTINATION_FOLDER}" ] && mkdir "${BKP_FOLDER}/${DESTINATION_FOLDER}"
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
    echo "    ${BGGN}${FGWT}DONE!${FGRST}${BGRST} ${FGLGN}Your backup has been saved in ${FGLBL}${BKP_FOLDER}${FGRST}"
    echo ""
}

bkp
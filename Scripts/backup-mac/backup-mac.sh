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
ROOT="/Users/${USERNAME}"
DATE_AND_TIME=$(date +%Y-%m-%d_%H-%M-%S)
BKP_FOLDER="/Users/${USERNAME}/Desktop/BKP_${DATE_AND_TIME}"
mkdir "${BKP_FOLDER}"

function bkpConfig () {
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

bkpConfig "${ROOT}/.ssh"              "Config"
bkpConfig "${ROOT}/.gitconfig"        "Config"
bkpConfig "${ROOT}/.gitignore_global" "Config"
bkpConfig "${ROOT}/.prettierrc"       "Config"
bkpConfig "${ROOT}/.vimrc"            "Config"
bkpConfig "${ROOT}/.zshrc"            "Config"

function bkpAppConfig () {
    APP=$1
    APP_EXISTS=$(ls "/Applications/" | grep -i ${APP})

    if [ "$APP_EXISTS" != "" ]; then
        if [ ! -d "${BKP_FOLDER}/App" ]; then
            mkdir "${BKP_FOLDER}/App"
        fi

        case $APP in
            moom)
                defaults export com.manytricks.Moom "${BKP_FOLDER}/App/moom.plist"
                ;;
            iterm)
                defaults export com.googlecode.iterm2.plist "${BKP_FOLDER}/App/iterm2.plist"
                ;;
            magnet)
                defaults export com.crowdcafe.windowmagnet.plist "${BKP_FOLDER}/App/magnet.plist"
                ;;
            breaktimer)
                defaults export com.tomjwatson.breaktimer.plist "${BKP_FOLDER}/App/break_timer.plist"
                ;;
            snagit)
                defaults export com.TechSmith.Snagit2021.plist "${BKP_FOLDER}/App/snagit.plist"
                defaults export com.techsmith.SnagitRecorder2021.plist "${BKP_FOLDER}/App/snagit_recorder.plist"
                defaults export com.techsmith.snagit.capturehelper2021.plist "${BKP_FOLDER}/App/snagit_capture.plist"
                ;;
            keyboard)
                defaults export com.stairways.keyboardmaestro.plist "${BKP_FOLDER}/App/keyboardmaestro.plist"
                defaults export com.stairways.keyboardmaestro.editor.plist "${BKP_FOLDER}/App/keyboard_maestro_editor.plist"
                defaults export com.stairways.keyboardmaestro.engine.plist "${BKP_FOLDER}/App/keyboard_maestro_engine.plist"
                ;;
        esac
    else
        echo "${CLRD}Unable to find application named ${CLOG}${APP}${RSTC}"
    fi
}

bkpAppConfig "moom"
bkpAppConfig "iterm"
bkpAppConfig "magnet"
bkpAppConfig "snagit"
bkpAppConfig "keyboard"
bkpAppConfig "breaktimer"

echo ""
echo "    ${BGCGN}${CWHT}DONE!${RSTC}${BGRSTC} ${CLGN}Your backup has been saved in ${CLBL}${BKP_FOLDER}${RSTC}"
echo ""

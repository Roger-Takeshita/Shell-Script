#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'        # reset color
CBK=$'\e[38;5;0m'     # black
CBL=$'\e[38;5;27m'    # blue
CGY=$'\e[38;5;240m'   # gray
CWHT=$'\e[38;5;15m'   # white

BGRSTC=$'\e[49m'      # bg reset color
BGCBL=$'\e[48;5;27m'  # bg blue
BGCGY=$'\e[48;5;240m' # bg gray

BASE_FOLDER=$(pwd)

pullInstall() {
    local CURRENT_FOLDER=$1

    if [ -d "$CURRENT_FOLDER" ] && [ -d "$CURRENT_FOLDER/.git" ]; then
        cd $CURRENT_FOLDER
        GIT_FOLDER=$(realpath --relative-to="$BASE_FOLDER" "$CURRENT_FOLDER")
        BRANCH=$(git branch --show-current)
        echo "${BGCBL}${CWHT}${GIT_FOLDER}${RSTC}${BGRSTC}${CBL}${BGCGY}${RSTC} ${CBK} ${BRANCH} ${CGY}${BGRSTC}${RSTC}"
        echo ""
        echo "${CGY}$(git pull)${RSTC}"
        echo ""

        if [ -f "$CURRENT_FOLDER/package.json" ]; then
            echo "${CGY}$(npm install)${RSTC}"
            echo ""
        fi
    elif [ -d "$CURRENT_FOLDER" ]; then
        COUNT_FILES=`ls $CURRENT_FOLDER | wc -l`

        if [ $COUNT_FILES -gt 0 ]; then
            for FOLDER in $CURRENT_FOLDER/*; do
                NEXT_FOLDER_NAME=`basename "$FOLDER"`

                if [ -d "$FOLDER" ] &&
                   [ "$NEXT_FOLDER_NAME" != ".rmv" ] &&
                   [ "$NEXT_FOLDER_NAME" != ".vscode" ] &&
                   [ "$NEXT_FOLDER_NAME" != ".git" ] &&
                   [ "$NEXT_FOLDER_NAME" != "node_modules" ] &&
                   [ "$NEXT_FOLDER_NAME" != "node_modules.nosync" ]; then
                    pullInstall $FOLDER
                fi
            done
        fi
    fi
}

pullInstall $BASE_FOLDER

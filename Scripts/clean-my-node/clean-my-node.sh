#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'       # reset color
CLGN=$'\e[38;5;2m'   # light green
CLOG=$'\e[38;5;215m' # light orange
CLRD=$'\e[38;5;1m'   # light red

RSTF=$'\e[0m'
Bold=$'\e[1m'

checkFolder() {
    for fileFolder in "$1"/*; do
        baseFolder=$(dirname $fileFolder)

        if [ -d "$baseFolder/node_modules" ]; then
            rm -rf "$baseFolder/node_modules"
            echo "${CLRD}${Bold}Deleted${RSTF} $baseFolder/${CLOG}node_modules"${RSTF}
        elif [ -d "$fileFolder/node_modules" ]; then
            rm -rf "$fileFolder/node_modules"
            echo "${CLRD}${Bold}Deleted${RSTF} $fileFolder/${CLOG}node_modules"${RSTF}
        elif [ -d "$baseFolder/node_modules.nosync" ]; then
            rm -rf "$baseFolder/node_modules.nosync"
            echo "${CLRD}${Bold}Deleted${RSTF} $baseFolder/${CLOG}node_modules.nosync"${RSTF}
        elif [ -d "$fileFolder/node_modules.nosync" ]; then
            rm -rf "$fileFolder/node_modules.nosync"
            echo "${CLRD}${Bold}Deleted${RSTF} $fileFolder/${CLOG}node_modules.nosync"${RSTF}
        fi
        if [ -d "$fileFolder" ] && [ "$(ls $fileFolder)" ]; then
            checkFolder $fileFolder
        fi
    done
}

dir="`pwd`"
checkFolder $dir
echo ${CLGN}All Good

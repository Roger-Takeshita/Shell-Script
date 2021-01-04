#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

red=$'\e[0;31m'
green=$'\e[0;32m'
orange=$'\e[38;5;202m'
end=$'\e[0m'
bold=$'\e[1m'

checkFolder() {
    for fileFolder in "$1"/*; do
        baseFolder=$(dirname $fileFolder)

        if [ -d "$baseFolder/node_modules" ]; then
            rm -rf "$baseFolder/node_modules"
            echo "${red}${bold}Deleted${end} $baseFolder/${orange}node_modules"${end}
        elif [ -d "$fileFolder/node_modules" ]; then
            rm -rf "$fileFolder/node_modules"
            echo "${red}${bold}Deleted${end} $fileFolder/${orange}node_modules"${end}
        elif [ -d "$baseFolder/node_modules.nosync" ]; then
            rm -rf "$baseFolder/node_modules.nosync"
            echo "${red}${bold}Deleted${end} $baseFolder/${orange}node_modules.nosync"${end}
        elif [ -d "$fileFolder/node_modules.nosync" ]; then
            rm -rf "$fileFolder/node_modules.nosync"
            echo "${red}${bold}Deleted${end} $fileFolder/${orange}node_modules.nosync"${end}
        fi
        if [ -d "$fileFolder" ] && [ "$(ls $fileFolder)" ]; then
            checkFolder $fileFolder
        fi
    done
}

dir="`pwd`"
checkFolder $dir
echo ${green}All Good

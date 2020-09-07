#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

red=$'\e[0;31m'
green=$'\e[0;32m'
orange=$'\e[38;5;202m'
end=$'\e[0m'

dim=$'\e[2m'
bold=$'\e[1m'

dir="`pwd`"

checkFolder() {
    for fileFolder in "$1"/*; do
        delete=0

        if [ -d $fileFolder ] && [ -d "$fileFolder/node_modules" ]; then
            rm -rf "$fileFolder/node_modules"
            echo "${red}${bold}Deleted${end} $fileFolder/${orange}node_modules"${end}
            delete=1
        fi
        if [ -d $fileFolder ] && [ -f "$fileFolder/package-lock.json" ]; then
            rm "$fileFolder/package-lock.json"
            echo "${red}${bold}Deleted${end} $fileFolder/${orange}package-lock.json"${end}
            delete=1
        fi
        if [ $delete -eq 1 ]; then
            continue
        fi
        
        if [ -d $fileFolder ]; then
            checkFolder $fileFolder
        fi
    done
}

checkFolder $dir
echo ${green}All Good
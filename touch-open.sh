#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

if [ $# -eq 0 ]; then
    echo "\e[0;31mERROR:\e[37m I need a file" >&2
    return 1
fi

red=$'\e[0;31m'
grn=$'\e[0;32m'
end=$'\e[0m'
previousDir=""
shouldOpenFile=1
usePreviousDir=0

for path in $@
do
    IFS='/' read -ra items <<< "$path"
    dir=''

    if [[ $path =~ (^-.+$) ]]; then
        # echo " ${fileName}"

        if [ "$path" = "-n" ]; then
            shouldOpenFile=0;
        fi

        continue
    fi

    if [ $path = "+" ]; then
        usePreviousDir=1
    elif [ $usePreviousDir -eq 0 ]; then
        dir=""
        previousDir=""
    fi 

    for item in ${items[@]}
    do
        if [ $item = "+" ]; then
            continue
        fi

        if [[ ${item%.*} == ${item##*.} ]]; then
            if [ $usePreviousDir -eq 1 ]; then
                dir="${previousDir}${item}/"
            else
                dir="${dir}${item}/"
            fi

            previousDir=$dir


            if [ ! -d "$dir" ]; then
                mkdir -p "$dir"
            fi
        else 
            file=$previousDir$item
            usePreviousDir=0

            if [ ! -f $file ]; then
                touch ${file}

                if [ $shouldOpenFile -eq 1 ]; then
                    code "$file"
                fi
            else
                printf "%s\n" "${previousDir}${grn}${item}${end} - ${red}Already Exists${end}"

                if [ $shouldOpenFile -eq 1 ]; then
                    code "$file"
                fi
            fi 
        fi
    done
done
#!/bin/zsh

dontOpen=0
sameDir=0;
previousDir=""

if [ $# -eq 0 ]; then
    echo "\e[0;31mERROR:\e[37m I need a file" >&2
    return 1
fi

for fileName do
    create=1

    if [[ $fileName =~ (^-.+$) ]]; then
        # echo " ${fileName}"

        if [ "$fileName" = "-n" ]; then
            dontOpen=1
        fi
        
        continue
    fi

    if [ $fileName = "+" ]; then
        if [ "${previousDir}" = "" ]; then
            sameDir=0
        else
            sameDir=1
            dir=$previousDir
        fi

        continue
    else
        if [ $sameDir -eq 1 ]; then
            dir="${previousDir}/${fileName}"
        else
            dir=$(dirname "${fileName}")
            previousDir=$dir
        fi
    fi

    if [ -f "$fileName" ]; then
        echo "\e[37m$fileName \e[0;31malready exists"

        if [ $dontOpen -eq 0 ]; then
            code "$fileName"
        fi

        create=0
        continue
    elif [ -f "${previousDir}/${fileName}" ]; then
        echo "\e[37m${previousDir}/${fileName} \e[0;31malready exists"

        if [ $dontOpen -eq 0 ]; then
            code "${previousDir}/${fileName}"
        fi

        create=0
        continue
    fi

    if [ ! -d "$dir" ]; then
        if [ $sameDir -eq 1 ]; then
            sameDir=0
            create=0
        else
            mkdir -p "$dir"
            create=1
        fi
    fi

    if [ $dontOpen -eq 0 ] && [ $create -eq 1 ]; then
        touch "$fileName" && code "$fileName"
    elif [ $dontOpen -eq 1 ] && [ $create -eq 1 ]; then
        touch "$fileName"
    elif [ $dontOpen -eq 0 ] && [ $create -eq 0 ]; then
        touch "${previousDir}/${fileName}" && code "${previousDir}/${fileName}"
    elif [ $dontOpen -eq 1 ] && [ $create -eq 0 ]; then
        touch "${previousDir}/${fileName}"
    fi
done
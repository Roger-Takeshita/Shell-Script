#!/bin/zsh

dontOpen=0

if [ $# -eq 0 ]; then
    echo "\e[0;31mERROR:\e[37m I need a file" >&2
    return 1
fi

for fileName do
    if [[ $fileName =~ ^-.+$ ]]; then
        if [ " $fileName" = " -n" ]; then
            # echo " ${fileName}"
            dontOpen=1
        fi
        continue
    fi

    create=1
    dir=$(dirname "${fileName}")

    if [ -f "$fileName" ]; then
        echo "\e[37m$fileName \e[0;31malready exists"
        create=0
    fi

    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        create=1
    fi

    if [ $dontOpen -eq 0 ] && [ $create -eq 1 ]; then
        touch "$fileName" && code "$fileName"
    elif [ $dontOpen -eq 1 ] && [ $create -eq 1 ]; then
        touch "$fileName"
    fi
done
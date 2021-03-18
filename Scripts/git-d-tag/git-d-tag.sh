#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'        # reset color
CGY=$'\e[38;5;240m'   # gray
CWHT=$'\e[38;5;15m'   # white
CLGN=$'\e[38;5;2m'    # light green
CLRD=$'\e[38;5;1m'    # light red
BGRSTC=$'\e[49m'      # bg reset color
BGCGN=$'\e[48;5;34m'  # bg green
BGCBL=$'\e[48;5;27m'  # bg blue
RSTF=$'\e[0m'         # reset format
UNDER=$'\e[4m'        # underline

function checkTagExists() {
    local TAG=$1

    if [ "$TAG" == "" ]; then
        return 1
    fi

    if git rev-parse $TAG >/dev/null 2>&1 ; then
        return 0
    fi

    echo ""
    echo "    ${CLRD}Tag ${BGCBL}${CWHT}${TAG}${BGRSTC}${CLRD}${CLRD} doesn't exist${RSTC}"
    echo ""

    return 1
}

function deleteTag() {
    local LOCAL_TAG=$1

    git tag -d $LOCAL_TAG > /dev/null
    git push --delete origin $LOCAL_TAG > /dev/null 2> /dev/null

    echo ""
    echo "    ${CLGN}Tag ${BGCBL}${CWHT}${LOCAL_TAG}${BGRSTC} ${CLGN}has been deleted.${RSTC}"
    echo ""
}

function tagLoop() {
    local TAG=$1

    checkTagExists $TAG
    TAG_EXISTS=$?

    while [ $TAG_EXISTS -eq 1 ]; do
        echo -n "Please enter ${UNDER}version${RSTF}: "
        read TAG_VERSION
        checkTagExists $TAG_VERSION
        TAG_EXISTS=$?
    done

    if [ "$TAG_VERSION" == "" ]; then
        TAG_VERSION=$TAG
    fi
}

function init() {
    tagLoop $1
    deleteTag $TAG_VERSION
}

init $@
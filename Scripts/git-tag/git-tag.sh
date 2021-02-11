#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'        # reset color
CGY=$'\e[38;5;240m'   # gray
CWHT=$'\e[38;5;15m'   # white
CLBL=$'\e[38;5;117m'  # light blue
CLGN=$'\e[38;5;2m'    # light green
CLOG=$'\e[38;5;215m'  # light orange
CLRD=$'\e[38;5;1m'    # light red
BGRSTC=$'\e[49m'      # bg reset color
BGCGN=$'\e[48;5;34m'  # bg green
BGCBL=$'\e[48;5;27m'  # bg blue
RSTF=$'\e[0m'         # reset format
UNDER=$'\e[4m'        # underline

DIR=$(pwd)
PACKAGE_JSON_FILENAME="package.json"

function notFoundFileMsg() {
    FILE=$1
    echo ""
    echo "    ${CLBL}${FILE}${CLOG} not found.${RSTC}"
    echo "    ${CLOG}Looks like you are trying to run the script outside of your project root path or ${CLBL}${FILE}${CLOG} doesn't exist.${RSTC}"
    echo "    ${CLRD}Process aborted!${RSTC}"
    echo ""
    exit
}

function checkIfFileExists() {
    if [ -f "${DIR}/${PACKAGE_JSON_FILENAME}" ]; then
        PACKAGE_JSON_VERSION=$(cat ${DIR}/${PACKAGE_JSON_FILENAME} | grep version | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | xargs)
    else
        notFoundFileMsg $PACKAGE_JSON_FILENAME
    fi
}

function checkTagExists() {
    local TAG=$(echo $1 | xargs)

    if [ "$TAG" == "" ]; then
        TAG=$PACKAGE_JSON_VERSION
    fi

    if git rev-parse $TAG >/dev/null 2>&1 ; then
        echo ""
        echo "    ${CLRD}Tag ${CLBL}${TAG}${CLRD} already exists${RSTC}"
        echo ""
        # TAGS=$(git tag | sed -e 's/\n/ /g' | tr '\r\n' ' ')
        # echo "    ${CGY}Existing tags: ${TAGS}${RSTC}"

        return 1
    fi

    return 0
}

function printSummary() {
    local OLD_TAG=$1
    local NEW_TAG=$2

    if [ "$OLD_TAG" != "$NEW_TAG" ]; then
        echo ""
        echo "    ${CLBL}PREVIOUS:${RSTC}"
        echo "    ${CLBL}    Tag version:           ${OLD_TAG}${RSTC}"
        echo "    ${CLBL}    ${PACKAGE_JSON_FILENAME} version:  ${OLD_TAG}${RSTC}"
    fi

    echo ""
    echo "    ${CLGN}NEW:${RSTC}"
    echo "    ${CLGN}    Tag version:           ${NEW_TAG}${RSTC}"
    echo "    ${CLGN}    ${PACKAGE_JSON_FILENAME} version:  ${NEW_TAG}${RSTC}"
    echo ""
}

function pushNewTag() {
    local OLD_TAG=$1
    local NEW_TAG=$2

    echo -n "Are you sure you want to bump the ${UNDER}version${RSTF}? ${CGY}(y/n)${RSTC} "
    read ANSWER
    local CONFIRM=$(echo $ANSWER | tr [:upper:] [:lower:])

    if [ "${CONFIRM}" == "" ] || [ "${CONFIRM}" == "y" ] || [ "${CONFIRM}" == "yes" ]; then
        $(cat ${DIR}/${PACKAGE_JSON_FILENAME} | sed -e s/\"${OLD_TAG}\"/\"${NEW_TAG}\"/g > ${DIR}/NEW_${PACKAGE_JSON_FILENAME})
        $(rm ${DIR}/${PACKAGE_JSON_FILENAME})
        $(mv ${DIR}/NEW_${PACKAGE_JSON_FILENAME} ${DIR}/${PACKAGE_JSON_FILENAME})
        echo "${CGY}$(npm install)"
        echo "${CGY}$(git add . ; git commit -m "bump tag to ${NEW_TAG}" ; git push)"
        echo "${CGY}$(git tag ${NEW_TAG} ; git push origin --tags)${RSTC}"
        echo "${BGCGN}${CWHT}Your tag has been bumped to${BGRSTC} ${BGCBL}${NEW_TAG}${RSTC}${BGRSTC}"
        echo ""
    else
        echo "    ${CLRD}Process aborted!"
        echo ""
    fi

}

function tagLoop() {
    local TAG_EXISTS=$1

    while [ $TAG_EXISTS -eq 1 ]; do
        echo -n "Please enter ${CLBL}${PACKAGE_JSON_FILENAME}${RSTC} ${UNDER}version${RSTF}: ${CGY}(${PACKAGE_JSON_VERSION})${RSTC} "
        read NEW_TAG_VERSION_AGAIN
        checkTagExists $NEW_TAG_VERSION_AGAIN
        TAG_EXISTS=$?
    done

    if [ "$NEW_TAG_VERSION_AGAIN" != "" ]; then
        NEW_TAG_VERSION=$NEW_TAG_VERSION_AGAIN
    fi
}

function init() {
    echo -n "Please enter ${CLBL}${PACKAGE_JSON_FILENAME}${RSTC} ${UNDER}version${RSTF}: ${CGY}(${PACKAGE_JSON_VERSION})${RSTC} "
    read NEW_TAG_VERSION

    if [ "$NEW_TAG_VERSION" == "" ]; then
        NEW_TAG_VERSION=$PACKAGE_JSON_VERSION
    fi

    checkTagExists $NEW_TAG_VERSION
    TAG_EXISTS=$?

    tagLoop $TAG_EXISTS
    printSummary $PACKAGE_JSON_VERSION $NEW_TAG_VERSION
    pushNewTag $PACKAGE_JSON_VERSION $NEW_TAG_VERSION
}

checkIfFileExists
init
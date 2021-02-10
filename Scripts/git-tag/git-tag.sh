#!/bin/bash

RSTC=$'\e[39m'       # reset color
CGY=$'\e[38;5;240m'  # gray
CLBL=$'\e[38;5;117m' # light blue
CLGN=$'\e[38;5;2m'   # light green
CLOG=$'\e[38;5;215m' # light orange
CLRD=$'\e[38;5;1m'   # light red
CLYL=$'\e[38;5;228m' # light yellow
DIR=$(pwd)

PACKAGE_VERSION=$(grep -m1 version ${DIR}/package.json | awk -F: '{ print $2 }' | sed 's/[", ]//g')

function splitVersion() {
    if [[ $1 =~ ([0-9]+).([0-9]+).([0-9]+) ]]; then
      MAJOR=${BASH_REMATCH[1]}
      MINOR=${BASH_REMATCH[2]}
      TINY=${BASH_REMATCH[3]}
    fi
}

function checkTagExists() {
    local TAG=$1

    if git rev-parse $TAG >/dev/null 2>&1 ; then
        echo "    ${CLRD}Tag ${CLGN}${TAG}${CLRD} already exists.${RSTC}"
        TAGS=$(git tag | sed -e 's/\n/ /g' | tr '\r\n' ' ')
        echo "    ${CGY}Existing tags: ${TAGS}${RSTC}"
        echo ""
        return 1
    fi

    return 0
}

function pushNewTag() {
    local TAG=$1
    splitVersion $TAG

    echo ""
    echo "    ${CGY}package.json Version: ${TAG}${RSTC}"
    echo "    ${CGY}Tag Version:          ${TAG}${RSTC}"
    echo ""

    echo -n "Are you sure you want to bump the version? ${CGY}(y/n)${RSTC} "
    read ANSWER2
    local CONFIRM=$(echo $ANSWER2 | tr [:upper:] [:lower:])

    if [ "${CONFIRM}" == "" ] || [ "${CONFIRM}" == "y" ] || [ "${CONFIRM}" == "yes" ]; then
        $(cat ${DIR}/package.json | sed -e s/\"${PACKAGE_VERSION}\"/\"${TAG}\"/g > ${DIR}/package1.json)
        $(rm ${DIR}/package.json)
        $(mv ${DIR}/package1.json ${DIR}/package.json)
        git add . ; git commit -m "bump tag ${TAG}" ; git push
        git tag ${TAG} ; git push origin --tags
    else
        echo "    ${CLRD}Process aborted!"
        echo ""
    fi

}

function init() {
    splitVersion $PACKAGE_VERSION

    echo ""
    echo -n "Current package.json version: ${CGY}(${PACKAGE_VERSION})${RSTC} "
    read VERSION

    if [ "$VERSION" == "" ]; then
        checkTagExists $PACKAGE_VERSION
        local TAG_1=$?

        if [ $TAG_1 ]; then
            echo -n "Would you like to bump the version? ${CGY}(y/n)${RSTC} "
            read ANSWER1
            local BUMP=$(echo $ANSWER1 | tr [:upper:] [:lower:])

            if [ "${BUMP}" == "" ] || [ "${BUMP}" == "y" ] || [ "${BUMP}" == "yes" ]; then
                echo -n "Please enter the new version: ${CGY}(eg. 1.0.1)${RSTC} "
                read NEW_VERSION

                checkTagExists $NEW_VERSION
                local TAG_2=$?

                if [ $TAG_2 -eq 0 ]; then
                    pushNewTag $NEW_VERSION
                fi
            else
                echo "    ${CLRD}Process aborted!"
                echo ""
                exit
            fi
        else
            echo All good
        fi
    else
        checkTagExists $VERSION
        local TAG_3=$?

        if [ $TAG_3 -eq 0 ]; then
            pushNewTag $VERSION
        fi
    fi
}

init
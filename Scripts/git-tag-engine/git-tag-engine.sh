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

DIR=$(pwd)
PACKAGE_JSON_FILENAME="package.json"
TEACHERSEAT_FILENAME="teacherseat.json"

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
        PACKAGE_VERSION=$(cat ${DIR}/${PACKAGE_JSON_FILENAME} | grep version | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | xargs)
    else
        notFoundFileMsg $PACKAGE_JSON_FILENAME
    fi

    if [ -f "${DIR}/${TEACHERSEAT_FILENAME}" ]; then
        RELEASE=$(cat ${DIR}/${TEACHERSEAT_FILENAME} | grep type | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | xargs )
        RELEASE_VERSION=$(grep '"version": [0-9]*$' ${DIR}/${TEACHERSEAT_FILENAME} | sed -e "s/\(\"version\":\) \([0-9]*$\)/\2/" | xargs)
    else
        notFoundFileMsg $TEACHERSEAT_FILENAME
    fi
}

function splitVersion() {
    if [[ $1 =~ ([0-9]+).([0-9]+).([0-9]+) ]]; then
      MAJOR=${BASH_REMATCH[1]}
      MINOR=${BASH_REMATCH[2]}
      PATCH=${BASH_REMATCH[3]}
    fi
}

function checkTagExists() {
    local TAG=$(echo $1 | xargs)

    if [ "$TAG" != "" ] && git rev-parse $TAG >/dev/null 2>&1 ; then
        echo ""
        echo "    ${CLRD}Tag ${CLBL}${TAG}${CLRD} already exists${RSTC}"
        echo ""
        # TAGS=$(git tag | sed -e 's/\n/ /g' | tr '\r\n' ' ')
        # echo "    ${CGY}Existing tags: ${TAGS}${RSTC}"
        PACKAGE_VERSION=$TAG

        return 1
    fi

    return 0
}

function updateRelease() {
    echo -n "Please enter ${TEACHERSEAT_FILENAME} release type: ${CGY}(${RELEASE})${RSTC} "
    read NEW_RELEASE

    if [ "$NEW_RELEASE" == "" ]; then
        NEW_RELEASE=$RELEASE
    fi

    echo -n "Please enter ${TEACHERSEAT_FILENAME} release version: ${CGY}(${RELEASE_VERSION})${RSTC} "
    read NEW_RELEASE_VERSION

    if [ "$NEW_RELEASE_VERSION" == "" ]; then
        NEW_RELEASE_VERSION=$RELEASE_VERSION
    fi
}

function pushNewTag() {
    local TAG=$1
    splitVersion $TAG

    if [ "$TAG" != "" ]; then
        echo ""
        echo "    ${CLBL}PREVIOUS:${RSTC}"
        echo "    ${CLBL}   tag:                              ${PACKAGE_VERSION}${RSTC}"
        echo "    ${CLBL}   ${PACKAGE_JSON_FILENAME} version:             ${PACKAGE_VERSION}${RSTC}"
        echo "    ${CLBL}   ${TEACHERSEAT_FILENAME} release type:    ${RELEASE}${RSTC}"
        echo "    ${CLBL}   ${TEACHERSEAT_FILENAME} release version: ${RELEASE_VERSION}${RSTC}"
        echo ""
        echo "    ${CLGN}NEW:${RSTC}"
        echo "    ${CLGN}   tag:                              ${TAG}${RSTC}"
        echo "    ${CLGN}   ${PACKAGE_JSON_FILENAME}:                     ${TAG}${RSTC}"
        echo "    ${CLGN}   ${TEACHERSEAT_FILENAME} release type:    ${NEW_RELEASE}${RSTC}"
        echo "    ${CLGN}   ${TEACHERSEAT_FILENAME} release version: ${NEW_RELEASE_VERSION}${RSTC}"
        echo ""
    else
        TAG=$PACKAGE_VERSION
        echo ""
        echo "    ${CLGN}New:${RSTC}"
        echo "    ${CLGN}   tag:                              ${TAG}${RSTC}"
        echo "    ${CLGN}   ${PACKAGE_JSON_FILENAME} version:             ${TAG}${RSTC}"
        echo "    ${CLGN}   ${TEACHERSEAT_FILENAME} release type:    ${NEW_RELEASE}${RSTC}"
        echo "    ${CLGN}   ${TEACHERSEAT_FILENAME} release version: ${NEW_RELEASE_VERSION}${RSTC}"
        echo ""
    fi

    echo -n "Are you sure you want to bump the version? ${CGY}(y/n)${RSTC} "
    read ANSWER2
    local CONFIRM=$(echo $ANSWER2 | tr [:upper:] [:lower:])

    if [ "${CONFIRM}" == "" ] || [ "${CONFIRM}" == "y" ] || [ "${CONFIRM}" == "yes" ]; then
        $(cat ${DIR}/${PACKAGE_JSON_FILENAME} | sed -e s/\"${PACKAGE_VERSION}\"/\"${TAG}\"/g > ${DIR}/NEW_${PACKAGE_JSON_FILENAME})
        $(rm ${DIR}/${PACKAGE_JSON_FILENAME})
        $(mv ${DIR}/NEW_${PACKAGE_JSON_FILENAME} ${DIR}/${PACKAGE_JSON_FILENAME})
        cat "${DIR}/${TEACHERSEAT_FILENAME}" | sed -e "s/\(\"major\":\) \([0-9]*\)/\1 ${MAJOR}/" \
                                             --| sed -e "s/\(\"minor\":\) \([0-9]*\)/\1 ${MINOR}/" \
                                             --| sed -e "s/\(\"patch\":\) \([0-9]*\)/\1 ${PATCH}/" \
                                             --| sed -e "s/\(\"type\":\) \(\"[a-zA-Z0-9-]*\"\)/\1 \"${NEW_RELEASE}\"/" /
                                             --| sed -e "s/\(\"version\":\) \([0-9]*$\)/\1 ${NEW_RELEASE_VERSION}/" /
                                             --> "${DIR}/NEW_${TEACHERSEAT_FILENAME}"
        $(rm ${DIR}/${TEACHERSEAT_FILENAME})
        $(mv ${DIR}/NEW_${TEACHERSEAT_FILENAME} ${DIR}/${TEACHERSEAT_FILENAME})
        # echo "${CGY}$(npm install)"
        # echo "${CGY}$(git add . ; git commit -m "bump tag to ${TAG}" ; git push)"
        # echo "${CGY}$(git tag ${TAG} ; git push origin --tags)${RSTC}"
        echo "${BGCGN}${CWHT}Your tag has been bumped to${BGRSTC} ${BGCBL}${TAG}${RSTC}${BGRSTC}"
        echo ""
    else
        echo "    ${CLRD}Process aborted!"
        echo ""
    fi

}

function init() {
    splitVersion $PACKAGE_VERSION

    echo -n "Please enter ${PACKAGE_JSON_FILENAME} version: ${CGY}(${PACKAGE_VERSION})${RSTC} "
    read VERSION

    if [ "$VERSION" == "" ]; then
        checkTagExists $PACKAGE_VERSION
        local TAG_1=$?

        if [ $TAG_1 -eq 1 ]; then
            echo -n "Would you like to bump the version? ${CGY}(y/n)${RSTC} "
            read ANSWER1
            local BUMP=$(echo $ANSWER1 | tr [:upper:] [:lower:])

            if [ "${BUMP}" == "" ] || [ "${BUMP}" == "y" ] || [ "${BUMP}" == "yes" ]; then
                while [ "$NEW_VERSION" == "" ] || [ $TAG_2 -eq 1 ]; do
                    echo -n "Please enter version different from ${CLBL}${PACKAGE_VERSION}${RSTC}: "
                    read NEW_VERSION
                    checkTagExists $NEW_VERSION
                    local TAG_2=$?
                done

                if [ $TAG_2 -eq 0 ]; then
                    updateRelease
                    pushNewTag $NEW_VERSION
                fi
            else
                echo "    ${CLRD}Process aborted!"
                echo ""
                exit
            fi
        else
            checkTagExists $VERSION
            local TAG_3=$?

            if [ $TAG_3 -eq 0 ]; then
                updateRelease
                pushNewTag $VERSION
            fi
        fi
    else
        checkTagExists $VERSION
        local TAG_4=$?

        if [ $TAG_4 -eq 0 ]; then
            updateRelease
            pushNewTag $VERSION
        fi
    fi
}

checkIfFileExists
init
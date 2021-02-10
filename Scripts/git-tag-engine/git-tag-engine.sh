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

if [ -f "${DIR}/${PACKAGE_JSON_FILENAME}" ]; then
    PACKAGE_VERSION=$(cat ${DIR}/${PACKAGE_JSON_FILENAME} | grep version | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | xargs)
else
    echo ""
    echo "    ${CLBL}${PACKAGE_JSON_FILENAME}${CLOG} not found.${RSTC}"
    echo "    ${CLOG}Looks like you are trying to run the script outside of your project root path.${RSTC}"
    echo "    ${CLRD}Process aborted!"
    echo ""
    exit
fi

# _Maybe we are going to use later
function splitVersion() {
    if [[ $1 =~ ([0-9]+).([0-9]+).([0-9]+) ]]; then
      MAJOR=${BASH_REMATCH[1]}
      MINOR=${BASH_REMATCH[2]}
      PATCH=${BASH_REMATCH[3]}
    fi
}

function trim() {
    local VAR="$*"
    VAR="${VAR#"${VAR%%[![:space:]]*}"}"
    VAR="${VAR%"${VAR##*[![:space:]]}"}"
    printf '%s' "$VAR"
}

function checkTagExists() {
    local TAG=$(trim $1)

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

function pushNewTag() {
    local TAG=$1
    splitVersion $TAG

    if [ "$TAG" != "" ]; then
        echo ""
        echo "    ${CLBL}Previous tag:          ${PACKAGE_VERSION}${RSTC}"
        echo "    ${CLBL}Previous ${PACKAGE_JSON_FILENAME}: ${PACKAGE_VERSION}${RSTC}"
        echo ""
        echo "    ${CLGN}New tag:               ${TAG}${RSTC}"
        echo "    ${CLGN}New ${PACKAGE_JSON_FILENAME}:      ${TAG}${RSTC}"
        echo ""
    else
        TAG=$PACKAGE_VERSION
        echo ""
        echo "    ${CLGN}New tag:               ${TAG}${RSTC}"
        echo "    ${CLGN}New ${PACKAGE_JSON_FILENAME}:      ${TAG}${RSTC}"
        echo ""
    fi

    echo -n "Are you sure you want to bump the version? ${CGY}(y/n)${RSTC} "
    read ANSWER2
    local CONFIRM=$(echo $ANSWER2 | tr [:upper:] [:lower:])

    if [ "${CONFIRM}" == "" ] || [ "${CONFIRM}" == "y" ] || [ "${CONFIRM}" == "yes" ]; then
        $(cat ${DIR}/${PACKAGE_JSON_FILENAME} | sed -e s/\"${PACKAGE_VERSION}\"/\"${TAG}\"/g > ${DIR}/NEW_${PACKAGE_JSON_FILENAME})
        $(rm ${DIR}/${PACKAGE_JSON_FILENAME})
        $(mv ${DIR}/NEW_${PACKAGE_JSON_FILENAME} ${DIR}/${PACKAGE_JSON_FILENAME})
        # cat teacherseat.json | sed 's/\(\"major\"[:]\) \([0-9]*\)/\1 NEW_MAJOR/' | sed 's/\(\"minor\"[:]\) \([0-9]*\)/\1 NEW_MINOR/' | sed 's/\(\"patch\"[:]\) \([0-9]*\)/\1 NEW_PATCH/' |  sed 's/\(\"type\"[:]\) \(\"[a-zA-Z0-9-]*\"\)/\1 \"NEW_TYPE\"/' | sed 's/\(\"version\"[:]\) \([0-9]*$\)/\1 NEW_TYPE_VERSION/'
        # $(cat teacherseat.json | sed 's/\(\"major\"[:]\) \([0-9]*\)/\1 NEW_MAJOR/' | sed 's/\(\"minor\"[:]\) \([0-9]*\)/\1 NEW_MINOR/' | sed 's/\(\"patch\"[:]\) \([0-9]*\)/\1 NEW_PATCH/' |  sed 's/\(\"type\"[:]\) \(\"[a-zA-Z0-9-]*\"\)/\1 \"NEW_TYPE\"/' | sed 's/\(\"version\"[:]\) \([0-9]*$\)/\1 NEW_TYPE_VERSION/')
        echo $(cat teacherseat.json | sed s/\(\"major\"[:]\) \([0-9]*\)/\1 ${MAJOR}/)
        # $(rm ${DIR}/${TEACHERSEAT_FILENAME})
        # $(mv ${DIR}/NEW_${TEACHERSEAT_FILENAME} ${DIR}/${TEACHERSEAT_FILENAME})
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

    echo -n "Current ${PACKAGE_JSON_FILENAME} version: ${CGY}(${PACKAGE_VERSION})${RSTC} "
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
                    echo -n "Please enter the new version different from ${CLBL}${PACKAGE_VERSION}${RSTC}: "
                    read NEW_VERSION
                    checkTagExists $NEW_VERSION
                    local TAG_2=$?
                done

                if [ $TAG_2 -eq 0 ]; then
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
                pushNewTag $VERSION
            fi
        fi
    else
        checkTagExists $VERSION
        local TAG_4=$?

        if [ $TAG_4 -eq 0 ]; then
            pushNewTag $VERSION
        fi
    fi
}

init
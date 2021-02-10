#!/bin/bash

RSTC=$'\e[39m'       # reset color
CGY=$'\e[38;5;240m'  # gray
CLBL=$'\e[38;5;117m' # light blue
CLGN=$'\e[38;5;2m'   # light green
CLOG=$'\e[38;5;215m' # light orange
CLRD=$'\e[38;5;1m'   # light red
CLYL=$'\e[38;5;228m' # light yellow
DIR=`pwd`

PACKAGE_VERSION=$(grep -m1 version ${DIR}/package.json | awk -F: '{ print $2 }' | sed 's/[", ]//g')


function splitVersion() {
    if [[ $1 =~ ([0-9]+).([0-9]+).([0-9]+) ]]; then
      MAJOR=${BASH_REMATCH[1]}
      MINOR=${BASH_REMATCH[2]}
      TINY=${BASH_REMATCH[3]}
    fi
}


function checkTagExists() {
    PKG_VERSION=$1

    if git rev-parse $PKG_VERSION >/dev/null 2>&1 ; then
        echo -n "    ${CLRD}Tag ${CLGN}${PKG_VERSION}${CLRD} already exists.${RSTC}"
        echo ""
        return 1
    fi

    return 0
}

init() {
    splitVersion $PACKAGE_VERSION

    echo ""
    echo -n "Current package.json version: ${CGY}(default ${PACKAGE_VERSION})${RSTC} "
    read VERSION

    if [ "$VERSION" == "" ]; then
        checkTagExists $PACKAGE_VERSION
        local TAG_1=$?

        if [ TAG_1 ]; then
            echo -n "Would you like to bump the version? ${CGY}(y/n) (default y)${RSTC} "
            read BUMP

            if [ "$BUMP" == "" ] || [ "$BUMP" == "y" ]; then
                echo -n "Please enter the new version: ${CGY}(eg. 1.0.1)${RSTC} "
                read NEW_VERSION

                checkTagExists $NEW_VERSION
                local TAG_2=$?

                if [ $TAG_2 -eq 0 ]; then
                    splitVersion $NEW_VERSION

                    echo $(cat ${DIR}/package.json | sed -e s/\"${PACKAGE_VERSION}\"/\"${NEW_VERSION}\"/g > ${DIR}/package1.json)
                    $(rm ${DIR}/package.json)
                    $(mv ${DIR}/package1.json ${DIR}/package.json)
                    git add . ; git commit -m "bump tag ${NEW_VERSION}" ; git push
                    git tag ${NEW_VERSION} ; git push origin --tags
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
        # check if version is greater or equal to current version
        echo "    Tag version: $PACKAGE_VERSION"
    fi
}

init
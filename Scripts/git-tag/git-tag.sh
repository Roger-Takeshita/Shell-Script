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

if [[ $PACKAGE_VERSION =~ ([0-9]+).([0-9]+).([0-9]+) ]]; then
  MAJOR=${BASH_REMATCH[1]}
  MINOR=${BASH_REMATCH[2]}
  TINY=${BASH_REMATCH[3]}
fi

echo -n "Current package.json version: ${CGY}(default ${PACKAGE_VERSION})${RSTC} "
read VERSION

if [ "$VERSION" == "" ]; then
    echo "    Tag version: ${CLGN}${PACKAGE_VERSION}${RSTC}"
    TAG_EXISTS=`git rev-list ${PACKAGE_VERSION} > /dev/null`

    if [ TAG_EXISTS ]; then
        echo -n "    ${CLRD}Tag ${CLGN}${PACKAGE_VERSION}${CLRD} already exists, whould you like to bump the version? ${CGY}(y/n) (default y)${RSTC} "
        read BUMP

        if [ "$BUMP" == "" ] || [ "$BUMP" == "y" ]; then
            echo -n "Please enter the new version: ${CGY}(eg. 1.12.0)${RSTC} "
            read NEW_VERSION
        fi
    else
        echo All good
    fi
else
    # check if version is greater or equal to current version
    echo "    Tag version: $PACKAGE_VERSION"
fi
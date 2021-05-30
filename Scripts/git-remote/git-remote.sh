#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'        # reset color
CLBL=$'\e[38;5;117m'  # light blue
OPEN_FILE=1
MAIN=0

[[ "$@" =~ (.*[ ]?-n[ $]?) ]] && OPEN_FILE=0
[[ "$@" =~ (.*[ ]?-m[ $]?) ]] && MAIN=1

copyURL() {
    local URL=$1
    echo ""
    echo "   ${CLBL}${URL}${RSTC}"
    echo ""
    echo "${URL}" | tr -d '\n'| pbcopy
}

gitRemote() {
    local CMD=$@
    BRANCH_NAME=$(git branch --show-current)
    REMOTE_URL=$(git remote -v | grep fetch | sed -e 's/origin//g' -e 's/[()]//g' -e 's/fetch//g' -e 's/\.git//g' -e 's/git@github.com://g' -e 's/https:\/\/github.com\///' | xargs )

    # if $(git ls-remote --heads git@github.com:${REMOTE_URL}.git ${BRANCH_NAME}); then
    [ $MAIN -eq 0 ] && REMOTE_URL="https://github.com/${REMOTE_URL}/tree/${BRANCH_NAME}"
    [ $MAIN -eq 1 ] && REMOTE_URL="https://github.com/${REMOTE_URL}"

    if [ $OPEN_FILE -eq 1 ]; then
        open ${REMOTE_URL}
    else
        copyURL $REMOTE_URL
    fi
}

gitRemote $@

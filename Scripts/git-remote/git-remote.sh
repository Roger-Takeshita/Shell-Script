#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'        # reset color
CLBL=$'\e[38;5;117m'  # light blue
OPEN_FILE=1

if [[ "$@" =~ .*"-n".* ]]; then
    OPEN_FILE=0
fi

REMOTE_URL=$(git remote -v | grep fetch | sed -e 's/origin//g' -e 's/[()]//g' -e 's/fetch//g' -e 's/\.git//g' -e 's/git@github.com://g' | xargs )

if [[ "$REMOTE_URL" != "https"* ]]; then
  REMOTE_URL="https://github.com/${REMOTE_URL}"
fi

if [ $OPEN_FILE -eq 1 ]; then
    open $REMOTE_URL
else
  echo ""
  echo "   ${CLBL}${REMOTE_URL}${RSTC}"
  echo ""
  echo "${REMOTE_URL}" | tr -d '\n'| pbcopy
fi

#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'        # reset color
CLBL=$'\e[38;5;117m'  # light blue

REMOTE_URL=$(git remote -v | grep fetch | sed -e 's/origin//g' | sed -e 's/[()]//g' | sed -e 's/fetch//g' | sed -e 's/\.git//g'  | xargs)

echo ""
echo "   ${CLBL}${REMOTE_URL}${RSTC}"
echo ""

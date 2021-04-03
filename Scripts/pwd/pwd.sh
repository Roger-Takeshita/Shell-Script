#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'        # reset color
CLBL=$'\e[38;5;117m'  # light blue

PWD=$(pwd)

# echo ""
# echo "   ${CLBL}${PWD}${RSTC}"
# echo ""

echo "${PWD}" | tr -d '\n'| pbcopy

#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'        # reset color
CLBL=$'\e[38;5;117m'  # light blue

BRANCH=$(git branch --show-current)

echo "${BRANCH}" | tr -d '\n'| pbcopy

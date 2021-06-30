#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

BRANCH_NAME=$(git branch --show-current)
echo "git checkout -b ${BRANCH_NAME}" | tr -d '\n'| pbcopy
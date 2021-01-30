#!/bin/bash

YEAR=$(date +"%Y")
MONTH=$(date +"%b")
DAY_NUM=$(date +"%u")
DAY_STR=$(date +"%a")
TIME=$(date +"%T")

CLBL=$'\e[38;5;117m' # light blue
CLGN=$'\e[38;5;2m'   # light green

command="git commit --amend --no-edit --date=\"${DAY_STR} ${MONTH} ${DAY_NUM} ${TIME} ${YEAR} -0500\""

echo ""
echo "${CLGN}Copied to clipboard: ${CLBL}${command}"
echo ""
echo "${command}" | tr -d '\n'| pbcopy

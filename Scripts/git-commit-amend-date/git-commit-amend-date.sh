#!/bin/bash

CLBL=$'\e[38;5;117m' # light blue
CLGN=$'\e[38;5;2m'   # light green

PAST_DAY=$@

if [ "$PAST_DAY" != "" ]; then
    CURRENT_YEAR=$(DATE +"%Y")
    CURRENT_MONTH=$(date +"%m")
    DATE_EPOCH=$(date -jf "%Y-%m-%d %H:%M:%S" "${CURRENT_YEAR}-${CURRENT_MONTH}-${PAST_DAY} 19:45:00" +%s)
    DATE="date -r ${DATE_EPOCH}"
else
    DATE="date"
fi

YEAR=$(${DATE} +"%Y")
MONTH=$(${DATE} +"%b")
DAY_NUM=$(${DATE} +"%-d")
DAY_STR=$(${DATE} +"%a")
TIME=$(date +"%T")

command="git commit --amend --no-edit --date=\"${DAY_STR} ${MONTH} ${DAY_NUM} ${TIME} ${YEAR} -0500\""

echo ""
echo "${CLGN}Copied to clipboard: ${CLBL}${command}"
echo ""
echo "${command}" | tr -d '\n'| pbcopy

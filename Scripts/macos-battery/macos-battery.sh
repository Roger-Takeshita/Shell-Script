#!/bin/sh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'        # reset color
CLBL=$'\e[38;5;117m'  # light blue

BATTERY_PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1 | xargs)

echo "${BATTERY_PERCENTAGE}%"

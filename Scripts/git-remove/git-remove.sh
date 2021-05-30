#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

FGRST=$'\e[39m'       # reset color
FGLBL=$'\e[38;5;117m' # light blue
FGLOG=$'\e[38;5;215m' # light orange
FGLRD=$'\e[38;5;1m'   # light red
BGRST=$'\e[49m'       # bg reset color
BGRD=$'\e[48;5;196m'  # bg red

gitRemove() {
  local FOUND_LINE=0

  eval "$({ CMD_ERROR=$({ CMD_OUTPUT=$(git status); CMD_VALUE=$?; } 2>&1; declare -p CMD_OUTPUT CMD_VALUE >&2); declare -p CMD_ERROR; } 2>&1)"
  if [ "$CMD_OUTPUT" != "" ]; then
    echo ""
    while IFS= read -r LINE; do
      [ "$LINE" == "Untracked files:" ] && FOUND_LINE=1 && continue
      [[ "$LINE" == *"git add <file>"* ]] && continue
      [ $FOUND_LINE -eq 1 ] && [ -z $LINE ] && FOUND_LINE=0

      if [ $FOUND_LINE -eq 1 ]; then
        FILE=$(echo $LINE | xargs)

        echo "  ${FGLOG}Deleted:${FGRST} ${FILE}"
        if [ -d $FILE ]; then
          FILE=$(echo $FILE | sed -E 's/\/$//g' | xargs)
          NEW_FILE="${FILE} $(date +%H-%M-%S)"
        elif [ -f $FILE ]; then
          EXT="${FILE##*.}"
          FILENAME="${FILE%.*}"
          NEW_FILE="${FILENAME} $(date +%H-%M-%S).${EXT}"
        fi

        mv $FILE ~/.Trash/"${NEW_FILE}" 2>/dev/null
      fi
    done <<< "$CMD_OUTPUT"
    echo ""
  else
    echo ""
    echo "  ${FGLRD}ERROR:${FGRST} Folder is not a git repository. Please consider using normal ${FGLBL}rm command${FGRST}"
    echo ""
  fi
}

gitRemove
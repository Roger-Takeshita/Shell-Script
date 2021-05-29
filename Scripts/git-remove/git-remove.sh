#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

FGRST=$'\e[39m'       # reset color
FGLOG=$'\e[38;5;215m' # light orange
FGLRD=$'\e[38;5;1m'   # light red

gitRemove() {
  local FOUND_LINE=0

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
  done <<< "$(git status)"

}

gitRemove
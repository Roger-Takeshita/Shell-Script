#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

FGRST=$'\e[39m'       # reset color
FGGY=$'\e[38;5;240m'  # gray
FGLBL=$'\e[38;5;117m' # light blue
FGLOG=$'\e[38;5;215m' # light orange
FGLRD=$'\e[38;5;1m'   # light red
BGRST=$'\e[49m'       # bg reset color
BGRD=$'\e[48;5;196m'  # bg red
RSTF=$'\e[0m'
Dim=$'\e[2m'

FILES=()

errorMsg() {
    local MSG=$1
    local CODE=$2

    echo "${FGLRD}${MSG}${FGRST}"
    echo ""
    exit $CODE
}

gitRemove() {
  local FOUND_LINE=0

  eval "$({ CMD_ERROR=$({ CMD_OUTPUT=$(git status); CMD_VALUE=$?; } 2>&1; declare -p CMD_OUTPUT CMD_VALUE >&2); declare -p CMD_ERROR; } 2>&1)"
  if [ "$CMD_OUTPUT" != "" ]; then
    while IFS= read -r LINE; do
      [ "$LINE" == "Untracked files:" ] && FOUND_LINE=1 && continue
      [[ "$LINE" == *"git add <file>"* ]] && continue
      [ $FOUND_LINE -eq 1 ] && [ -z $LINE ] && FOUND_LINE=0

      if [ $FOUND_LINE -eq 1 ]; then
        FILE=$(echo $LINE | xargs)
        FILES+=("$FILE")
      fi
    done <<< "$CMD_OUTPUT"

    [ ${#FILES[@]} -eq 0 ] && exit 1

    echo ""
    printf "    ${FGLOG}%s${FGRST}\n" "${FILES[@]}"
    echo ""
    echo -n "Are you sure you want to delete the file(s)? ${Dim}${FGGY}(Y/n)${FGRST}${RSTF} "
    read ANSWER

    if [ -z $ANSWER ] || [ "$ANSWER" = "y" ] || [ "$ANSWER" = "Y" ]; then
        echo ""
        for ITEM in ${FILES[*]}; do
            echo "  ${FGLRD}Deleted:${FGRST} ${ITEM}"
            if [ -d $ITEM ]; then
                ITEM=$(echo $ITEM | sed -E 's/\/$//g' | xargs)
                NEW_FILE="${ITEM##*/} $(date +%H-%M-%S)"
            elif [ -f $ITEM ]; then
                EXT="${ITEM##*.}"
                FILE_NAME=${ITEM%.*}
                FILENAME="${FILE_NAME##*/}"
                [ "$EXT" == "$FILE_NAME" ] && EXT=''

                if [ "$EXT" != "" ]; then
                  NEW_FILE="${FILENAME} $(date +%H-%M-%S).${EXT}"
                else
                  NEW_FILE="${FILENAME} $(date +%H-%M-%S)"
                fi
            fi

            [[ "$ITEM" =~ ^-[^\s]* ]] && ITEM="./${ITEM}"
            mv $ITEM ~/.Trash/"${NEW_FILE}" 2>/dev/null
        done
        echo ""
    else
        errorMsg "Operation canceled!" 125
    fi
  else
    echo ""
    errorMsg "${FGLRD}ERROR:${FGRST} Folder is not a git repository. Please consider using normal ${FGLBL}rm command${FGRST}" 1
  fi
}

gitRemove
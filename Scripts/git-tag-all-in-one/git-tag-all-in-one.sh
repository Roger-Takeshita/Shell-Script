#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'        # reset color
CGY=$'\e[38;5;240m'   # gray
CWHT=$'\e[38;5;15m'   # white
CLBL=$'\e[38;5;117m'  # light blue
CLGN=$'\e[38;5;2m'    # light green
CLOG=$'\e[38;5;215m'  # light orange
CLRD=$'\e[38;5;1m'    # light red
BGRSTC=$'\e[49m'      # bg reset color
BGCGN=$'\e[48;5;34m'  # bg green
BGCBL=$'\e[48;5;27m'  # bg blue
BGCRD=$'\e[48;5;196m' # bg red
RSTF=$'\e[0m'         # reset format
UNDER=$'\e[4m'        # underline

CURRENT_FOLDER=$(pwd)
PACKAGE_JSON_FILENAME="package.json"
TS_JSON_FILENAME="teacherseat.json"
LIB_VERSION_FILENAME="version.rb"

errorMsg() {
  local FILE=$1
  local MSG=$2
  echo ""
  echo "    ${CLBL}${FILE}${CLOG} not found.${RSTC}"
  if [ "$MSG" != "" ]; then
    echo "    ${MSG}"
  fi
  abortMsg "Process aborted!"
}

abortMsg() {
  local MSG=$1

  echo ""
  echo "    ${BGCRD}${CWHT}${MSG}${RSTC}${BGRSTC}"
  echo ""
  exit 1
}

checkIfFileExists() {
  local FOLDER=$1
  local FILE=$2

  if [ -f "${FOLDER}/${FILE}" ]; then
    VERSION=$(cat ${FOLDER}/${FILE} | grep version | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | xargs)

    if [ "$FILE" == "$PACKAGE_JSON_FILENAME" ]; then
      PACKAGE_JSON_VERSION=$VERSION
    else
      TS_JSON_VERSION=$VERSION
    fi
  fi
}

printSummary() {
  local FILE_NAME=$1
  local PACKAGE_OLD_TAG=$2
  local NEW_TAG=$3
  local TS_OLD_TAG=$4

  if [ "$PACKAGE_OLD_TAG" != "$NEW_TAG" ]; then
    echo ""
    echo "    ${CLBL}PREVIOUS:${RSTC}"
    echo "    ${CLBL}    Local tag version:                 ${PACKAGE_OLD_TAG}${RSTC}"
    if [ "$FILE_NAME" == "$PACKAGE_JSON_FILENAME" ]; then
      echo "    ${CLBL}    ${FILE_NAME} version:              ${PACKAGE_OLD_TAG}${RSTC}"
    else
      echo "    ${CLBL}    ${FILE_NAME} version:          ${PACKAGE_OLD_TAG}${RSTC}"
    fi
    if [ "$TS_OLD_TAG" != "" ]; then
      echo "    ${CLBL}    ${TS_JSON_FILENAME} version:          ${TS_OLD_TAG}${RSTC}"
    fi
  fi

  echo ""
  echo "    ${CLGN}NEW:${RSTC}"
  echo "    ${CLGN}    Local tag version:                 ${NEW_TAG}${RSTC}"
  if [ "$FILE_NAME" == "$PACKAGE_JSON_FILENAME" ]; then
    echo "    ${CLGN}    ${FILE_NAME} version:              ${NEW_TAG}${RSTC}"
  else
    echo "    ${CLGN}    ${FILE_NAME} version:          ${NEW_TAG}${RSTC}"
  fi
  if [ "$TS_OLD_TAG" != "" ]; then
    echo "    ${CLGN}    ${TS_JSON_FILENAME} version:          ${NEW_TAG}${RSTC}"
  fi
  echo ""
}

updateTeacherSeat() {
  local NEW_TAG=$1
  local FILE_PATH="${CURRENT_FOLDER}/${TS_JSON_FILENAME}"
  local NEW_FILE_PATH="${CURRENT_FOLDER}/NEW_${TS_JSON_FILENAME}"

  if [ -f $FILE_PATH ]; then
    updateTeacherSeatLib $NEW_TAG

    cat $FILE_PATH | sed -E "s/(\"version\":[ ]?\").*(\")/\1${NEW_TAG}\2/g" > $NEW_FILE_PATH
    rm $FILE_PATH ; mv $NEW_FILE_PATH $FILE_PATH
  else
    errorMsg $TS_JSON_FILENAME "${CLRD}Looks like you are trying to run the script outside of your project root path or ${CLBL}${TS_JSON_FILENAME}${CLRD} doesn't exist.${RSTC}"
  fi
}

updateTeacherSeatLib() {
  local NEW_TAG=$1
  LIB_FOLDER_NAME="engine_folder"

  if [ -d "$CURRENT_FOLDER/lib" ]; then
    for DIR in "$CURRENT_FOLDER/lib/"*; do
      ENGINE_FOLDER=$(basename "$DIR")

      if [ -d $DIR ] && [[ "$ENGINE_FOLDER" =~ ^(pa_|ts_).* ]]; then
        LIB_FOLDER_NAME=$ENGINE_FOLDER
      fi
    done

    local LIB_FOLDER="${CURRENT_FOLDER}/lib/${LIB_FOLDER_NAME}"

    if [ -d $LIB_FOLDER ]; then
      LIB_VERSION_FILE="${LIB_FOLDER}/${LIB_VERSION_FILENAME}"

      if [ -f $LIB_VERSION_FILE ]; then
        cat "${LIB_VERSION_FILE}" | sed -E "s/(VERSION[ ]?=[ ]?[\'\"]).*([\'\"])/\1${NEW_TAG}\2/g" > "${LIB_FOLDER}/NEW_${LIB_VERSION_FILENAME}"
        rm "${LIB_FOLDER}/${LIB_VERSION_FILENAME}"
        mv "${LIB_FOLDER}/NEW_${LIB_VERSION_FILENAME}" "${LIB_FOLDER}/${LIB_VERSION_FILENAME}"
      else
        errorMsg $LIB_VERSION_FILE
      fi
    fi
  fi
}

updateJson() {
  local NEW_TAG=$1
  local FILE_PATH="${CURRENT_FOLDER}/${PACKAGE_JSON_FILENAME}"
  local NEW_FILE_PATH="${CURRENT_FOLDER}/NEW_${PACKAGE_JSON_FILENAME}"

  if [ -f $FILE_PATH ]; then
    cat $FILE_PATH | sed -E "s/(\"version\":[ ]?\").*(\")/\1${NEW_TAG}\2/g" > $NEW_FILE_PATH
    rm $FILE_PATH ; mv $NEW_FILE_PATH $FILE_PATH
  else
    errorMsg $PACKAGE_JSON_FILENAME "${CLRD}Looks like you are trying to run the script outside of your project root path or ${CLBL}${PACKAGE_JSON_FILENAME}${CLRD} doesn't exist.${RSTC}"
  fi
}

checkTagExists() {
  local TAG=$(echo $1 | xargs)
  local OPTIONAL_TAG=$2

  if [ "$TAG" == "" ]; then
    TAG=$OPTIONAL_TAG
  fi

  if git rev-parse $TAG >/dev/null 2>&1 ; then
    echo ""
    echo "    ${CLRD}Tag ${CLBL}${TAG}${CLRD} already exists${RSTC}"
    echo ""

    return 1
  fi

  return 0
}

checkTag() {
  local TAG_EXISTS=$1
  local FILE_NAME=$2
  local TAG_VERSION=$3

  while [ $TAG_EXISTS -eq 1 ]; do
    echo -n "Please enter the ${CLBL}${FILE_NAME}${RSTC} ${UNDER}version${RSTF}: ${CGY}(${TAG_VERSION})${RSTC} "
    read NEW_TAG_VERSION_AGAIN
    checkTagExists $NEW_TAG_VERSION_AGAIN $TAG_VERSION
    TAG_EXISTS=$?
  done

  if [ "$NEW_TAG_VERSION_AGAIN" != "" ]; then
    NEW_TAG_VERSION=$NEW_TAG_VERSION_AGAIN
  fi
}

packageJson() {
  checkIfFileExists $CURRENT_FOLDER $PACKAGE_JSON_FILENAME
  checkIfFileExists $CURRENT_FOLDER $TS_JSON_FILENAME

  echo ""
  echo -n "Please enter the ${CLBL}${PACKAGE_JSON_FILENAME}${RSTC} ${UNDER}version${RSTF}: ${CGY}(${PACKAGE_JSON_VERSION})${RSTC} "
  read NEW_TAG_VERSION

  if [ "$NEW_TAG_VERSION" == "" ]; then
    NEW_TAG_VERSION=$PACKAGE_JSON_VERSION
  fi

  checkTagExists $NEW_TAG_VERSION $PACKAGE_JSON_VERSION
  TAG_EXISTS=$?

  checkTag $TAG_EXISTS $PACKAGE_JSON_FILENAME $PACKAGE_JSON_VERSION
  printSummary $PACKAGE_JSON_FILENAME $PACKAGE_JSON_VERSION $NEW_TAG_VERSION $TS_JSON_VERSION

  echo -n "Are you sure you want to bump the ${UNDER}version${RSTF}? ${CGY}(Y/n)${RSTC} "
  read ANSWER
  local CONFIRM=$(echo $ANSWER | tr [:upper:] [:lower:])

  if [ "${CONFIRM}" == "" ] || [ "${CONFIRM}" == "y" ] || [ "${CONFIRM}" == "yes" ]; then
    updateJson $NEW_TAG_VERSION

    echo "${CGY}$(npm install)"
    echo "${CGY}$(git add . ; git commit -m "bump tag to ${NEW_TAG_VERSION}" ; git push)"
    echo "${CGY}$(git tag ${NEW_TAG_VERSION} ; git push origin --tags)${RSTC}"
    echo "${BGCGN}${CWHT}Your tag has been bumped to${BGRSTC} ${BGCBL}${NEW_TAG_VERSION}${RSTC}${BGRSTC}"
    updatePullAssets
    echo ""
  else
    abortMsg "Process aborted!"
  fi
}

teacherseatJson() {
  checkIfFileExists $CURRENT_FOLDER $TS_JSON_FILENAME
  echo ""
  echo -n "Please enter the ${CLBL}${TS_JSON_FILENAME}${RSTC} ${UNDER}version${RSTF}: ${CGY}(${TS_JSON_VERSION})${RSTC} "
  read NEW_TAG_VERSION

  if [ "$NEW_TAG_VERSION" == "" ]; then
    NEW_TAG_VERSION=$TS_JSON_VERSION
  fi

  checkTagExists $NEW_TAG_VERSION $TS_JSON_VERSION
  TAG_EXISTS=$?

  checkTag $TAG_EXISTS $TS_JSON_FILENAME $TS_JSON_VERSION
  printSummary $TS_JSON_FILENAME $TS_JSON_VERSION $NEW_TAG_VERSION

  echo -n "Are you sure you want to bump the ${UNDER}version${RSTF}? ${CGY}(Y/n)${RSTC} "
  read ANSWER
  local CONFIRM=$(echo $ANSWER | tr [:upper:] [:lower:])

  if [ "${CONFIRM}" == "" ] || [ "${CONFIRM}" == "y" ] || [ "${CONFIRM}" == "yes" ]; then
    updateTeacherSeat $NEW_TAG_VERSION

    echo "${CGY}$(bundle install)"
    echo "${CGY}$(git add . ; git commit -m "bump tag to ${NEW_TAG_VERSION}" ; git push)"
    echo "${CGY}$(git tag ${NEW_TAG_VERSION} ; git push origin --tags)${RSTC}"
    echo "${BGCGN}${CWHT}Your tag has been bumped to${BGRSTC} ${BGCBL}${NEW_TAG_VERSION}${RSTC}${BGRSTC}"
    updateGemfile
    echo ""
  else
    abortMsg "Process aborted!"
  fi
}

updateGemfile() {
  if [ "$PROJECT_PATH" != "" ]; then
    local ENGINE_NAME=$(basename "$CURRENT_FOLDER")
    local FILE_PATH="${PROJECT_PATH}/Gemfile"
    local NEW_FILE_PATH="${PROJECT_PATH}/NEW_Gemfile"
    cat $FILE_PATH | sed -E "s/(gem '${ENGINE_NAME}'[ ]*,[ ]*(pa_attrs|ts_attrs)\(mode:[ ]*)(:path)/\1:git/g" |
                     sed -E "s/('${ENGINE_NAME}'[ ]*,[ ]*tag:[ ]*').*(')/\1${NEW_TAG_VERSION}\2/g" > $NEW_FILE_PATH
    rm $FILE_PATH ; mv $NEW_FILE_PATH $FILE_PATH
    cd $PROJECT_PATH
    echo "${CGY}$(bundle install)"
  fi
}

updatePullAssets() {
  local ENGINE_NAME=$(basename "$CURRENT_FOLDER")

  if [[ "$ENGINE_NAME" =~ ^([a-zA-Z]+)_ui_(.*) ]]; then
    local PART1=${BASH_REMATCH[1]}
    local PART2=${BASH_REMATCH[2]}
    local ASSET_NAME=$(echo $PART2 |  tr '[:lower:]' '[:upper:]' )
    local FILE_PATH="${PROJECT_PATH}/aws/deployment/after_install/pull_${PART1}_assets.sh"
    local NEW_FILE_PATH="${PROJECT_PATH}/aws/deployment/after_install/NEW_pull_${PART1}_assets.sh"

    if [ -f "$FILE_PATH" ]; then
      cat $FILE_PATH | sed -E "s/(${ASSET_NAME}=)(.*)/\1${NEW_TAG_VERSION}/g" > $NEW_FILE_PATH
      rm $FILE_PATH ; mv $NEW_FILE_PATH $FILE_PATH
      chmod u+x $FILE_PATH
    else
      errorMsg $FILE_PATH
    fi
  fi
}

init() {
  git pull > /dev/null

  if [ -f "${CURRENT_FOLDER}/${PACKAGE_JSON_FILENAME}" ]; then
    packageJson
  elif [ -f "${CURRENT_FOLDER}/${TS_JSON_FILENAME}" ]; then
    teacherseatJson
  fi
}

init
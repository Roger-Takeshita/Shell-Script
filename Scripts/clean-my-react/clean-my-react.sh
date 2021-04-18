#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

RSTC=$'\e[39m'       # reset color
CLGN=$'\e[38;5;2m'   # light green
CLOG=$'\e[38;5;215m' # light orange
CLRD=$'\e[38;5;1m'   # light red

SCRIPT_DIR=$(dirname "$0")
CURRENT_DIR="`pwd`"

echo "REACT_APP_BACKEND_URL=\"127.0.0.1:3001\"\nREACT_APP_BACKEND_PORT=3001" > .env.local

rm -rf public
rm -rf README.md
cp -r "${SCRIPT_DIR}/files/public" "${CURRENT_DIR}"
cd src
rm -rf logo.svg App.css index.css setupTests.ts App.test.tsx
mkdir -p components pages utils/@types
touch utils/@types/types.ts
cp -r "${SCRIPT_DIR}/files/assets" "${CURRENT_DIR}/src"
cp -r "${SCRIPT_DIR}/files/css" "${CURRENT_DIR}/src"
cp -r "${SCRIPT_DIR}/files/utils" "${CURRENT_DIR}/src"
cp "${SCRIPT_DIR}/files/App.tsx" "${CURRENT_DIR}/src"
cp "${SCRIPT_DIR}/files/index.tsx" "${CURRENT_DIR}/src"
cd ..
npm install
npm audit fix

echo ""
echo "    ${CLGN}All Good${RSTC}"
echo ""

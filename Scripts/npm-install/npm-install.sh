#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

noSyncFolder="node_modules.nosync"

if [ ! -d "$noSyncFolder" ] && [ ! -d "node_modules" ]; then
    mkdir $noSyncFolder && \
    ln -s $noSyncFolder "node_modules" && \
elif [ -d "node_modules" ] && [ ! -d "$noSyncFolder" ]; then
    mv "node_modules" $noSyncFolder && \
    ln -s $noSyncFolder "node_modules" && \
fi

npm install

#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

set -e

weather() {
  curl -m 1 wttr.in?format=1 2>/dev/null
#   sleep 900 # sleep for 15 minutes, throttle network requests whatever the value of status-interval
}

weather
#!/bin/bash

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

set -e
DIR=$(dirname `which $0`)
OPENWEATHER_KEY=$(cat "${DIR}/.env" | grep OPENWEATHER_KEY | sed -e "s/\(.*=\)\(.*\)/\2/" | xargs)

# Weather data reference: http://openweathermap.org/weather-conditions
weather_icon() {
  case $1 in
    200) echo 🌩
        ;;
    201) echo 🌩
        ;;
    202) echo 🌩
        ;;
    210) echo 🌩
        ;;
    211) echo 🌩
        ;;
    212) echo 🌩
        ;;
    221) echo 🌩
        ;;
    230) echo ⛈
        ;;
    231) echo ⛈
        ;;
    232) echo ⛈
        ;;
    300) echo ⛈
        ;;
    301) echo 🌧
        ;;
    302) echo 🌧
        ;;
    310) echo 🌧
        ;;
    311) echo 🌧
        ;;
    312) echo 🌧
        ;;
    313) echo 🌧
        ;;
    314) echo 🌧
        ;;
    321) echo 🌧
        ;;
    500) echo 🌧
        ;;
    501) echo 🌧
        ;;
    502) echo 🌧
        ;;
    503) echo 🌧
        ;;
    504) echo 🌧
        ;;
    511) echo 🌨
        ;;
    520) echo 🌧
        ;;
    521) echo 🌧
        ;;
    522) echo 🌧
        ;;
    531) echo 🌧
        ;;
    600) echo 🌨
        ;;
    601) echo 🌨
        ;;
    602) echo 🌨
        ;;
    611) echo 🌨
        ;;
    612) echo 🌨
        ;;
    615) echo 🌨
        ;;
    616) echo 🌨
        ;;
    620) echo 🌨
        ;;
    621) echo 🌨
        ;;
    622) echo 🌨
        ;;
    701) echo 🌫
        ;;
    711) echo 🌫
        ;;
    721) echo 🌫
        ;;
    731) echo 🌫
        ;;
    741) echo 🌫
        ;;
    751) echo 🌫
        ;;
    761) echo 🌫
        ;;
    762) echo 🌫
        ;;
    771) echo 🌦
        ;;
    781) echo 🌪
        ;;
    800) echo ☀️
        ;;
    801) echo 🌤
        ;;
    802) echo ⛅️
        ;;
    803) echo ⛅️
        ;;
    804) echo ☁️
        ;;
    900) echo 🌪
        ;;
    901) echo 🌪
        ;;
    902) echo 🌪
        ;;
    903) echo ❄️
        ;;
    904) echo 🔥
        ;;
    905) echo 🌬
        ;;
    906) echo 🌧
        ;;
    951) echo ☀️
        ;;
    952) echo 💨
        ;;
    953) echo 💨
        ;;
    954) echo 💨
        ;;
    955) echo 💨
        ;;
    956) echo 💨
        ;;
    957) echo 💨
        ;;
    958) echo 💨
        ;;
    959) echo 💨
        ;;
    960) echo ⛈
        ;;
    961) echo ⛈
        ;;
    962) echo 🌪
        ;;
    *) echo "$1"
  esac
}

LOCATION=$(curl --silent http://ip-api.com/csv)
CITY=$(echo "$LOCATION" | cut -d , -f 6)
LAT=$(echo "$LOCATION" | cut -d , -f 8)
LON=$(echo "$LOCATION" | cut -d , -f 9)

WEATHER=$(curl --silent http://api.openweathermap.org/data/2.5/weather\?lat="$LAT"\&lon="$LON"\&APPID="$OPENWEATHER_KEY"\&units=metric)

CATEGORY=$(echo "$WEATHER" | jq .weather[0].id)
# ICON_ID=$(echo "$WEATHER" | jq .weather[0].icon)
TEMP="$(echo "$WEATHER" | jq .main.temp | cut -d . -f 1)°C"
WIND_SPEED="$(echo "$WEATHER" | jq .wind.speed | awk '{print int($1+0.5)}')ms"
ICON=$(weather_icon "$CATEGORY")

printf "%s" "$TEMP $ICON $WIND_SPEED"
#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

tput reset

dir="`pwd`"
red=$'\e[0;31m'
grn=$'\e[0;32m'
yel=$'\e[0;33m'
blu=$'\e[0;34m'
mag=$'\e[0;35m'
cyn=$'\e[0;36m'
gry=$'\e[0;2m'
end=$'\e[0m'

gitCheck() {
	if [ -d "$1/.git" ]; then
		mod=0
		cd $1

		if [ $(git status | grep modified -c) -ne 0 ]; then
			mod=1
			echo "${yel}Modified File(s)   --> ${1##*/}${end}"
		fi

		if [ $(git status | grep Untracked -c) -ne 0 ]; then
			mod=1
			echo "${red}Untracked File(s)  --> ${1##*/}${end}"
		fi

		if [ $(git status | grep 'Your branch is ahead' -c) -ne 0 ]; then
			mod=1
			echo "${yel}Unpushed Commit(s) --> ${1##*/}${end}"
		fi

		if [ $mod -eq 0 ]; then
			echo "${gry}Nothing to Commit  --> ${1##*/}${end}"
		fi

		cd ../
	fi
}

if [ -d "$dir/.git" ]; then
	gitCheck $dir/
else
	for f in $dir/*
	do
		gitCheck $f
	done
fi
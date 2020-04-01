#!/bin/zsh
tput reset

dir="$1"

if [ -z "$dir" ]
then
    dir="`pwd`"
fi

gitCheck(){
	if [ -d "$1/.git" ]
	then
		mod=0
		cd $1

		if [ $(git status | grep modified -c) -ne 0 ]
		then
			mod=1
			echo -en "\033[0;33m"
			echo "Modified files    --> \033[33m${1}"
			echo -en "\e[2m"
		fi

		if [ $(git status | grep Untracked -c) -ne 0 ]
		then
			mod=1
			echo -en "\e[0;31m"
			echo "Untracked files   --> \e[0;31m${1}"
		fi

		if [ $(git status | grep 'Your branch is ahead' -c) -ne 0 ]
		then
			mod=1
			echo -en "\033[0;32m"
			echo "Unpushed commit   --> \033[0;32m${1}"
		fi

		if [ $mod -eq 0 ]
		then
			echo -en "\e[37m"
			echo -en "\e[2m"
			echo "Nothing to commit --> ${1}"
		fi

		cd ../
	# else
	# 	echo "Not a git repository"
	fi

	# echo
}

if [ -d "$dir/.git" ]
then
	gitCheck $dir/
else
	for f in $dir/*
	do
		gitCheck $f
	done
fi
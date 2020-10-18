#!/bin/zsh

# Developed by Roger Takeshita
# https://github.com/Roger-Takeshita/Shell-Script

# tput reset

red=$'\e[31m'
blue=$'\e[34m'
orange=$'\e[38;5;202m'
default=$'\e[39m'
bold=$'\e[1m'
end=$'\e[0m'

user=$(git config user.acc)
token=$(git config user.token)
folderName=''
markdownTitle=''
markdownHash=''
private=false
start=1

gitignore="# Compiled source #
###################
*.class
*.com
# *.dll
# *.exe
*.o
*.so

# Packages #
############
# it's better to unpack these files and commit the raw source
# git has its own built in compression methods
*.7z
*.dmg
*.gz
*.iso
*.jar
*.rar
*.tar
*.zip

# Logs and databases #
######################
*.log

# OS generated files #
######################
._*
.DS_Store
.DS_Store?
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Testing #
###########
.rspec
capybara-*.html
coverage
pickle-email-*.html
rerun.txt
spec/reports
spec/tmp
test/tmp
test/version_tmp

# node #
########
node_modules

# CTags #
#########
tags

# Env #
#######
.env

# Python #
#######
*.pyc
__pycache__/

# gitignore
# .gitignore

# Jupyter Notebook
.ipynb_checkpoints

# environment
.env
*.env

# vscode
*.vscode

**build/

# c++ formatter
.clang-format

# Roger-That
roger-that
Roger-That
Roger-That.md

# Google Firebase
**/serviceAccountKey.json
**/env.json

# React
*.env.local

# AWS Private Key
*.pem"

if [ "$user" = "" ]; then
   echo Please add your github username to your git config
   echo Run the following command: ${blue}git config --global user.acc \"${orange}your_github_username${blue}\"
   exit 1
fi

if [ "$token" = "" ]; then
   echo Please add a personal token to your git config
   echo Visit ${blue}https://github.com/settings/tokens${default}
   echo " - ${orange}Generate new token${default}"
   echo "   - Select ${orange}repo${default}"
   echo Run the following command: ${blue}git config --global user.token \"${orange}your_github_token${blue}\"
   exit 1
fi

if [ $# -eq 0 ] || [ $# -eq 1 ] && [ "$1" = "-p" ]; then
    echo "${red}${bold}ERROR:${end}${default} You must provide a foder name"
    exit 1
fi

if [ "$1" = "-p" ]; then
    private=true
    start=2
fi

stringConcat() {
    for count in `seq $start $#`;
    do
        if [ $count -eq $start ]; then
            folderName=$@[count]
            markdownTitle="${@[count]:u}"
            markdownHash="${@[count]:l}"
        else
            folderName+="_${@[count]}"
            markdownTitle+=" ${@[count]:u}"
            markdownHash+="-${@[count]:l}"
        fi
    done    
}

initProject() {
    if [ ! -d "$folderName" ]; then
        mkdir -p "$folderName"
        cd $folderName
        git init
        echo "<h1 id='contents'>Table of Contents</h1>\n\n- [${markdownTitle}](#${markdownHash})\n\n# ${markdownTitle}\n\n[Go Back to Contents](#contents)" >> README.md
        echo $gitignore >> .gitignore
        git add .
        git commit -m "First Commit"
        git remote add origin https://github.com/$user/$folderName.git
        curl -u $user:$token --silent --output /dev/null https://api.github.com/user/repos -d '{"name":"'"$folderName"'", "private": "'"$private"'"}'
        git push -u origin master
        exec zsh
    else 
        echo "${red}${bold}ERROR:${end}${default} A folder named '${orange}$folderName${default}' already exists, please use a different name"
        exit 1
    fi
}

stringConcat $@
initProject
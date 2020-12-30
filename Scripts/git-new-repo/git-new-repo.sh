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
npm-debug.log*
yarn-debug.log*
yarn-error.log*
lerna-debug.log*
db.sqlite3
db.sqlite3-journal

# OS generated files #
######################
._*
.DS_Store
.DS_Store?
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Distribution / packaging #
############################
.Python
.expo/
build/
develop-eggs/
dist/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
pip-wheel-metadata/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

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
node_modules.nosync
jspm_packages/

# CTags #
#########
tags

# Env #
#######
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/
pythonenv*
*.env.local
*env.*

# Python #
##########
**/auth.ini
*.log
*.pot
*.pyc
__pycache__/
local_settings.py
media
bin/

# Django.Python Stack #
#######################
# Byte-compiled / optimized / DLL files
*.py[cod]
*$py.class

# PyInstaller #
###############
#  Usually these files are written by a python script from a template
#  before PyInstaller builds the exe, so as to inject date/other infos into it.
*.manifest
*.spec

# Installer logs #
##################
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports #
################################
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.py,cover
.hypothesis/
.pytest_cache/
pytestdebug.log

# Jupyter Notebook #
####################
.ipynb_checkpoints

# pyenv #
#########
.python-version

# Jupyter Notebook #
####################
.ipynb_checkpoints

# vscode #
##########
.vscode

# c++ formatter #
#################
.clang-format

# Google Firebase #
###################
serviceAccountKey.json
env.json

# AWS Private Key #
###################
*.pem

# Ruby on Rails #
#################
**/tmp
**/public/packs/
**/config/master.key

# Roger-That #
##############
downloads/
roger-that/
roger-that.md
"


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
        git branch -M main
        git remote add origin https://github.com/$user/$folderName.git
        curl -u $user:$token --silent --output /dev/null https://api.github.com/user/repos -d '{"name":"'$folderName'", "private": '$private'}'
        git push -u origin main
        code .
        exec zsh
    else
        echo "${red}${bold}ERROR:${end}${default} A folder named '${orange}$folderName${default}' already exists, please use a different name"
        exit 1
    fi
}

stringConcat $@
initProject
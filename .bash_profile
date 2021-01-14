# = Default Editor
export EDITOR="code -w"

# = Alias
# _ General
alias z="code ~/.zshrc"
alias sz="source ~/.zshrc"
alias b="code ~/.bash_profile"
alias sb="source ~/.bash_profile"
alias task="htop"
alias lsa="ls -al"
alias git-ignore='code /Users/roger-that/.gitignore_global'
alias git-config='code /Users/roger-that/.gitconfig'
alias ssh-config='code /Users/roger-that/.ssh/config'
alias puma="ps aux | grep puma"
alias roger="ssh roger@10.0.0.30"
alias pi="ssh pi@10.0.0.100"

# _ GitHub
alias gs="git status"
alias gc="git commit"
alias gui="git update-index --assume-unchanged"
alias gnui="git update-index --no-assume-unchanged"
alias guil="git ls-files -v | grep '^h'"

# _ Python
alias python="/Library/Frameworks/Python.framework/Versions/3.9/bin/python3"
alias pip="pip3"
alias pmr="python manage.py runserver"
alias pms="python manage.py shell"
alias pm="python manage.py"

# _ Ruby on Rails
alias bi="bundle install $@"
alias bu="bundle update $@"

# _ Scripts
alias git-status='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/git-status/git-status.sh'
alias git-pull='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/git-pull/git-pull.sh'
alias @img='python3 /Users/roger-that/Documents/Codes/Python/11_Scripts/Imgur/Imgur.py'
alias @new='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/git-new-repo/git-new-repo.sh'
alias @open='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/open-app/open-app.sh'
alias @screenshot='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/macos-screenshot-rename/macos-screenshot-rename.sh'
alias @touch='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/touch-open/touch-open.sh'
alias @clear='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/clean-my-node/clean-my-node.sh'
alias @npm='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/npm-install/npm-install.sh'

# = Shortcuts
alias desk="cd /Users/roger-that/Desktop"
alias desktop="cd /Users/roger-that/Desktop"
alias codes="cd /Users/roger-that/Documents/Codes"
alias config="cd /Users/roger-that/Documents/Roger-That/Dev/1-Config"
alias rubo="code /Users/roger-that/Documents/Roger-That/Dev/1-Config/YML/.prepanywhere_rubocop.yml"

# = Functions
function die() {
    ps aux | grep "$@" | awk '{print $2}' | while read -r PID ; do
        if [ -n "$(ps -p $PID -o pid=)" ]; then
            kill -9 $PID
            echo "$PID ✝ Rest in Peace"
        fi
    done
}

function findf() {
    find . -type f -name "*$@*"
}

function findd() {
    find . -type d -name "*$@*"
}

function portkill () {
    if (lsof -t -i:$1) {
        kill -QUIT $(lsof -sTCP:LISTEN -i tcp:$1 -t)
    } else {
        echo "All Good"
    }
}

function killport () {
    if (lsof -t -i:$1) {
        kill -QUIT $(lsof -sTCP:LISTEN -i tcp:$1 -t)
    } else {
        echo "All Good"
    }
}

function kport() {
    lsof -n -i4TCP:$1 | grep LISTEN | awk '{ print $2 }' | xargs kill
}
# = Default Editor
export EDITOR="code -w"

# = Alias
# _ General
alias z="code ~/.zshrc"
alias sz="source ~/.zshrc"
alias b="code ~/.bash_profile"
alias sb="source ~/.bash_profile"
alias @clear-history="rm ~/.zsh_history"
alias task="htop"
alias lsa="ls -al"
alias npm-list='npm list -g --depth 0'
alias puma="ps aux | grep puma"

# _Config
alias git-ignore='code /Users/roger-that/.gitignore_global'
alias git-config='code /Users/roger-that/.gitconfig'
alias aws-config='code /Users/roger-that/.aws/config'
alias aws-credentials='code /Users/roger-that/.aws/credentials'
alias ssh-config='code /Users/roger-that/.ssh/config'
alias config="code /Users/roger-that/Documents/Roger-That/Dev/1-Config"
alias rubo="code /Users/roger-that/Documents/Codes/TeacherSeat/Documentation/ts_standards/linter/.teacherseat_rubocop.yml"

# _ssh
alias roger="ssh roger@10.0.0.30"
alias pi="ssh pi@10.0.0.100"

# _ GitHub
alias GS="git-status"
alias gs="git-status"
alias gsl="git stash list"
alias pull="git-pull"
alias new="git-new"
alias gti="git"
alias tag='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/git-tag-all-in-one/git-tag-all-in-one.sh'
alias gsa='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/git-stash-apply/git-stash-apply.sh'
alias gss='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/git-stash-show/git-stash-show.sh'
alias gssf='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/git-stash-show-files/git-stash-show-files.sh'
alias restore='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/git-restore/git-restore.sh'
alias rst='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/git-reset-head/git-reset-head.sh'
alias git-commit='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/git-commit-amend-date/git-commit-amend-date.sh'

# _ Python
alias pip="pip3"
alias pmr="python manage.py runserver"
alias pms="python manage.py shell"
alias pm="python manage.py"
alias jupyter="python -m notebook"

# _ Ruby on Rails
alias bi="bundle install $@"
alias bu="bundle update $@"

# _ Scripts
alias @img='python3 /Users/roger-that/Documents/Codes/Python/11_Scripts/Imgur/Imgur.py'
alias @open='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/open-app/open-app.sh'
alias @screenshot='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/macos-screenshot-rename/macos-screenshot-rename.sh'
alias touch='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/touch-open/touch-open.sh'
alias @clear='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/clean-my-node/clean-my-node.sh'
alias @npm='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/npm-install/npm-install.sh'
alias @dump='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/postgres-dump/postgres-dump.sh prepanywhere'
alias @mode="osascript -e 'tell app \"System Events\" to tell appearance preferences to set dark mode to not dark mode'"

# = Shortcuts
alias desk="cd /Users/roger-that/Desktop"
alias desktop="cd /Users/roger-that/Desktop"
alias codes="cd /Users/roger-that/Documents/Codes"

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
    # find . -type f -name "*$@*"
    find . -type d \( -name node_modules -o -name node_modules.nosync -o -name tmp -o -name dist -o -name build -o -name .vscode \) -prune -false -o -name "*$@*"
}

function findd() {
    # find . -type d -name "*$@*"
    find . -type d -name "*$@*" ! -path "**/node_modules/*" ! -path "**/node_modules.nosync/*" ! -path "**/tmp/*"
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

export ZSH="/Users/roger-that/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(git)
source $ZSH/oh-my-zsh.sh
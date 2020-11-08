autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

bindkey -v
export KEYTIMEOUT=1

#! Default Editor
export EDITOR="code -w"

#! Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

#! Alias
alias z="code ~/.zshrc"
alias sz="source ~/.zshrc"
alias b="code ~/.bash_profile"
alias sb="source ~/.bash_profile"
alias task="htop"

alias python="python3"
alias pip="pip3"
alias pmr="python manage.py runserver"
alias pms="python manage.py shell"
alias pm="python manage.py"

alias lsa="ls -al"
alias git-status='/Users/roger-that/Library/Mobile\ Documents/com~apple~CloudDocs/Codes/Shell_Script/Scripts/git-status/git-status.sh'
alias @img='python3 /Users/roger-that/Library/Mobile\ Documents/com~apple~CloudDocs/Codes/Python/11_Scripting/Imgur/Imgur.py'
alias @new='/Users/roger-that/Library/Mobile\ Documents/com~apple~CloudDocs/Codes/Shell_Script/Scripts/git-new-repo/git-new-repo.sh'
alias touch='/Users/roger-that/Library/Mobile\ Documents/com~apple~CloudDocs/Codes/Shell_Script/Scripts/touch-open/touch-open.sh'
alias clean='/Users/roger-that/Library/Mobile\ Documents/com~apple~CloudDocs/Codes/Shell_Script/Scripts/clean-my-node/clean-my-node.sh'
alias git-ignore='code /Users/roger-that/.gitignore_global'
alias git-config='code /Users/roger-that/.gitconfig'
alias ssh-config='code /Users/roger-that/.ssh/config'

#= Shortcuts
alias desk="cd /Users/roger-that/Desktop"
alias desktop="cd /Users/roger-that/Desktop"
alias codes="cd /Users/roger-that/Library/Mobile\ Documents/com~apple~CloudDocs/Codes"

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

#! Ruby on Rails
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

#PS1="%{%F{red}%}%n%{%f%}@%{%F{blue}%}%m %{%F{yellow}%}%~ %{$%f%}%% "

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/roger-that/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

ZSH_THEME="agnoster"

# ZSH_THEME="powerlevel9k/powerlevel9k"
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
#remove the path
# echo "DEFAULT_USER=\"roger-that\""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="/usr/local/opt/postgresql@11/bin:$PATH"

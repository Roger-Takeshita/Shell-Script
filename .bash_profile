#! Default Editor
export EDITOR="code -w"

#! Alias
alias z="code ~/.zshrc"
alias sz="source ~/.zshrc"
alias b="code ~/.bash_profile"
alias sb="source ~/.bash_profile"
alias task="htop"

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

#! Ruby on Rails
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# export LSCOLORS="EHfxcxdxBxegecabagacad"
# alias ls='ls -lGH'

# https://www.youtube.com/watch?v=LXgXV7YmSiU
# orange=$(tput setaf 166);
# yellow=$(tput setaf 228);
# green=$(tput setaf 71);
# white=$(tput setaf 15);
# bold=$(tput bold);
# reset=$(tput sgr0);

# PS1="\[${bold}\]\n]";
# PS1+="\[${orange}\]\u]";  #username
# PS1+="\[${white}\] at ";
# PS1+="\[${yellow}\]\h]";  #host
# PS1+="\[${white}\] in ";
# PS1+="\[${green}\]\W]";   #working directory
# PS1+="\n";
# PS1+="\[${white}\]\$ \[${reset}\]";  # `$` (and reset color)
# export PS1;
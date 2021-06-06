<h1 id='table-of-contents'>TABLE OF CONTENTS</h1>

- [Backup Mac](#backup-mac)
  - [How To Use](#how-to-use)

# Backup Mac

This script will backup MacOS dev configuration:

- `~` (`/Users/your_username`) specific folder/files
- `/Users/your_username/Library/Preferences/` programs configuration

## How To Use

[Go Back to Contents](#table-of-contents)

Create a `bkp_app.txt` and `bkp_config.txt` and add all the folders/files/programs that you want to backup

**Examples:**

In `your_path_to/Shell_Script/Scripts/backup-mac/bkp_app.txt`

```Text
  moom
  iterm
  magnet
  snagit
  keyboardmaestro
  breaktimer
  Terminal
```

In `your_path_to/Shell_Script/Scripts/backup-mac/bkp_config.txt`

```Text
  bin
  .aws
  .ssh
  .ssl
  .clang-format
  .gitconfig
  .gitignore_global
  .prettierrc
  .psqlrc
  .tmux.conf
  .tmux.conf.local
  .vimrc
  .zshrc
  .zsh_functions
```

Once you run the script, it will create a backup folder in your desktop

![](https://i.imgur.com/tZPAs4b.png)

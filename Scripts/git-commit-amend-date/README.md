# GIT-COMMIT-AMEND

- Changes the date of your last commit

## How to use?

- Create a new alias into your `.zshrc` or `.bash_profile`

  ```Bash
    alias git-ca='/Users/roger-that/Documents/Codes/Shell_Script/Scripts/git-commit-amend-date/git-commit-amend-date.sh'
  ```

- Once you run the script, the script will copy a pre formatted git command (`git commit --amend --no-edit --date="Wed Jan 3 12:13:06 2021 -0500"`) to your clipboard
- Then you can edit the date and time accordingly to your needs

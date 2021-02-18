# Use NPM Package

- [npm i -g git-new](https://www.npmjs.com/package/git-new)

# @new - Git Repository

- [Source Code](https://github.com/Roger-Takeshita/Shell-Script/blob/master/git-new-repo.sh)
- Create a new github repository using command line. This script will create a new repo, add `.gitignore` and `README.md`

- Add a new alias to your `zsh/bash`:

  - `alias @new='./your_path/git-new-repo.sh'`

- Config **username**

  - Create a new github global variable, run `git config --global user.acc "your_github_username"`
  - Check if it worked, `git config user.acc`, it should return your github username

- Create **GitHub Token**

  - Visit [https://github.com/settings/tokens](https://github.com/settings/tokens)
    - Click on **Generate new token**
      - Note: Give a name to your token
      - Select: **repo**
  - Create a new github global variable, run `git config --global user.token "your_github_token"`
  - Check if it worked, `git config user.token`, it should return your github token

- Create a new repo
  - Run the command `@new My New Repo`
    - This command will create a new repo called `My_New_Repo` with:
      - `.gitignore` - already pre formatted
      - `README.md` - basic content structure
    - **Optional command**
      - `-p` = private repository. Must be the fist argument after the command `@new`, otherwise it will create a repo e.g `my_-p_repo`, `my_repo_-p` depending where you added the `-p` (not private)
        - `@new -p My Private Repo` **correct way**

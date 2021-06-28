# Git Tag All-In-One

**IMPORTANT:** Make sure you are on the `main/master` branch before tagging the engine

Possible scenarios:

1. if `package.json` exists, it will:

   - Pull the latest code
   - Update the `package.json` version
   - `npm install`
   - Push modifications (if necessary - updated `package.json` and `package-lock.json`, just in case you forgot to bump the version)
   - Tag the last commit

2. if `teacherseat.json` exists, it will:

   - Pull the latest code
   - It will check If `lib/ts_xxxxx_xx` or `lib/pa_xxxxx_xx` folder exists
     - If folder exists, it will update the `version.rb` version
       - If `version.rb` **doesn't exist**, **it will stop the script**
     - If folder doesn't exist, it will continue normally
   - Update the `teacherseat.json` version
   - `bundle install`
   - Push modifications (if necessary - updated `teacherseat.json` and `version.rb`, just in case you forgot to bump the version)
   - Tag the last commit

> The script will check if the current `package.json/teacherseat.json` version has already been tagged (if local tag exists), if `yes` this means that we need to bump the version.

> If `PROJECT_PATH` is set, it will update the `Gemfile`/`pull_xx_assets.sh` (where applicable)

## Main Project Path

If you have the `PROJECT_PATH` variable set in your shell, the `git-tag-all-in-one.sh` will update the your project `Gemfile` and `pull_xx_assets.sh` when you tag the engine.

```Bash
  # PROJECT_PATH example
  export PROJECT_PATH="path_to/prepanywhere-projects/PrepAnywhere_Tutor_City"
```

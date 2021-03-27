# Git Delete Tag

Deletes local and remote tags with a single command line.

## How to use

On `terminal`

```Bash
  dtag 1.1.0
```

> The script will check if a local tag exists before deleting remote tag
> If local tag doesn't exist, it won't delete remote tag

Create an **alias** of your choice in `~/.zshrc` or `~/.bash_profile`

```Bash
  alias dtag='path_to/git-d-tag.sh'
```

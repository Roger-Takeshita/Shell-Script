<h1 id='summary'>Summary</h1>

* [My Scripts](#myscripts)
  * [git-status](#gitstatus)
* [Bash Shell](#bashshell)
  * [Basic Command Line](#basiccommnad)
    * [Help Page](#helppage)
    * [ls](#ls)
    * [cd](#cd)
    * [View File](#view)
    * [Create Copy Remove Move Files](#ccrmfiles)
    * [Other commands](#othercommands)
    * [Escaping](#escaping)
  * [Using Bash More Effectively](#bashmoreeffectively)
    * [Wildcards](#wildcards)

<h1 id='myscripts'>My Scripts</h1>

<h2 id='gitstatus'>git-status</h2>

[Go Back to Summary](#summary)

  * [File Link](https://github.com/Roger-Takeshita/Shell-Script/blob/master/git-status.sh)
  * Search for uncommit files from a specific folder (main coding folder or a single folder)

<h1 id='bashshell'>Bash Shell</h1>

[Go Back to Summary](#summary)

* ATENTTION
  * No undelete
  * No undo
  * Always read your input twice before executing it

<h2 id='basiccommnad'>Basic Command Line</h2>

* The order of the options does not matter
* File name has to be at the end

<h3 id='helppage'>Help Page</h3>

[Go Back to Summary](#summary)

* Getting Help
  * Command `man`
    * `man ls`
    * `man cd`
    * `man man`

* How navigate
  * `space` to move down a page
  * `b` to move back a page
  * `/` search
  * `q` exit

* History
  * View the previous command in history
    * Arrow key up
    * Ctrl+p (if the system doesn't support arrow key)
  * View the next command in history
    * Arrow key down
    * Ctrl+n (if the system doesn't support arrow key)

<h3 id='ls'>ls</h3>

[Go Back to Summary](#summary)

* `ls` - List of files on the current directory

  ```Bash
    LICENSE       README.md     git-status.sh
  ```

* `ls -a` - List all files (including hidden)

  ```Bash
    .             ..            .git          LICENSE       README.md     git-status.sh
  ```

  * `.` points to the current directory
  * `..` points to the parent directory

* `ls -l` - List files in long format

  ```Bash
    -rw-r--r--  1 roger-that  staff  1072  1 Apr 00:14 LICENSE
    -rw-r--r--  1 roger-that  staff  1831 20 Apr 10:56 README.md
    -rwxr--r--@ 1 roger-that  staff   873  1 Apr 01:23 git-status.sh
  ```

* `ls -l -a` - Combine both `a` and `l` options

  ```Bash
    drwxr-xr-x@  6 roger-that  staff   192  1 Apr 16:15 .
    drwxr-xr-x@ 27 roger-that  staff   864 20 Apr 10:19 ..
    drwxr-xr-x@ 14 roger-that  staff   448 20 Apr 10:59 .git
    -rw-r--r--   1 roger-that  staff  1072  1 Apr 00:14 LICENSE
    -rw-r--r--   1 roger-that  staff  1831 20 Apr 10:56 README.md
    -rwxr--r--@  1 roger-that  staff   873  1 Apr 01:23 git-status.sh
  ```

* `ls -la` - Combine both `a` and `l` options

  ```Bash
    drwxr-xr-x@  6 roger-that  staff   192  1 Apr 16:15 .
    drwxr-xr-x@ 27 roger-that  staff   864 20 Apr 10:19 ..
    drwxr-xr-x@ 14 roger-that  staff   448 20 Apr 10:59 .git
    -rw-r--r--   1 roger-that  staff  1072  1 Apr 00:14 LICENSE
    -rw-r--r--   1 roger-that  staff  1831 20 Apr 10:56 README.md
    -rwxr--r--@  1 roger-that  staff   873  1 Apr 01:23 git-status.sh
  ```

* `ls -la .git` - List all in `/bin` in a longo format

  ```Bash
    drwxr-xr-x@ 14 roger-that  staff  448 20 Apr 11:00 .
    drwxr-xr-x@  6 roger-that  staff  192  1 Apr 16:15 ..
    -rw-r--r--   1 roger-that  staff   59  1 Apr 01:25 COMMIT_EDITMSG
    -rw-r--r--   1 roger-that  staff   23  1 Apr 00:14 HEAD
    -rw-r--r--   1 roger-that  staff   41  1 Apr 01:04 ORIG_HEAD
    -rw-r--r--   1 roger-that  staff  321  1 Apr 00:14 config
    -rw-r--r--   1 roger-that  staff   73  1 Apr 00:14 description
    drwxr-xr-x@ 13 roger-that  staff  416  1 Apr 16:15 hooks
    -rw-r--r--   1 roger-that  staff  289  1 Apr 01:25 index
    drwxr-xr-x@  3 roger-that  staff   96  1 Apr 16:15 info
    drwxr-xr-x@  4 roger-that  staff  128  1 Apr 16:15 logs
    drwxr-xr-x@ 18 roger-that  staff  576  1 Apr 16:15 objects
    -rw-r--r--   1 roger-that  staff  114  1 Apr 00:14 packed-refs
    drwxr-xr-x@  5 roger-that  staff  160  1 Apr 16:15 refs
  ```

* `ls -R` - List all the files inside the folders recursively

<h3 id='cd'>cd</h3>

[Go Back to Summary](#summary)

* `cd` - Just `cd` alone goes back to the home directory
* `cd ..` - go back one level
* `cd Downloads/` - change directory to downloads

<h3 id='view'>View File</h3>

[Go Back to Summary](#summary)

* `cat README.md` - display the whole file
* `less README.md` - display part of the file (use navigate commands)
* `file README.md` - outputs the type of the file `README.md: ASCII text`
* `file *` - outputs all the files and types

<h3 id='ccrmfiles'>Create Copy Remove Move Files</h3>

[Go Back to Summary](#summary)

* `mkdir` - creates a directory

  ```Bash
    #mkdir <folder 1> <folder 2> ... <folder n>

    mkdir new_readme_folder
  ```

* `touch` - creates an empty file
  
  * We need to add the extension, otherwise, UNIX will create a new file without extension.
  * Calling `touch` on an existing file it updates modification and access dates (only). It doesn't do anything like override or delete the whole content of the file.

  ```Bash
      #touch <file name 1> <file name 2> ... <file name n>

      touch test.txt
  ```

* `cp` - copy files
  
  ```Bash
    # Copy README.md to the Desktop folder

    cp README.md ~/Desktop

    # Copay README.md to the current folder and rename as README1.md
    
    cp README.md README1.md
  ```

* `cp *` - copy all the files of the current directory

* `cp -R` - copy directories. Copy all the files and folders recursively

  ```Bash
    # cp -R <dir 1> <dir 2> ... <dir n> <destination dir>

    cp -R demo cp_demo
  ```

* `mv` - move/rename a file
  * Rename a file

  ```Bash
      # mv <original file name> <new file name>

      mv README.md README1.md
  ```
  * Move file

  ```Bash
      # mv <file 1> <file 2> ... <file n> <directory path/name>
      
      mv README.md new_readme_folder
  ```

* `rm` - removes a file

  ```Bash
    rm new_readme_folder/README.md
  ```

* `rm -r` - removes the entire folder

  ```Bash
    rm new_readme_folder
  ```

* `rm -ri` - removes the folder but asks which folder you want to remove

<h3 id='othercommands'>Other commands</h3>

[Go Back to Summary](#summary)
  
* `pwd` -  show the complete path of the working directory
* `echo $BASH` - check that you using bash, output should be `/bin/bash`
* `open` - opens the program associated with this file

  ```Bash
      open index.html             # Opens html file in the browser
      open .                      # Opens current directory in Finder
      open -a Preview picture.js  # Opens picture.jpg with Preview
  ```

<h3 id='escaping'>Escaping</h3>

[Go Back to Summary](#summary)

* `\` - Backslash escapes a single character
* `''` - Single quotes escapes all characters between them
* `""` - Double quotes handle some special characters and ingores others

<h2 id='bashmoreeffectively'>Using Bash More Effectively</h2>

[Go Back to Summary](#summary)

<h3 id='wildcards'>Wildcards</h3>

[Go Back to Summary](#summary)

* `ls a*` - list all the files/directories that starts with `a`
* `ls *a` - list all the files/directories that ends with `a`
* `ls *a*` - list all the files/directories that has `a`

* Moving all types files into a folder
  * `mv *jpeg pictures` - Move all the `.jpeg` files into `pictures` folder
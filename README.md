<h1 id='summary'>Summary</h1>

-   [My Scripts](#myscripts)
    -   [Transform Into Executable | chmod +x](#chmodx)
    -   [Shell Scripts](#rogerscripts)
        -   [git-status](#gitstatus)
        -   [touch-open](#touchopen)
        -   [clean-my-node](#cleanmynode)
    -   [Colors and Properties](#shcolors)
-   [Bash Shell](#bashshell)
    -   [Basic Command Line](#basiccommnad)
        -   [Help Page](#helppage)
        -   [ls](#ls)
        -   [cd](#cd)
        -   [View File](#view)
        -   [Create Copy Remove Move Files](#ccrmfiles)
        -   [Other commands](#othercommands)
        -   [Escaping](#escaping)
    -   [Using Bash More Effectively](#bashmoreeffectively)
        -   [Wildcards](#wildcards)
        -   [Brace Expansion](#braceexpansion)
        -   [Output Redirection](#outputredirection)
            -   [Pipe](#pipe)
            -   [Command Substitution](#commandsub)
            -   [Key Combinations](#keycombinations)
    -   [Filtering and Processing Text](#processingtext)
        -   [Text Editors](#texteditors)
            -   [Nano Editor](#nanoeditor)
            -   [Vi Editor](#vieditor)
            -   [Emacs Editor](#emacseditor)
        -   [Sort - Sorting](#sorting)
        -   [Head/Tail - Head and Tail](#headtail)
        -   [WC - Counting words](#couting)
        -   [Grep - Search and Filter Text](#grep)
        -   [Find - Search for Files](#find)
        -   [Tr - Find and Replace Characters](#findreplace)
        -   [Advanced Tools](#advanced)
        -   [Column-based Data](#columnbase)
    -   [Jobs and Processes](#jobs)
        -   [Background Jobs](#background)
        -   [Killing Jobs and Process](#killingprogram)
        -   [Inspecting Processes](#inspectingprocesses)

<h1 id='myscripts'>My Scripts</h1>

<h2 id='chmodx'>Transform Into Executable | chmod +x</h2>

[Go Back to Summary](#summary)

-   The command `chmod +x <path/file_name>` transforms the script (.sh) into an executable
-   in your shell configuration you can add and alias to run the script

    ```Bash
      alias git-status='../Codes/Shell-Script/git-status.sh'
      alias touch='../Codes/Shell-Script/touch-open.sh'
    ```

<h2 id='rogerscripts'>Shell Scripts</h2>

<h3 id='gitstatus'>git-status</h3>

[Go Back to Summary](#summary)

-   [File Link](https://github.com/Roger-Takeshita/Shell-Script/blob/master/git-status.sh)
-   Search for uncommitted files from a specific folder (main coding folder or a single folder)

<h3 id='touchopen'>touch-open</h3>

[Go Back to Summary](#summary)

-   [File Link](https://github.com/Roger-Takeshita/Shell-Script/blob/master/touch-open.sh)
-   Search if path and file already exist, otherwise, it will create the folder(s) and the file

    -   if we pass `-n` as the first argument, the script wont open the files after creating them
        -   `touch -n test/test.js test1/test1.js`
        -   My default editor is the VSCode
    -   if we pass `+` between files, it will create the next file inside the previous folder, we can nest multiple folder/files
        -   unfortunately we can't go back to the previous folder, we can only create the file on the same level or above
    -   if we pass a path without an extension, the program understands that we want to create a folder

        -   `touch folder/subfolder`
        -   `touch outside1.js head1/node1/tail1/leaf1.js + leaf2.js head2/node2/node2a/tail2a/leaf2a1.js + leaf2a2.js head2/node2/node2b/tail2b/leaf2b1.js + leaf2b2.js`

        ```Bash
          ├─ head1
          │  └─ node1
          │     └─ tail1
          │        ├─ leaf1.js
          │        └─ leaf2.js
          ├─ head2
          │  └─ node2
          │     ├─ node2a
          │     │  └─ tail2a
          │     │     ├─ leaf2a1.js
          │     │     └─ leaf2a2.js
          │     └─ node2b
          │        └─ tail2b
          │           ├─ leaf2b1.js
          │           └─ leaf2b2.js
          ├─ outside1.js
          ├─ folder
          │  └─ subfolder
        ```

<h3 id='cleanmhnode'>clean-my-node</h3>

[Go Back to Summary](#summary)

-   **clean-my-node**, deletes the `node_modules` and `package-lock.json`
    -   Only works up to 3 lvls
        -   1 lvl (codes folder) - checks if the current lvl has a `node_module` folder or `package-lock.json` file
        -   2 lvl (repo folder) - checks the sub folder has a `node_module` folder or `package-lock.json` file
        -   3 lvl (submodule) - checks the sub sub folder has a `node_module` folder or `package-lock.json` file

<h2 id='shcolors'>Colors and Properties</h2>

[Go Back to Summary](#summary)

-   [Colors and Formatting](https://misc.flogisoft.com/bash/tip_colors_and_formatting)

-   **Colors**

    ```Bash
      default=$'\e[39m'
      black=$'\e[30m'
      red=$'\e[31m'
      green=$'\e[32m'
      yellow=$'\e[33m'
      blue=$'\e[34m'
      magenta=$'\e[35m'
      cyan=$'\e[36m'
      lGray=$'\e[37m'
      dGray=$'\e[38m'
      lRed=$'\e[91m'
      lGreen=$'\e[92m'
      lYellow=$'\e[93m'
      lBlue=$'\e[94m'
      lMagenta=$'\e[95m'
      lCyan=$'\e[96m'
      white=$'\e[97m'
    ```

-   **Formatting**

    ```Bash
      dim=$'\e[2m'
      dimNormal=$'\e[22m'

      textBold=$'\e[1m'
      textNormal=$'\e[21m'

      italic=$'\e[3m'

      end=$'\e[0m'

      under=$'\e[4m'
      underNormal=$'\e[24m'

      blink=$'\e[5m'
      blinkNormal=$'\e[25m'

      inverted=$'\e[7m'
      invertedNormal=$'\e[27m'

      hidden=$'\e[8m'
      hiddenNormal=$'\e[28m'
    ```

<h1 id='bashshell'>Bash Shell</h1>

[Go Back to Summary](#summary)

-   ATENTTION
    -   No undelete
    -   No undo
    -   Always read your input twice before executing it

<h2 id='basiccommnad'>Basic Command Line</h2>

-   The order of the options does not matter
-   File name has to be at the end

<h3 id='helppage'>Help Page</h3>

[Go Back to Summary](#summary)

-   Getting Help

    -   Command `man`
        -   `man ls`
        -   `man cd`
        -   `man man`

-   How navigate

    -   `space` to move down a page
    -   `b` to move back a page
    -   `/` search
    -   `q` exit

-   History
    -   View the previous command in history
        -   Arrow key up
        -   Ctrl+p (if the system doesn't support arrow key)
    -   View the next command in history
        -   Arrow key down
        -   Ctrl+n (if the system doesn't support arrow key)

<h3 id='ls'>ls</h3>

[Go Back to Summary](#summary)

-   `ls` - List of files on the current directory

    ```Bash
      LICENSE       README.md     git-status.sh
    ```

-   `ls -a` - List all files (including hidden)

    ```Bash
      .             ..            .git          LICENSE       README.md     git-status.sh
    ```

    -   `.` points to the current directory
    -   `..` points to the parent directory

-   `ls -l` - List files in long format

    ```Bash
      -rw-r--r--  1 roger-that  staff  1072  1 Apr 00:14 LICENSE
      -rw-r--r--  1 roger-that  staff  1831 20 Apr 10:56 README.md
      -rwxr--r--@ 1 roger-that  staff   873  1 Apr 01:23 git-status.sh
    ```

-   `ls -l -a` - Combine both `a` and `l` options

    ```Bash
      drwxr-xr-x@  6 roger-that  staff   192  1 Apr 16:15 .
      drwxr-xr-x@ 27 roger-that  staff   864 20 Apr 10:19 ..
      drwxr-xr-x@ 14 roger-that  staff   448 20 Apr 10:59 .git
      -rw-r--r--   1 roger-that  staff  1072  1 Apr 00:14 LICENSE
      -rw-r--r--   1 roger-that  staff  1831 20 Apr 10:56 README.md
      -rwxr--r--@  1 roger-that  staff   873  1 Apr 01:23 git-status.sh
    ```

-   `ls -la` - Combine both `a` and `l` options

    ```Bash
      drwxr-xr-x@  6 roger-that  staff   192  1 Apr 16:15 .
      drwxr-xr-x@ 27 roger-that  staff   864 20 Apr 10:19 ..
      drwxr-xr-x@ 14 roger-that  staff   448 20 Apr 10:59 .git
      -rw-r--r--   1 roger-that  staff  1072  1 Apr 00:14 LICENSE
      -rw-r--r--   1 roger-that  staff  1831 20 Apr 10:56 README.md
      -rwxr--r--@  1 roger-that  staff   873  1 Apr 01:23 git-status.sh
    ```

-   `ls -la .git` - List all in `/bin` in a longo format

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

-   `ls -R` - List all the files inside the folders recursively

<h3 id='cd'>cd</h3>

[Go Back to Summary](#summary)

-   `cd` - Just `cd` alone goes back to the home directory
-   `cd ..` - go back one level
-   `cd Downloads/` - change directory to downloads

<h3 id='view'>View File</h3>

[Go Back to Summary](#summary)

-   `cat README.md` - display the whole file
-   `less README.md` - display part of the file (use navigate commands)
-   `file README.md` - outputs the type of the file `README.md: ASCII text`
-   `file *` - outputs all the files and types

<h3 id='ccrmfiles'>Create Copy Remove Move Files</h3>

[Go Back to Summary](#summary)

-   `mkdir` - creates a directory

    ```Bash
      #mkdir <folder 1> <folder 2> ... <folder n>

      mkdir new_readme_folder
    ```

-   `touch` - creates an empty file

    -   We need to add the extension, otherwise, UNIX will create a new file without extension.
    -   Calling `touch` on an existing file it updates modification and access dates (only). It doesn't do anything like override or delete the whole content of the file.

    ```Bash
        #touch <file name 1> <file name 2> ... <file name n>

        touch test.txt
    ```

-   `cp` - copy files

    ```Bash
      # Copy README.md to the Desktop folder

      cp README.md ~/Desktop

      # Copay README.md to the current folder and rename as README1.md

      cp README.md README1.md
    ```

-   `cp *` - copy all the files of the current directory

-   `cp -R` - copy directories. Copy all the files and folders recursively

    ```Bash
      # cp -R <dir 1> <dir 2> ... <dir n> <destination dir>

      cp -R demo cp_demo
    ```

-   `mv` - move/rename a file

    -   Rename a file

    ```Bash
        # mv <original file name> <new file name>

        mv README.md README1.md
    ```

    -   Move file

    ```Bash
        # mv <file 1> <file 2> ... <file n> <directory path/name>

        mv README.md new_readme_folder
    ```

-   `rm` - removes a file

    ```Bash
      rm new_readme_folder/README.md
    ```

-   `rm -r` - removes the entire folder

    ```Bash
      rm new_readme_folder
    ```

-   `rm -ri` - removes the folder but asks which folder you want to remove

<h3 id='othercommands'>Other commands</h3>

[Go Back to Summary](#summary)

-   `pwd` - show the complete path of the working directory
-   `echo $BASH` - check that you using bash, output should be `/bin/bash`
-   `open` - opens the program associated with this file

    ```Bash
        open index.html             # Opens html file in the browser
        open .                      # Opens current directory in Finder
        open -a Preview picture.js  # Opens picture.jpg with Preview
    ```

<h3 id='escaping'>Escaping</h3>

[Go Back to Summary](#summary)

-   `\` - Backslash escapes a single character
-   `''` - Single quotes escapes all characters between them
-   `""` - Double quotes handle some special characters and ingores others

<h2 id='bashmoreeffectively'>Using Bash More Effectively</h2>

[Go Back to Summary](#summary)

<h3 id='wildcards'>Wildcards</h3>

[Go Back to Summary](#summary)

-   `ls a*` - list all the files/directories that starts with `a`
-   `ls *a` - list all the files/directories that ends with `a`
-   `ls *a*` - list all the files/directories that has `a`

-   Moving all types files into a folder
    -   `mv *jpeg pictures` - Move all the `.jpeg` files into `pictures` folder

<h3 id='braceexpansion'>Brace Expansion</h3>

[Go Back to Summary](#summary)

-   Generates strings
    -   Does not have to match existing filenames
-   Syntax, `pre{list,of,strings}post`

-   Create multiple files with the same extension

    ```Bash
      # input
      touch {a,b,c}.txt

      # expansion
      touch a.txt b.txt c.txt
    ```

-   Create multiple files using range

    ```Bash
      # input
      touch {a...c}{1...3}.txt

      # expansion
      touch a1.txt a2.txt ... c2.txt c3.txt
    ```

-   Move multiple files into a folder

    ```Bash
      # input
      mv file.{txt,jpg} dir/

      # output
      mv file.txt file.jpg dir
    ```

-   Brace expansion comes before wildcard expansion

    ```Bash
      # input
      mv *{txt,jpg} Documents

      # expansion
      mv *txt *jpg Documents

        # input
        mv filea?.{jpg,txt} Folder_a

        # expansion
        mv filea?.jpg filea?.txt Folder a

    ```

<h3 id='outputredirection'>Output Redirection</h3>

[Go Back to Summary](#summary)

-   Redirecting standard output stream
-   `>` Saves the output of the command to a file
    -   **ATENTION** this will overwrite existing files
    -   ls > listing.txt
    -   cat > story.txt
-   `>>` Saves the output of the command to a file, but appends the output ot the end of the file

<h4 id='pipe'>Pipe</h4>

-   Send the output of one command into the input of another command
-   `ls | less`

    ```Bash
      cut -f 3 oscar.csv | grep 4 | wc -l

      # cut       -> get command
      # -f 3      -> select the column 3
      # oscar.csv -> file
      # |         -> pipe, pass the output into the next command
      # grep 4    -> grep command - grep the string '4'
      # |         -> pipe, pass the output into the next command
      # wc        -> wc, word count
      # option -l -> count lines
    ```

<h4 id='commandsub'>Command Substitution</h4>

-   Replace a command with its output
    -   Output will become a part of the command line
    -   Put command between `$()`
        -   `echo hello, $(whoami)` output `hello, roger-that`
        -   `echo "Buy millk" > "notes$(date).txt"`, output will create a file with `Buy milk` inside.
-   Note the user of double quotes
    -   Keep command substitution intact

<h4 id='keycombinations'>Key Combinations</h4>

-   Movement Keys

    | Key    | Meaning          | Alternative   |
    | ------ | ---------------- | ------------- |
    | Ctrl+A | Start of line    |               |
    | Ctrl+E | End of line      |               |
    | Ctrl+F | Forward 1 char   | Right Arrow   |
    | Ctrl+B | Back 1 character | Left Arrow    |
    | Alt+F  | Forward 1 word   | Command+Left  |
    | Alt+B  | Back 1 word      | Command+Right |

-   Deletion Keys

    | Key    | Meaning                       | Alternative   |
    | ------ | ----------------------------- | ------------- |
    | Ctrl+D | Delete a char                 | Del           |
    | Ctrl+H | Delete a char backward        | Backspace     |
    | Alt+D  | Delete a word                 |               |
    | Ctrl+W | Delete a word backward        | Alt+Backspace |
    | Ctrl+K | Delete rest of line           |               |
    | Ctrl+U | Delete from the start of line |               |

-   Miscellaneous Keys

    | Key    | Meaning                  | Use for                  |
    | ------ | ------------------------ | ------------------------ |
    | Ctrl+C | Break                    | End a running program    |
    | Ctrl+D | End of transmition       | Exit bash, End "cat > x" |
    | Up     | Previous line in history | Ctrl+P                   |
    | Down   | Next line in history     | Ctrl+N                   |
    | Ctrl+R | Search back in history   |                          |

<h2 id='processingtext'>Filtering and Processing Text</h2>

<h3 id='texteditors'>Text Editors</h3>

<h4 id='nanoeditor'>Nano Editor</h4>

-   Create a new file `nano <file name>`

<h4 id='vieditor'>Vi Editor</h4>

| Key              | Meaning                   |
| ---------------- | ------------------------- |
| vi `<file name>` | Create a new file         |
| i                | Change to Insert Mode     |
| Esc              | Exit the Insert Mode      |
| :w               | Save a file modifications |
| :q!              | Exit Vi without saving    |
| :q               | Exit Vi                   |

<h4 id='emacseditor'>Emacs Editor</h4>

-   Create a new file `emacs <file name>`
-   `F10` opens the menu
-   `f` to open the file menu to show the commands

<h3 id='sorting'>Sort - Sorting</h3>

[Go Back to Summary](#summary)

-   Bash assumes that spaces are columns separator by default
-   By default it sorts by the ASCI values of the string, that's why the output is:

    ```Bash
      roger 100
      thaisa 100
      mike 10
      joy 40
      yumi 80
    ```

-   Sort the list alphabetically

    ```Bash
      sort <file name>
    ```

-   Sort by column

    ```Bash
      sort -rnk2 <file name>

      # sort command
      # -r, reverse the list
      # n, number
      # k2, column to look for the key (in this case 2)
    ```

-   Command `sort`
    -   Sorts file alphabetically
-   `-r` reverses sort
-   `-n` sorts numerically
-   `-k` sorts by field
    -   `sort -k 2`
    -   space-separated fields by default
-   Filter out repeated lines: `uniq`
    -   `sort attendance | uniq`
    -   `-c` counts lines

<h3 id='headtail'>Head and Tail</h3>

[Go Back to Summary](#summary)

-   Display the 10 largest files

    ```Bash
      ls -lS | head

      # ls   -> list
      # -l   -> long format
      # S    -> Size
      # |    -> pipe
      # head -> 10 first results
    ```

-   Display only one file

    ```Bash
      ls -lS | head -n 2

      # ls   -> list
      # -l   -> long format
      # S    -> Size
      # |    -> pipe
      # head -> 10 first results
      # -n 2 -> only one result (it's 2, because it always print the total size)
    ```

-   Display only one file

    ```Bash
      ls -lrS | tail -n 1

      # ls   -> list
      # -l   -> long format
      # r    -> reverse
      # S    -> Size
      # |    -> pipe
      # tail -> last 10 results
      # -n 1 -> only one result
    ```

<h3 id='couting'>WC - Counting words</h3>

[Go Back to Summary](#summary)

-   `ls | wc -l` count the number of files in the directory

<h3 id='grep'>Grep - Search and Filter Text</h3>

[Go Back to Summary](#summary)

| Key              | Meaning                               |
| ---------------- | ------------------------------------- |
| grep string file | Searches for a text in a file         |
| grep string \*   | Searches for a text in multiple files |
| -i               | makes search case-insensitive         |
| -c               | counts occurrence                     |
| -l               | shows line number of occurrences      |
| -v               | inverts the search (filter)           |

-   This commands returns all the lines in the `oscar` file that contains `Ring` with `R` uppercased

    ```Bash
      grep Rings oscar.csv
    ```

-   Find all files that contain the name `steve`

    ```Bash
      grep steve *grades
    ```

-   `-i` case insensitive
-   `-v` to filter out

    ```Bash
      grep -v lecture math_attendance | sort | uniq

      # grep              -> find all
      # -v lecture        -> filter out lecture
      # math_attendance   -> file
      # |                 -> pipe
      # sort              -> sort
      # uniq              -> unique values
    ```

-   Another option is to use regex

    -   we have to add `E` to extend

    ```Bash
      grep -Ev "^$|lecture" math_attendance | sort | uniq

      # grep              -> find all
      # -E                -> to use regex
      # -v                -> filter out
      # "^$|lecture"      -> regex to match empty line or letcture
      # math_attendance   -> file
      # |                 -> pipe
      # sort              -> sort
      # uniq              -> unique values
    ```

-   Used regex to display only directories

    ```Bash
      ls -l | grep "^d"
    ```

<h3 id='find'>Find - Search for Files</h3>

[Go Back to Summary](#summary)

-   [Find - Wikipedia](<https://en.wikipedia.org/wiki/Find_(Unix)>)

-   `find dir` - List all files in dir
-   `find dir -name f`

    -   Lists all files named `f` in dir
    -   Match expression:
        -   `find dir -name '*txt'`

    ```Bash
      find . -name '*txt' -exec grep -l curious {} \;

      # find            -> find
      # .               -> home directory
      # -name           -> file name
      # '*txt'          -> regex, contains *txt
      # -exec           -> exec
      # grep            -> search
      # -l curious      -> line of occurrences for word 'curious'
      # {} \;           -> end of command
    ```

    -   the command `grep -l curious` is executed replacing {} with the name of the file. The semicolon (backslashed to avoid the shell interpreting it as a command separator) indicates the end of the command.

<h3 id='findreplace'>Tr - Find and Replace Characters</h3>

[Go Back to Summary](#summary)

```Bash
  cat physics_grades | tr S s

  # cat physics_grades  -> Get the file
  # |                   -> pipe
  # tr S s              -> replace uppercase S to lowercase s
```

-   Another option is:

    ```Bash
      tr S s < physics_grades
    ```

-   Changes column format of a file

    ```Bash
      grep \; oscar.tsv     # first check if the file has ; (\ is to escape)
      tr \\t \; < oscar.tsv >oscars.csv

      # tr            -> replace
      # \\t           -> tabs, we have to use double \, because just tab is \t
      # \;            -> escape ;, semicolon is a especial character for bash
      # < oscar.tsv   -> from the input file .tsv
      # > oscar.csv   -> save the output into a new file .csv
    ```

<h3 id='advanced'>Advanced Tools</h3>

[Go Back to Summary](#summary)

-   `sed`

    -   Stream editor
    -   Transform text
    -   Replace words
    -   Most common use: to replace `old` with `new`

    ```Bash
      sed 's/curiouser/stranger/g' demo/alice > alice2

      # s/curiouser/stranger/  -> replace text curiouser with stranger
      # g                      -> replace every occurrence in every line
    ```

-   `awk
    -   Complete programming language
    -   Very useful for column-oriented files

<h3 id='columnbase'>Column-based Data</h3>

[Go Back to Summary](#summary)

-   Sort

    ```Bash
      sort -nk2 -t\; oscar.csv | tail

      # sort          -> sort by
      # -n            -> number
      # k2            -> key (column) 2
      # -t\;          -> type of separator, if we are using a something different from tab
      # oscar.csv     -> file name
      # |             -> pipe
      # tail          -> show the last 10 oscars (sorted by year, column 2)
    ```

-   Cut

    ```Bash
      cut -f 1,2 -d\;
      # cut           -> show
      # -f 1,2        -> which field to show column 1 and 2
      # -d\;          -> the delimiter, if we don't specify anything bash uses tab
    ```

<h2 id='jobs'>Jobs and Processes</h2>

<h3 id='background'>Background Jobs</h3>

[Go Back to Summary](#summary)

-   only send jobs to the background that doesn't need user input
-   background jobs cannot read inputs
    -   if the program tries, bash will suspend it and let you know
-   Tip: After the job is done, bash will display on the screen
    -   Redirect the output to a file `find . > all_files &`
-   `^Z` -> Ctrl + Z stops the current job
-   `fg` -> resume the job
-   `bg` -> send the job to the background
-   `&` -> adds to the background, we don't have to `^z` then `bg`

<h3 id='killingprogram'>Killing Jobs and Process</h3>

[Go Back to Summary](#summary)

-   Foreground program: `^c`
-   End any program with `kill`
-   Kill by job id:

    -   `kill %2` - kills the job id 2 in the current bash terminal
    -   `kill %cp` - kills the pid

-   `jobs` - list of jobs running
-   `ps -ax` - Show all the process id

-   To filter for a specific program

    ```Bash
      ps ax | grep -i calc

      # ps ax     -> Show all process id
      # |         -> pipe
      # grep      -> find
      # -i        -> case-insensitive
      # program
    ```

<h3 id='inspectingprocesses'>Inspecting Processes</h3>

[Go Back to Summary](#summary)

-   `jobs`
    -   Shows bash jobs for current shell
-   `ps`
    -   Display all your processes running under a terminal
    -   `ps ax`
        -   Display all processes
    -   `ps aux`
        -   Display all processes including owner

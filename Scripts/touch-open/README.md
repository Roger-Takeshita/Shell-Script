# touch

- Create multiple folders and files with one command

- Add a new alias to your `zhr/bash`:

  - `alias touch='./your_path/touch-open.sh'`

- Search if path and file already exist, otherwise, it will create the folder(s) and the file

  - if we pass `-n` as the first argument, the script wont open the files after creating them
    - `touch -n test/test.js test1/test1.js`
    - My default editor is the VSCode
  - if we pass `+` between files, it will create the next file inside the previous folder, we can nest multiple folder/files
    - unfortunately we can't go back to the previous folder, we can only create the file on the same level or above
  - if we pass a path without an extension, the program understands that we want to create a folder

    - `touch folder/subfolder`
    - `touch outside1.js head1/node1/tail1/leaf1.js + leaf2.js head2/node2/node2a/tail2a/leaf2a1.js + leaf2a2.js head2/node2/node2b/tail2b/leaf2b1.js + leaf2b2.js`

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

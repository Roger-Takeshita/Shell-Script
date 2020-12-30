# NPM INSTALL

If you are using iCloud (**only**) to save your codes, this scripts moves the `node_modules` libraries into a **no sync** folder.

If `node_modules` exists:

- Renames `node_modules` to `node_modules.nosync`

If `node_modules` doesn't exist

- Creates `node_modules.nosync` then creates `node_modules` alias from `node_modules.nosync`. This prevents uploading `node_modules` to iCloud.
- This won't change anything into our project, we can normally install new modules.

# Git tricks

## How to untrack a file in git
- ### Keep the local file for you, but will delete it for anyone else when they pull.
```bash
git rm -r --cached <folder-name>
```
```bash
git rm --cached <file-name>
```
- ### Index will be reset and file(s) overwritten if there are upstream changes to the file/folder (when you pull).
```bash
git update-index --assume-unchanged <path-name>
```
- ### Tell git you want your own independent version of the file or folder. For instance, you don't want to overwrite (or delete) production/staging config files
- File
```bash
git update-index --skip-worktree explorer/connection-profile/test-network.json
```
```bash
git update-index --no-skip-worktree explorer/connection-profile/test-network.json
```
- Directory
```bash
cd directory
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && pwd && git ls-files -z ${pwd} | xargs -0 git update-index --skip-worktree" \;
```
```bash
cd directory
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && pwd && git ls-files -z ${pwd} | xargs -0 git update-index --no-skip-worktree" \;
```

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

### Cache Your Login Credentials
```bash
git config --global credential.helper cache
```

### View Commit History With Changes
```bash
git log -p
```

### View Changes Before Committing
- ### Working directory
```bash
git diff
```
- ### Stagging area
```bash
git diff --staged
```

## Unstaged
- ### Unstaged a specific file
```bash
git reset HEAD example.txt
```
- ### Unstaged all
```bash
git reset HEAD
```

## Unchange
- ### Unchange a specific file
```bash
git checkout example.txt
```
- ### Unchange all
```bash
git checkout .
```

## Make changes to the previously committed files
```bash
git add .
git commit --amend --no-edit
```

## Rollback Last Commit
- ### This will create a new commit, an inverse of the previous commit, and add it to the current branch history.
```bash
git revert HEAD
```

## Rollback a Particular Commit
- ###  It will create a new commit, a copy of the provided commit ID, and add it to the current branch history
```bash
git revert 1af17e
```

## Graph git log
```bash
git log --graph --oneline --decorate
```
```bash
git log --all --graph --oneline --decorate
```

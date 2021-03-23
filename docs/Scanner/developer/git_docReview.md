# Contributing to docs

From [romi-robots-docs](https://github.com/romi/romi-robots-docs), we incorporate changes using a typicall git workflow with commits and pull requests.

## git clone romi-robots-docs
```bash
git clone https://github.com/romi/romi-robots-docs.git
```
## Create your local branch
There is no dev branch: the main branch is `master`, that directly incorporate all changes.
```bash
git checkout master # go to master
git pull # update it with last changes
git checkout -b my_branch  # create local branch `my_branch` (it will derived from the last master)
git push --set-upstream origin my_branch  # attach branch `my_branch` to `origin/my_branch`. GitHub login/password will be asked for.
```

## Visualize your changes locally on a web browser
```bash
mkdocs serve # reads the mkdocs.yml file to generate the web page.
```

browser connected http://127.0.0.1:8000/

issues are listed and can be modified

## Adding images in the content
store in assets

## Commit your changes 
This follow the classical git commit procedure:
```bash
git status #list all files affected by changes
git add/restore/rm <file> #do as many action as listed in red by the previous command
(git status) #optional: verify that all changes are staged and ready for commit)
git commit -m "my awesome commit"
git push # push modification to `origin/my_branch`
(git log) #optional: verify that your commit is recorded
```

## Merge your working branch with current master: rebase is needed
Assuming that your working branch is called `my_branch`
```bash
git checkout master #switch to master
git pull #update in case changes were made in the meantime: now you have the lastest master branch
git checkout my_branch #switch again to the branch to merge
git rebase master # rebase `master` branch onto `my_branch`
``` 
if the last command indicates conflicts, it means that `master` and `my_branch` have diverged during your work. For each files listed by git:
- fix the conflicts by directly editing the file
- stage your changes with:
```bash
git add file1
```
- continue the rebase with:
```bash
git rebase --continue
```
Finally, once all conflicts have been resolved and changes staged, Push the rebasing to remote central repo:
```bash
git push -f origin my_branch #-f (force) implies that login/password will be asked for.
```
## test a branch (e.g. for a pull request review)
```bash
git checkout test_branch #switch to 'test_branch'. /!\ do not switch to origin/test_branch since your working locally
git fetch #Download objects and refs from the remote branch on /origin
git pull #Incorporates changes from the remote repository into the current local `test_branch`
mkdocs serve #serve the docs website on the local server
```
You can view the display, test the links, etc...

## make your review on GitHub web interface
comment the PR, file by file. Point to issues if any.

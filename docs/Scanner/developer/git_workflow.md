# Git Workflow

## Rules

1. NEVER EVER work on `master` or `dev`, always on a branch!
2. Always rebase your destination branch onto the one you want to merge before doing it!

## Clone & configure the repository
It all starts by cloning the repository you want to contribute to, *e.g.* `romiscan`:
```bash
git clone https://github.com/romi/romiscan.git  # clone the repository
```

## Create development branch
To contribute to development you have to create a branch on which you will work.

1. Let's start by pulling the latest developments by updating our local `dev` branch
    ```bash
    git checkout dev  # go to your local dev branch
    git pull  # update it
    ```
2. Then create your new branch `my_branch` and set tracking to remote central repo (`origin`)
    ```bash
    git checkout -b my_branch  # create local branch `my_branch`
    git push --set-upstream origin my_branch  # attach branch `my_branch` to `origin/my_branch`. Login/password will be asked for.
    ```

## Work on your modifications
Edit file(s) and add them to git for tracking then commit your changes (to your local copy) and push then to remote central repository: 
```bash
git add mynewfile.py
git commit -m "This is my awesome commit!"
git push  # push modification to `origin/my_branch`
```

### How do I not forget changes for committing ? 
Commits that affect only a limited number of files are preferable to track changes and history. However, some work require to modify several files. Especially when working with an IDE allowing easy exploring and modifications of all you repository content, you may forget some of the changes you did. 

**To quickly identify all current files with uncommited changes in your current branch, just simply check with `git status` on your local branch.**

The terminal lists in a **red color all files requiring an action** (git add, git restore, git remove): modified files, deleted files, newly added files.

!!! Note
    after acting on listed red files, typing `git status` should turn all previous files in green. Your branch is ready for committing.

Then just proceed as above with `git commit` and `git push`.

### check your commit has been pushed
you can get the list of commits related to your current branch with `git log` (press `q` to exit the list in the terminal).

## Prepare your work for merging
Once you are ready for creating a "Pull Request", let's update our branch with potential change to `origin/dev` since branching occurred.

1. Get latest version of `origin/dev`:
    ```bash
    git checkout dev  # checkout your local `dev` branch
    git pull  # update it
    ```
2. Perform rebase of `origin/dev` onto `my_branch`:
    ```bash
    git checkout my_branch  # create and checkout branch `my_branch`
    git rebase dev  # rebase `dev` branch onto `my_branch`
    ```
3.  If `dev` has diverged during your work, fix conflicts, then say to git that conflicts are resolved (*e.g.* for file1):
    ```bash
    git add file1
    git rebase --continue  # to finish rebase
    ```
4. Push the rebasing to remote central repo:
    ```bash
    git push -f origin my_branch #-f (force) implies that login/password will be asked for.
    ```

Then you can create your "Pull Request" from this latest commit using the GitHub interface.
Don't forget to add reviewer.
Now if you have a CI job checking the instability and performing tests, you may have to wait it all goes well before merging.


## Finalization: delete integrated branches.
Check if you find all yours commits on `origin/dev` (either on GitHub interface of using `git log` in this branch), if yes:
```bash
git branch --delete my_branch  # delete local development branch
git push origin :my_branch  # delete development branch on origin
```
!!! note
    `git branch -a` lists all the local branches first (with the current branch in green), followed by the remote-tracking branches in red.

## Revert a commit
You can revert the last commit with:
```bahs
git reset HEAD^
```
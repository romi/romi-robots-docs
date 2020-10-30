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
    git push --set-upstream origin my_branch  # attach branch `my_branch` to `origin/my_branch`
    ```


## Work on your modifications
Edit file(s) and add them to git for tracking then commit your changes (to your local copy) and push then to remote central repository: 
```bash
git add mynewfile.py
git commit -m "This is my awesome commit!"
git push  # push modification to `origin/my_branch`
```


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
    git push -f origin my_branch
    ```

Then you can create your "Pull Request" from this latest commit using the GitHub interface.
Don't forget to add reviewer.
Now if you have a CI job checking the instability and performing tests, you may have to wait it all goes well before merging.


## Finalization
Check if you find all yours commits on `origin/dev`, if yes:
```bash
git branch --delete my_branch  # delete local development branch
git push origin :my_branch  # delete development branch on origin
```

## Revert a commit
You can revert the last commit with:
```bahs
git reset HEAD^
```
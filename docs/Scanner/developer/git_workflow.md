# Git Workflow

Many workflows are possible when using a version control system like `git`.
To clarify how we use it in the ROMI project we hereafter details our choices and show ho to performs the most basic tasks to participate in the development of the ROMI libraries.

## Rules

Here are some very important rules, be sure to understand them first!

1. NEVER EVER work on `master` or `dev`, always on a branch!
2. ALWAYS **rebase** your destination branch onto the one you want to merge before doing it!
3. `dev` is the integration branch, `master` is the release branch

## Clone & configure the repository

It all starts by cloning the repository you want to contribute to, *e.g.* `plant3dvision`:

```shell
git clone https://github.com/romi/plant3dvision.git  # clone the repository
```

To use all possible git actions on this repository ('repo'), go the location of this local clone

```shell
cd plant3dvision  #the repo is cloned at the point where you executed the previous command (git clone). If you moved the clone repo, prefix with path like: cd path/to/yourcloned/plant3dvision
```

## Create development branch

To contribute to development you have to create a branch on which you will work.

1. Let's start by pulling the latest developments by updating our local `dev` branch
    ```shell
    git checkout dev  # switch to your -local- `dev` branch
    git fetch  # fetch changes from remote (`origin/dev`)
    git pull  # pull changes (if any) from remote to local 
    ```
2. Then create your new branch `<my_branch>` and set tracking to remote central repo (`origin/<my_branch>`)
    ```shell
    git checkout -b <my_branch>  # create local branch `<my_branch>`
    git push --set-upstream origin <my_branch>  # attach local branch `<my_branch>` to remote `origin/<my_branch>`. Login/password will be asked for.
    ```

!!! note
    Setting the branch tracking can be done later, even after committing changes to local repository!

## Work on your modifications

We advise to use a proper IDE (like PyCharm or Atom) with an integrated or plugin based _git tool_ for this part, as manually adding a lot of files can be time-consuming.
Overall you will benefit from a nicer and faster integration of this particular step.

Nevertheless, for the sake of clarity, hereafter we detail how to do that with the `git` command-line interface.

### Tracking new files

If you create a new file, you will have to tell git to track its changes with:

```shell
git add <my_new_file.py>
```

### Adding changes to local repository

After editing your files (_e.g._ `<my_file1.py>` `<my_file2.py>`), tell git to _validate_ the changes to these files by adding them to the list of tracked changes with:

```shell
git add <my_file1.py> <my_file2.py>
```

Then commit them to your local repository:

```shell
git commit -m "This is my awesome commit!"
```

### Pushing changes to remote repository

Once you are satisfied with the state of your work, you can push the locally committed changes to the remote central repository:

```shell
git push  # push modification to `origin/<my_branch>`
```

!!! important
    Try to do this `add/commit/push` sequence as often as you can!!

### How do I not forget changes for committing ?

Commits that affect only a limited number of files are preferable to track changes and history.
However, some work require to modify several files.
Especially when working with an IDE allowing easy exploring and modifications of all the repository content, you may forget some changes you did.

**To quickly identify all current files with uncommitted changes in your current branch, just simply check with `git status` on your local branch.**

The terminal lists in a **red color all files requiring an action** (git add, git restore, git remove): modified files, deleted files, newly added files.

!!! Note
    after acting on listed red files, typing `git status` should turn all previous files in green. Your branch is ready for committing.

Then just proceed as above with `git commit` and `git push`.

### check your commit has been pushed

After `git push`, you can get the list of pushed commits related to your current branch with `git log` (press `q` to exit the list in the terminal).

## Prepare your work for merging

Once you are ready for creating a "Pull Request", let's update (_rebase_ in git) our branch with potential remote changes (`origin/dev`) since branching
occurred.

!!! important
    Start with step 1 & 2 and performs step 3 only if the branch where you are trying to integrate your work have diverged!

1. Get the latest version of `origin/dev`:
    ```shell
    git checkout dev  # checkout your local `dev` branch
    git fetch  # fetch remote changes
    git pull  # pull remote changes (if any) to local 
    ```
2. Rebase of `origin/dev` onto `<my_branch>`:
    ```shell
    git checkout <my_branch>  # checkout the branch to rebase
    git rebase dev  # rebase `dev` branch onto `<my_branch>`
    ```
3. If `dev` has diverged during your work:
    1. if you have conflicts:
        1. fix them using an IDE
        2. say to git that conflicts are resolved (*e.g.* for `<my_file1.py>`):
            ```shell
            git add <my_file1.py>
            ```
        3. continue rebase until all changes are applied:
            ```shell
            git rebase --continue  # to finish rebase
            ```
    2. push all changes (your rebased modifications) to the remote repository:
        ```shell
        git push -f origin <my_branch>
        ```

!!! warning
    Using the `-f` option is necessary after a rebase as local and remote are now different (as show by a `git status`).
    This will _force push_ the  changes done after rebasing.

Then you can create your "Pull Request" from this latest commit using the GitHub interface.
Don't forget to add reviewer.
Now if you have a CI job checking the instability and performing tests, you may have to wait it all goes well before merging.

## Finalization: delete integrated branches.

Check if you find all yours commits on `origin/dev` (either on GitHub interface of using `git log` in this branch), if yes:

```shell
git branch --delete my_branch  # delete local development branch
git push origin :my_branch  # delete development branch on origin
```

!!! note
    `git branch -a` lists all the local branches first (with the current branch in green), followed by the remote-tracking branches in red. `git branch` only lists your local branches.

## Revert a commit

You can revert the last commit with:

```shell
git reset HEAD^
```

### Update the project board (Kanban type)

Go to: https://github.com/orgs/romi/projects

* choose the project board corresponding to your pull request (PR)
* link your PR to existing issues
* move the corresponding note to the appropriate column
# Contributing to docs

From [romi-robots-docs](https://github.com/romi/romi-robots-docs), we incorporate changes using a typical git workflow with commits and pull requests.
The documentation is generated using [MkDocs](https://www.mkdocs.org/).

## Objectives

At the end of this tutorial, you should be able to:

* create content for romi-robots-docs
* review modifications suggested for romi-robots-docs by you colleagues

## Prerequisite
  1. Install git

  2. Install Mkdocs 

### 1. Install git
* [Install git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* Example in Linux system with a Debian-based distribution (e.g. Ubuntu):
  ```shell
  git --version #verify that you have git installed: it should return the version (e.g. git version 2.25.1)
  #if git is not installed:
  $ sudo apt install git-all
  ```
* git clone romi-robots-docs

```shell
git clone https://github.com/romi/romi-robots-docs.git
cd romi-robots-docs  #enter the cloned repository so that all git actions are available 
```
### 2. Install mkdocs
* install command (e.g. on Linux, see the [specific documentation](https://www.mkdocs.org/user-guide/installation/) for more detailed instructions )

```
sudo apt install mkdocs
sudo pip3 install mkdocs-material #this extension of mkdocs is required
```

Note: if the second installation fails, you may consider installing or updating pip3:

```
sudo apt-get install python3-pip
```

Then re-run gain the command: `sudo pip3 install mkdocs-material`
## Step-by-step tutorial

if you only review an existing branch (without adding or modifying content), go directly to steps 8/9.

### 1. Create your local branch

The default branch is `master`, that directly incorporate all changes. There is no dev branch.
**Never ever work on `master`**: create a local branch to make changes, using the following commands:

```shell
git checkout master  # go to master
git pull  # update it with last changes
git checkout -b my_branch  # create local branch `my_branch` (it will derived from the last master)
git push --set-upstream origin my_branch  # attach branch `my_branch` to `origin/my_branch`. GitHub login/password will be asked for.
```

### 2. Visualize your changes locally on a web browser in an interactive manner

```shell
mkdocs serve  # reads the mkdocs.yml file to generate the web page.
```

The terminal gives you information. The programs starts by building the documentation.
As soon as you can read:
> [I 210323 08:58:22 server:335] Serving on http://127.0.0.1:8000

..., you can connect your favorite web browser by copy-pasting the url or just (ctrl+click) on the address to open it in your default browser.

The program `mkdocs serve` constantly watches for changes and refreshes the build as soon as they are detected, as indicated by the terminal:
>[I 210323 08:58:22 handlers:62] Start watching changes
INFO    -  Start watching changes

>[I 210323 08:58:22 handlers:64] Start detecting changes
INFO    -  Start detecting changes
Since the refresh is very rapid upon changes, you can then see in live the effect of you modifications.

In the terminal, possible issues are listed (INFO and WARNING),pointing to problems that should be fixed:

In this case, pages should be added in the `nav` section of the `mkdocs.yml` file (see later point 4.). In the interactive browser, you cannot see and display pages that does not exist in the "nav" configuration.

* internal hyperlink issues (WARNING):

> WARNING - Documentation file 'xxx/xxxx/file1.md' contains a link to 'xxx/yyy/otherfile.md' which is not found in the documentation files.

In this case, check and modify the hyperlink in *file1.md* to provide good redirection to *otherfile.md*

### 3. Adding images in the content

* store the image files in assets/. You can also directly provide html address for third party images if you are sure that the link will be stable over time.
* To have more flexibility and options for images layout, use the html command in your markdown file:

```
<img src="/assets/images/my_image.png" alt="name_displayed_if_error" width="600" style="display:block; margin-left: auto; margin-right: auto;"> # here the style centers the picture
```

### 4. Modify the navigation in mkdocs.yml

Open `mkdocs.yml` at the root of `romi-robots-docs` repo.

Some changes **must be** reported in this file in the `nav` section: when you create a new page (a new `file.md`) or a new directory, or modify the name of an
existing file.md/directory.

In the `nav` section, you can also enter the name given to pages in the menu.

### 5. Commit your changes

This follow the classical git commit procedure:

```shell
git status  #list all files affected by changes
git add/restore/rm <file>  #do as many action as listed in red by the previous command
(git status)  #optional: verify that all changes are staged and ready for commit)
git commit -m "my awesome commit"
git push  # push modification to `origin/my_branch`
(git log)  #optional: verify that your commit is recorded
```

### 6. Merge your working branch with current master: rebase may be needed

Assuming that your working branch is called `my_branch`

```shell
git checkout master  #switch to master
git pull  #update in case changes were made in the meantime: now you have the latest master branch
git checkout my_branch  #switch again to the branch to merge
git rebase master  # rebase `master` branch onto `my_branch`
``` 

if the last command indicates conflicts, it means that `master` and `my_branch` have diverged during your work.
For each files listed by git:

- fix the conflicts by directly editing the file
- stage your changes with:

```shell
git add file1
```

- continue the rebase with:

```shell
git rebase --continue
```

Finally, once all conflicts have been resolved and changes staged, Push the rebasing to remote central repo:

```shell
git push -f origin my_branch  #-f (force) implies that login/password will be asked for.
```

### 7. Prepare a PR on GitHub webpage

* Go to the distant romi repository : https://github.com/romi/romi-robots-docs
* select you branch and prepare a PR: open a pull request (green button), enter a brief text to explain the modifications, assign reviewers (in the right column
  of the page), and press the green button 'create pull request'.

### 8. test a distant branch (e.g. for a pull request review from your colleagues)

```shell
git checkout test_branch  #switch to 'test_branch'. /!\ do not switch to origin/test_branch since your working locally
git fetch  #Download objects and refs from the remote branch on /origin
git pull  #Incorporates changes from the remote repository into the current local `test_branch`
mkdocs serve  #serve the docs website on the local server
```

You can view the display, test the links, etc...
You can also create a new branch from it to modify it.

### 9. make your review on GitHub web interface

Comment the pull requests (PR), file by file. Point to issues if any.

### 10. Use the project board (Kanban type)

Go to: https://github.com/orgs/romi/projects/10

* link your PR to existing issues
* move the corresponding note to the appropriate column (To do / In progress / Test / Done)

## TROUBLESHOOTING

### Warning messages
They points to files reported in the mkdocs.yml but not existing in the current documentation. This is not an rugent issue sine the doculentation can be built despite these raised warnings. Consider modifying the indicated files.
### Fatal errors occuring after executing `mkdocs serve`
* module 'materialx.emoji'
> cannot find module 'materialx.emoji' (No module named 'materialx')

**solution**: execute `sudo pip3 install mkdocs-material`

* 'gitsnippet'
> ERROR    -  Config value: 'plugins'. Error: The "gitsnippet" plugin is not installed

**solution**: execute `pip install mkdocs-gitsnippet-plugin`

* 'decorator'
> ERROR    -  The 'decorator' distribution was not found and is required by the application

**solution**: execute `pip install decorator`

* 'wcwidth'
> ERROR    - The 'wcwidth' distribution was not found and is required by prompt-toolkit

**solution**: execute `pip install wcwidth`
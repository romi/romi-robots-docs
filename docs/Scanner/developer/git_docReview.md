# Contributing to docs

From [romi-robots-docs](https://github.com/romi/romi-robots-docs), we incorporate changes using a typicall git workflow with commits and pull requests. the documentation is generated using [MkDocs](https://www.mkdocs.org/).

## Objectives
At the end of this tutorial, you should be able to:
* create content for romi-robots-docs
* review modifications suggested for romi-robots-docs
## Prerequisite
* [Install git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* Example in Linux system with a Debian-based distribution (e.g. Ubuntu):
  ```bash
    git --version #verify that you have git installed: it should return the version (e.g. git version 2.25.1)
    #if git is not installed:
    $ sudo apt install git-all
  ```
* git clone romi-robots-docs
```bash
git clone https://github.com/romi/romi-robots-docs.git
cd romi-robots-docs #enter the cloned repository so that all git actions are available 
```
## Step-by-step tutorial
if you only review an existing branch (without adding or modifying content), go directly to step xx.
### 1. Create your local branch
The default branch is `master`, that directly incorporate all changes. There is no dev branch.
**Never ever work on `master`**: create a local branch to make changes, using the following commands:
```bash
git checkout master # go to master
git pull # update it with last changes
git checkout -b my_branch  # create local branch `my_branch` (it will derived from the last master)
git push --set-upstream origin my_branch  # attach branch `my_branch` to `origin/my_branch`. GitHub login/password will be asked for.
```

### 2. Visualize your changes locally on a web browser in an interactive manner
```bash
mkdocs serve # reads the mkdocs.yml file to generate the web page.
```
The terminal gives you information. The programs starts by building the documentation.
As soon as you can read:
> [I 210323 08:58:22 server:335] Serving on http://127.0.0.1:8000

..., you can connect your prefered web browser by copy-pasting the served url in the url bar: http://127.0.0.1:8000/ or just (ctrl+click) on the address to open it in your default browser.

The program `mkdocs serve` constently watches for changes and refreshes the build as soon as they are detected, as indicated by the terminal:
>[I 210323 08:58:22 handlers:62] Start watching changes
INFO    -  Start watching changes

>[I 210323 08:58:22 handlers:64] Start detecting changes
INFO    -  Start detecting changes
Since the refresh is very rapid upon changes, you can then see in live the effect of you modifications.

In the terminal, possible issues are listed (INFO and WARNING),pointing to problems that should be fixed: 
* navigation issues (INFO):
> INFO    -  The following pages exist in the docs directory, but are not included in the "nav" configuration:

In this case, pages should be added in the `nav` section of the `mkdocs.yml` file (see later point 4.). In the interactive browser, you cannot see and display pages that does not exist in the "nav" configuration.

* internal hyperlink issues (WARNING):
> WARNING -  Documentation file 'xxx/xxxx/file1.md' contains a link to 'xxx/yyy/otherfile.md' which is not found in the documentation files.

In this case, check and modify the hyperlink in *file1.md* to provide good redirection to *otherfile.md*

### 3. Adding images in the content
* store the image files in assets/. You can also directly provide html adress for third party images if you are sure that the link will be stable over time.
* To have more flexibility and options for images layout, use the html command in your markdown file:
```
<img src="/assets/images/my_image.png" alt="name_displayed_if_error" width="600" style="display:block; margin-left: auto; margin-right: auto;"> # here the style centers the picture
```

### 4. Modify the navigation in mkdocs.yml
Open `mkdocs.yml` at the root of `romi-robots-docs` repo. 

Some changes **must be** reported in this file in the `nav` section: when you create a new page (a new `file.md`) or a new directory, or modify the name of an existing file.md/directory.

In the `nav` section, you can also enter the name given to pages in the menu.

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

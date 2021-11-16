+++
description = "How to make changes in gigadb-website repo"
title = "Github usage example"
date = 2020-05-19T15:55:27+08:00
tags = ["github", "gigadb-website", "develop"]
author = "Ken Cho"

+++
## The development cycle of the gigadb.  
 
### 1. fork [gigadb-website](https://github.com/gigascience/gigadb-website)

### 2. clone the gigadb-website into local SSD  
```git clone https://github.com/kencho51/gigadb-website.git```

### 3. add remote origin  
```git remote add origin https://github.com/kencho51/gigadb-website.git```

### 4. add remote upstream origin
```git remote add upstream https://github.com/gigascience/gigadb-website.git```

### 5. follow [here](https://github.com/kencho51/gigadb-website/tree/develop) to build the docker container for the testing.  

### 6. The flow to make changes:  

6.1 Create branch for an issue
```git branch issue-no```  

6.2 Go to that branch  
```git checkout issue-no```  

6.3 Make some changes, save and add the changes      
```git add modifiedfiles```  

6.4 Commit the changes with msg    
```git commit -m 'commit msg'``` 

6.5 Push the changes to the git repo     
```git push```  

6.6 Create pull request to review in web git repo    
- Precise and concise description of the changes.
 
6.7 Delete the branch if the pull request closed and merged  
```git branch -d issue-no```  


### 7. How to undo commits, steps follow [here](https://devconnected.com/how-to-undo-last-git-commit/)  

7.1 To undo the last commit, for example:    
`git reset --hard HEAD~1`  
`git push --force`  

### 8. How to [sync with Fork repo](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/syncing-a-fork) after making a successful pull request  
`git checkout develop`  
`git fetch upstream` to see any updates from the develop fork   
`git rebase upstream/develop` to get the updates from develop fork to local  
`git push origin` to update the remote repo  

#### Ways to merge remote and local branch
1. `git cherry-pick`  
2. `git rebase`  
3. `git pull` is essentially shorthand for `git fetch` followed by `git merge`  
4. `git pull --rebase` is shorthand for a fetch and a rebase  

### 9. How to delete a branch after the issue has been fixed
   
9.1 To list all the branch.  
`git branch --list`  
9.2 To switch to another branch.    
`git checkout branch_name`  
9.3 To delete a branch.  
`git branch -d branch_name_to_delete`  
9.4 To update the remote.  
`git push --force`  
9.5 To delete branch in remote repo manually.  
9.6 To clean up local branch after merging  
`git fetch -p`  

### How To Clean Up Git Branches at [here](https://devconnected.com/how-to-clean-up-git-branches/) or [stackoverflow](https://stackoverflow.com/questions/6127328/how-can-i-delete-all-git-branches-which-have-been-merged)

### 10. How to handle multiple github accounts on MacOS?

10.1 Creating the SSH keys. For each SSH key pairs  
`ssh-keygen -t rsa -b 4096 -C "kencho.gigascience@gmail.com`

10.2 Register your keys to the respective GitHub accounts  
Follow steps [here](https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account)

10.3 Change SSH config file at `~/.ssh` and amend accordingly to  
```ssh
#kencho51 account
Host github.com-kencho51
   HostName github.com
   User git
   IdentityFile ~/.ssh/github-kencho51
   IdentitiesOnly yes
```

10.4 Ensure your remote url is in the right format  
```shell script
origin  https://github.com/kencho51/gigadb-website.git (fetch)
origin  https://github.com/kencho51/gigadb-website.git (push)
upstream        https://github.com/gigascience/gigadb-website.git (fetch)
upstream        https://github.com/gigascience/gigadb-website.git (push)
```

Set up correct links in office mac:  
`git remote set-url origin https://github.com/kencho51/gigathing.git gigathing`  
`git remote set-url origin https://github.com/kencho51/kencho51.github.io kencho51.github.io`

10.5 Check the correct remote url setting  
`git remote -v`

10.5 Go ahead to git clone your respective repository  
`git clone git@github.com-kencho51:kencho51/gigathing.git gigathing`


### How to change commited commit message?
1. Use `git rebase -i HEAD~` command to display a list of the last n commits in your default text editor.  
`$ git rebase -i HEAD~3 # Displays a list of the last 3 commits on the current branch`
2. A similar list will be produced as below:
```vim
pick e499d89 Delete CNAME
pick 0c39034 Better README
pick f7fde4a Change the commit message but push the same commit.

# Rebase 9fdb3bd..f7fde4a onto 9fdb3bd
#
# Commands:
# p, pick = use commit
# r, reword = use commit, but edit the commit message
# e, edit = use commit, but stop for amending
# s, squash = use commit, but meld into previous commit
# f, fixup = like "squash", but discard this commit's log message
# x, exec = run command (the rest of the line) using shell
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
# Note that empty commits are commented out
```
3. Replace `pick` with `reword` before each commit message you want to change.
```vim
pick e499d89 Delete CNAME
reword 0c39034 Better README
reword f7fde4a Change the commit message but push the same commit.
```
4. Save and close the commit list file.
5. In each resulting commit file, type the new commit message, save the file, and close it.
6. Force-push the amended commits.  
`git push --force`

### How To Cherry Pick Git Commits at [here](https://devconnected.com/how-to-cherry-pick-git-commits/)

### How to check out PR and test locally
1. Fetch the PR's pseudo-branch
`git fetch upstream pull/id/head:whatever-name-you-want`  
2. Switch to that branch  
`git checkout whatever-name-you-want`  
3. Start to test the code

### Reference
1. [5 Git Commands You Should Know, with Code Examples](https://www.freecodecamp.org/news/5-git-commands-you-should-know-with-code-examples/)
2. [learngitbranching](https://learngitbranching.js.org/)
3. [Handling Multiple Github Accounts on MacOS](https://gist.github.com/Jonalogy/54091c98946cfe4f8cdab2bea79430f9)
4. [Developing with multiple GitHub accounts on one MacBook](https://medium.com/@ibrahimlawal/developing-with-multiple-github-accounts-on-one-macbook-94ff6d4ab9ca)
5. [6 best practices for teams using Git](https://opensource.com/article/20/7/git-best-practices?utm_medium=Email&utm_campaign=weekly&sc_cid=7013a000002glehAAA)
6. [The life-changing magic of git rebase -i](https://opensource.com/article/20/4/git-rebase-i)
7. [Getting started with Git: Terminology 101](https://opensource.com/article/19/2/git-terminology)
8. [How to change commit message](https://docs.github.com/en/enterprise/2.13/user/articles/changing-a-commit-message)
9. [How to open a pull request](https://www.freecodecamp.org/news/how-to-make-your-first-pull-request-on-github-3/)
10. [How to sync your form with the original git repository](https://www.freecodecamp.org/news/how-to-sync-your-fork-with-the-original-git-repository/)
11. [Set up git from Rija](https://gist.github.com/rija/170bba283968893bbabb887f0aeeef6a)
12. [How to check out PR and test locally](https://gist.github.com/rija/170bba283968893bbabb887f0aeeef6a)
13. [How to test a PR locally before merge](https://medium.com/@bolajiayodeji/how-to-test-a-pull-request-locally-before-merging-634bb205d3a6)
[![Build Status](https://travis-ci.org/kencho51/gigathing.svg?branch=master)](https://travis-ci.org/kencho51/gigathing)

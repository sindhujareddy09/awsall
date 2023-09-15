#### Session Video
  

#### Version Control System / Source Code Management : Git

Getting Started with VCS//SCM
What is Git, AWS CodeCommit and GitHub?
About Version Control System and types
Git Workflow
Installing on Windows & Linux
Getting Started with Git Command
Working with Branches
Merging Branches
Creating and Committing a Pull Request
Working with Stash
Summary

#### Here is a list of some common Git commands:

    git init: Initializes a new Git repository in the current directory.

    git clone: Clones an existing Git repository from a remote location to your local machine.

    git add: Adds changes to the staging area.

    git commit: Commits changes to the repository.

    git status: Shows the status of the working directory and staging area.

    git log: Shows the commit history.

    git branch: Lists all branches in the repository.

    git checkout: Switches to a different branch or commit.

    git merge: Merges changes from one branch into another.

    git pull: Fetches changes from a remote repository and merges them into the local branch.

    git push: Sends changes from the local branch to a remote repository.

    git stash: Saves changes temporarily without committing them.

    git tag: Creates a new tag for a specific commit.

    git remote: Shows the remote repositories linked to the local repository.

    git fetch: Fetches changes from a remote repository without merging them into the local branch.

#### Here are some Git commands with examples:

    ```
    git init: Initializes a new Git repository in the current directory.
    
    $ git init
    Initialized empty Git repository in /path/to/repository
    git clone: Clones an existing Git repository from a remote location to your local machine.
    ```

```
$ git clone https://github.com/user/repository.git
Cloning into 'repository'...
remote: Counting objects: 100, done.
remote: Compressing objects: 100% (80/80), done.
remote: Total 100 (delta 20), reused 100 (delta 20), pack-reused 0
Receiving objects: 100% (100/100), done.
Resolving deltas: 100% (20/20), done.
git add: Adds changes to the staging area.
```

```
$ git add file.txt
git commit: Commits changes to the repository.

```

```
$ git commit -m "Commit message"
[main 12a34b5] Commit message
 1 file changed, 1 insertion(+)
git status: Shows the status of the working directory and staging area.
```

```
$ git status
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   file.txt
git log: Shows the commit history.
```

```
$ git log
commit 12a34b5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0g1h (HEAD -> main)
Author: John Doe <john.doe@example.com>
Date:   Mon Feb 21 10:00:00 2022 -0500

    Commit message
git branch: Lists all branches in the repository.
```

```
$ git branch
  main
* feature-branch
git checkout: Switches to a different branch or commit.
```

```
$ git checkout main
Switched to branch 'main'
git merge: Merges changes from one branch into another.
```

```
$ git merge feature-branch
Merge made by the 'recursive' strategy.
  file.txt | 2 ++
  1 file changed, 2 insertions(+)
git pull: Fetches changes from a remote repository and merges them into the local branch.
```

```
$ git pull origin main
From https://github.com/user/repository
 * branch            main       -> FETCH_HEAD
Updating 12a34b5d6e7f..23b45c6d7e8f
Fast-forward
 file.txt | 1 +
 1 file changed, 1 insertion(+)
git push: Sends changes from the local branch to a remote repository.
```

```
$ git push origin main
Counting objects: 4, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (4/4), 358 bytes | 358.00 KiB/s, done.
Total 4 (delta 1), reused 0 (delta 0)
```

Source Control Management / Version Control System / Source Code Management :

Two Solutions :

CLI/CUI : git 

CLI/CUI SCM/VCS :  Git [ Linus Torvalds --> 2005 & Linux Kernel ] --> Ubuntu, Debian, RHEL, CentOS, etc...

GUI :  GitHub, GitLab, BitBucket, AWS CodeCommit, & Azure Repos [ Web-based Git repository hosting service ]

    1. GitHub : 
        - git + GUI 
    
    2. GitLab :
        - git + GUI 
    
    3. BitBucket
        - git + GUI 

    4. AWS CodeCommit
        - git + GUI 
    
    5. Azure Repos 
        - git + GUI 

Public & Private Repositories

GitHub, GitLab, BitBucket 

Private Repositories :

AWS CodeCommit & Azure Repos

# ----------------------------------------------------------------- #

Source Control Management / Version Control System / Source Code Management :

CLI : git 

GUI Vendors : 

Public & Private Repositories
    1. github 
    2. gitlab 
    3. bitbucket 

Private Repositories
    4. aws codecommit  
    5. azure repos 

CLI/CUI SCM/VCS :  Git [ Linus Torvalds --> 2005 & Linux Kernel ] --> Ubuntu, Debian, RHEL, CentOS, etc...

GUI SCM/VCS : GitHub, GitLab, BitBucket, AWS CodeCommit & Azure Repos

Software development teams to collaborate communicate in order to
quickly solve problems and deliver new features.

What we store : Source Code / Raw Code

Create a secure repository to store and share your code.

What we do : Public & Private Repositories

GitHub, GitLab, BitBucket [ Web-based Git repository hosting service ]

Private Repositories :

AWS CodeCommit & Azure Repos  [ Web-based Git repository hosting service ]

Distributed Version Control System :

Source Control Management / Source Code Management / Version Control System : 

GIT : Software [ CLI/CUI  ] Public & Private Repositories

Git is a distributed revision control system with an emphasis on speed data integrity and support for distributed non-linear workflows.
Git was initially designed and developed by Linus Torvalds for Linux kernel development in 2005 and has since become the most widely 
adopted version control system for software development.

GITHUB : [ WEB-BASED | GUI ] | Public & Private Repositories
GitHub is a web-based Git repository hosting service which offers all of the distributed revision control and source code management 
(SCM) functionality of Git as well as adding its own features. 

Unlike Git which is strictly a command-line tool GitHub provides a web-based graphical interface and desktop as well as
 mobile integration. GitHub offers both commercial plans and free accounts.

GITLAB SCM : [ WEB-BASED | GUI ] | Public & Private Repositories
GitLab's SCM (source code management) solution supports software development teams to collaborate communicate in order to 
quickly solve problems and deliver new features. GitLab offers both commercial plans and free accounts.

ATLASSIAN BITBUCKET : [ WEB-BASED | GUI ] | Public & Private Repositories
Bitbucket is a web-based hosting service for projects that use either the Mercurial (since launch) or 
Git (since October 2011[1]) revision control systems. Bitbucket offers both commercial plans and free accounts.

AWS CodeCommit : [ WEB-BASED | GUI ] | Private Repositories
    - Create a secure repository to store and share your code.

Azure Repos : [ WEB-BASED | GUI ] | Private Repositories


https://education.github.com/git-cheat-sheet-education.pdf

https://www.atlassian.com/git/tutorials/atlassian-git-cheatsheet

https://about.gitlab.com/images/press/git-cheat-sheet.pdf

https://ndpsoftware.com/git-cheatsheet.html#loc=index;
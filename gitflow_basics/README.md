# GitFlow - Basics

![alt text](https://github.com/fernandomatsuosantos/code_samples/blob/main/gitflow_basics/simplified-gitflow-model.png?raw=true)

## New Pull Request

```bash
# -----------------------------------
# Create a branch from the latest commit on develop
# -----------------------------------
# Switch to the develop branch
git checkout develop
# Update the local repository
git pull origin develop
# Create a new feature branch and switch to it
git checkout -b feature/JIRA-1234-feature-branch-description
# Create a new feature branch and switch to it
# Do the stuff you have to do (introduce features, modify existing stuff, whatever, etc)...
# Add modified files to the staging area
git add -A (to add all modified files)
# Or
git add <file_name> (to add individual files)
# Commit the changes
git commit -m "JIRA-1234: Add tags to the resources"
# Push the changes
git push origin feature/JIRA-1234-feature-branch-description
# Go to the repository page and click on "Pull Request" button.
# Switch back to the develop branch
git checkout develop
```

## Using stash:

```bash
# Store your changes temporarily in the stash and removes them from the working directory
git stash
# Go back to develop
git pull origin develop
# Make the changes necessary on develop and then go back to feature branch
git checkout feature/JIRA-1234-feature-branch-description
# Restores the changes which you have stored in the stash
git stash apply
git stash drop
```

## Force Pull (Overwrite local changes):

```bash
# Downloads the latest from remote without trying to merge or rebase anything
git fetch --all
#Then the git reset resets the develop branch to what you just fetched. 
#The --hard option changes all the files in your working tree to match the files in origin/develop
git reset --hard origin/develop
#Pulls from the remote repository over to the local copy
git pull origin develop
```

## Rebase (Resolve merge conflicts)

```bash
#Checkout to the feature branch
git checkout feature/JIRA-1234-feature-branch-description
#Pull the latest changes from the remote feature branch
git pull origin feature/JIRA-1234-feature-branch-description
#Pull the latest changes from the remote develop branch
git pull origin develop
#Resolve conflicts if any
git add -A
git commit -m "Fix merge conflicts"
#Now push
git push origin feature/JIRA-1234-feature-branch-description
```

## Useful commands

```bash
#Set Name & E-mail address at Git config
git config --global user.name "fernando"
git config --global user.email "fernando@my-email.com"
git config --list
#Initialize a new repository
git init
#Clone a repository to the local machine
git clone "https://github.com/repository/Infrastructure-as-Code.git"
#See which files were modified before being added to the staging area
git status
#Add a specific file to the staging area
git add <file_name>
#Add all modified files to the staging area
git add -A
#Commit changes in the working directory
git commit -m "JIRA-1234: Add tags to the resources"
#Push committed changes
git push origin develop
#View all commits history
git log
git log --author="fernando"
#Show the differences between the working directory and the remote repository
git diff
#Show the differences between the working directory and the remote repository (staged files)
git diff --staged
#Ensure the local repository is in sync with the remote repository
git pull origin develop
# Create a new feature branch and switch to it
git checkout -b feature/JIRA-1234-feature-branch-description
# Change feature branch
git checkout feature/JIRA-1234-feature-branch-description
# Reset change
git checkout --filename
# Reset all changes
git fetch origin
git reset --hard origin/develop
```
